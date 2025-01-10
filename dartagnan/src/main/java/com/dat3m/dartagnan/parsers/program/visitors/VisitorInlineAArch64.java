package com.dat3m.dartagnan.parsers.program.visitors;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.expression.ExpressionFactory;
import com.dat3m.dartagnan.expression.Type;
import com.dat3m.dartagnan.expression.integers.IntCmpOp;
import com.dat3m.dartagnan.expression.type.AggregateType;
import com.dat3m.dartagnan.expression.type.BooleanType;
import com.dat3m.dartagnan.expression.type.IntegerType;
import com.dat3m.dartagnan.expression.type.TypeFactory;
import com.dat3m.dartagnan.parsers.InlineAArch64BaseVisitor;
import com.dat3m.dartagnan.parsers.InlineAArch64Parser;
import com.dat3m.dartagnan.program.Function;
import com.dat3m.dartagnan.program.Register;
import com.dat3m.dartagnan.program.event.Event;
import com.dat3m.dartagnan.program.event.EventFactory;
import com.dat3m.dartagnan.program.event.Tag;
import com.dat3m.dartagnan.program.event.core.Label;

public class VisitorInlineAArch64 extends InlineAArch64BaseVisitor<Object> {

    private class CompareExpression {

        public Expression compareExpression;
        public Register firstRegister;
        public Expression secondRegister;
        public Expression zeroRegister; // used to have register with value 0

        public CompareExpression() {
            this.zeroRegister = expressions.parseValue("0", integerType);
        }

        public void updateCompareExpression(Register firstRegister, IntCmpOp intCmpOp, Expression secondRegister) {
            this.firstRegister = firstRegister;
            this.secondRegister = secondRegister;
            this.compareExpression = expressions.makeIntCmp(firstRegister, intCmpOp, secondRegister);
        }

        public void updateCompareExpressionOperator(IntCmpOp intCmpOp) {
            this.compareExpression = expressions.makeIntCmp(this.firstRegister, intCmpOp, this.secondRegister);
        }

    }

    private final List<Event> events = new ArrayList<>();
    private final Function llvmFunction;
    private final Register returnRegister;
    private final ExpressionFactory expressions = ExpressionFactory.getInstance();
    private final TypeFactory types = TypeFactory.getInstance();
    private final IntegerType integerType = types.getIntegerType(32);
    private final CompareExpression comparator; // class used to use compare and set flags
    private final HashMap<String, Label> labelsDefined;
    private final HashMap<String, Register> armToLlvmMap; // maps arm names to LLVM names
    private final List<Expression> pendingRegisters; // used to create the final aggregatetype
    // armtollvm part
    private final LinkedList<Expression> fnParameters;
    private String[] returnRegisterTypes;
    private final int returnValuesNumber;
    private final int MAX_FN_CALLS = 10; // this is used to keep track of how many fn calls I am going to use -- upper bound for $N

    LinkedList<String> registerNames;

    public VisitorInlineAArch64(Function llvmFunction, Register returnRegister, Type returnType, ArrayList<Expression> argumentsRegisterAddresses) {
        this.llvmFunction = llvmFunction;
        this.returnRegister = returnRegister;
        this.comparator = new CompareExpression();
        this.labelsDefined = new HashMap<>();
        this.pendingRegisters = new LinkedList<>();
        this.armToLlvmMap = new HashMap<>();
        this.registerNames = new LinkedList<>();
        this.fnParameters = new LinkedList<>(argumentsRegisterAddresses); //reverseAndGetFnParams(llvmFunction.getParameterRegisters()); // these hold the original fn arguments
        // todo set this to empty if we see something like (bv 0), as it is going to be a useless fence
        this.returnValuesNumber = initReturnValuesNumberInitReturnRegisterTypes(returnType);
        assert (this.returnValuesNumber >= 0);
        // populateRegisters(armToLlvmMap);
    }

    public List<Event> getEvents() {
        return this.events;
    }

    /* given the VariableInline as String it picks up if it is a 32 or 64 bit */
    public Type getArmVariableSize(String variable) {
        int width = - 1;
        if (variable.length() == 2 || variable.length() == 4) { // can be either $n or [$n]
            return this.fnParameters.getLast().getType(); // get type of $n, which is fnParams(0)
        } else if (variable.startsWith("${") && variable.endsWith("}")) {
            if (isPartOfReturnRegister(variable)) {
                int number = Integer.parseInt(Character.toString(variable.charAt(2)));
                Type returnRegisterProjectionType = expressions.makeExtract(number, returnRegister).getType();
                return returnRegisterProjectionType;
            }
            char letter = variable.charAt(4);
            switch (letter) {
                case 'w' ->
                    width = 32;
                case 'x' ->
                    width = 64;
                default ->
                    throw new UnsupportedOperationException("Unrecognized pattern for variable : does not fit into ${NUM:x/w}");
            }
        }
        return types.getIntegerType(width);
    }

    //these are used to populate the armToLlvmMap
    private int initReturnValuesNumberInitReturnRegisterTypes(Type returnType) {
        if (returnType instanceof IntegerType || returnType instanceof BooleanType) {
            String[] singleton = {returnType.toString()};
            this.returnRegisterTypes = singleton;
            return 1;
        } else if (returnType instanceof AggregateType at) {
            String str = at.toString();
            this.returnRegisterTypes = str.substring(1, str.length() - 1).trim().split(",");
            return at.getTypeOffsets().size();
        } else if (returnType == null) {
            return 0;
        } else {
            return -1;
        }
    }

    private Type getTypeGivenReturnTypeString(String typeString) {
        Type res = null;
        String trimmed = typeString.contains(":") ? typeString.split(":")[1].trim() : typeString.trim();
        switch (trimmed) {
            case "ptr" ->
                res = types.getPointerType();
            case "bv32" ->
                res = types.getIntegerType(32);
            case "bv64" ->
                res = types.getIntegerType(64);
            default ->
                throw new UnsupportedOperationException("The given type as String is not recognized!");
        }
        return res;
    }

    // TODO should be deprecated
    private void populateRegisters(HashMap<String, Register> armToLlvmMap) {
        int fnParamLen = this.fnParameters.size();
        if (fnParamLen == 0) {
            return;
        }
        // the rule is like this 
        // $n means r0, n \in Nats to "keep an id of the function"
        // the first ${n:w}s are used to lock return values e.g. ${0:w}, ${1:w} means it is going to return 2 values in LLVM (if we're in a void fn we skip it)
        // the other ones are the remaining args
        // It should be n:w for 32 bit and n:x for 64 bit, but to make it easier I just allocate every type to be ok
        // now mapped to the real registers of llvm function

        // new rule
        // first, allocate 0:w...n for the return registers
        // then, map n:w....end to the new given list
        // the last element is going to be $N \mapsto last element of the list!
        // still need to tweak add rule with a custom mapping tho :/
        if (returnRegister == null) {
            if (this.fnParameters == null) {
                return; //we're in a fence fn
            }
            for (int i = 0; i < fnParamLen - 1; i++) {
                String key = String.format("${%d:w}", i);
                String keyLong = String.format("${%d:x}", i);
                Register value = (Register) fnParameters.get(i);
                armToLlvmMap.put(key, value);
                armToLlvmMap.put(keyLong, value);
            }
        } else {
            if (returnRegisterTypes.length == 1) {
                Type type = getTypeGivenReturnTypeString(this.returnRegisterTypes[0]);
                String key = returnRegisterKey(type, 0);
                armToLlvmMap.put(key, this.returnRegister);
            } else {
                if (this.returnValuesNumber == 4) {
                    // we're in the special case of "add".
                    // since it allocates 3 values manually, it means that the rule changes to this
                    // 1) allocate 0:w.... to the local variables -> they are going to overlap with the return registers, so it is hard to design a general solution
                    // 2) allocate $n and the rest for fn parameters
                    // check paper
                    for (int i = 0; i < this.returnValuesNumber; i++) {
                        Type type = getTypeGivenReturnTypeString(this.returnRegisterTypes[i]);
                        String key = returnRegisterKey(type, i);
                        Register tmp = getOrNewRegister(key);
                        if (i == 1 || i == 2) {
                            events.add(EventFactory.newLocal(tmp, expressions.parseValue("0", (IntegerType) type)));
                        }
                        if (i == 3) {
                            events.add(EventFactory.newLocal(tmp, this.fnParameters.get(1)));
                        }
                    }
                }
                // for (int i = 0; i < this.returnValuesNumber; i++) {
                //     Type type = getTypeGivenReturnTypeString(this.returnRegisterTypes[i]);
                //     String key = returnRegisterKey(type,i);
                //     Register tmp = getOrNewRegister(key); // avoid null registers in guard of comparison
                // }
            }
            int registerCounter = 0;
            for (int i = returnValuesNumber; i < returnValuesNumber + fnParamLen - 1; i++) {
                Register value = (Register) fnParameters.get(registerCounter);
                Type type = value.getType();
                String key = returnRegisterKey(type, i);
                registerCounter++;
                armToLlvmMap.put(key, value);
            }
        }
        for (int i = 0; i < this.MAX_FN_CALLS; i++) {
            String key = String.format("$%d", i);
            Register value = (Register) this.fnParameters.get(fnParamLen - 1);
            armToLlvmMap.put(key, value);
        }
        System.out.println("Status is " + armToLlvmMap);
    }

    private String returnRegisterKey(Type type, int index) {
        String key = String.format("${%d:w}", index);
        if (type.toString().equals("bv64")) {
            key = key.replace("w", "x");
        }
        return key;
    }

    // used if the return is AggregateType (size > 1)
    // has to be changed for armv7
    private boolean isPartOfReturnRegister(String registerName) {
        if (!(registerName.startsWith("${") || registerName.endsWith("}"))) {
            return false;
        }
        int number = Integer.parseInt(Character.toString(registerName.charAt(2)));
        return ((number < this.returnValuesNumber) && (this.returnValuesNumber > 1));
    }

    private Label getOrNewLabel(String labelName) {
        Label label;
        if (this.labelsDefined.containsKey(labelName)) {
            label = this.labelsDefined.get(labelName);
        } else {
            label = EventFactory.newLabel(labelName);
            this.labelsDefined.put(labelName, label);
        }
        return label;
    }

    private Register getOrNewRegister(String nodeName) {
        // if it is not in armToLlvmMap create the new register
        if (this.armToLlvmMap.containsKey(nodeName)) {
            return this.armToLlvmMap.get(nodeName);
        } else {
            // make the new register
            Type type = getArmVariableSize(nodeName);
            String registerName = makeRegisterName(nodeName);
            Register newRegister = llvmFunction.newRegister(registerName, type);
            this.armToLlvmMap.put(nodeName, newRegister);
            if (isPartOfReturnRegister(nodeName)) {
                this.pendingRegisters.add(newRegister);
            }
            // if (this.nameToRegisterMap.containsKey(nodeName)) {
            //     return this.nameToRegisterMap.get(nodeName);
            // } else {
            //     Type type = getArmVariableSize(nodeName);
            //     String registerName = makeRegisterName(nodeName);
            //     Register newRegister = llvmFunction.newRegister(registerName, type);
            //     this.nameToRegisterMap.put(nodeName, newRegister);
            //     if (isPartOfReturnRegister(nodeName)) {
            //         this.armToLlvmMap.put(nodeName, newRegister);
            //         // int number = Integer.parseInt(Character.toString(nodeName.charAt(2)));
            //         // assignment = expressions.makeExtract(number, returnRegister); // no need to initialize returnRegister at start
            //         this.pendingRegisters.add(newRegister);
            //     } else {
            //         Expression assignment = this.armToLlvmMap.get(nodeName);
            //         if (this.returnRegister == null || !((Register) assignment).equals(this.returnRegister)) {
            //             events.add(EventFactory.newLocal(newRegister, assignment));
            //         }
            //     }
            return newRegister;
        }
    }

    private String makeRegisterName(String nodeName) {
        return "r" + nodeName;
    }

    private String cleanLabel(String label) {
        return label.replaceAll("(\\d)[a-z]", "$1");
    }

    private void updateReturnRegisterIfModified(Register register) {
        String registerName = register.getName();
        if (registerName.length() > 3) {
            int registerId = Integer.parseInt(Character.toString(register.getName().charAt(3)));
            if (registerId == 0 && this.returnValuesNumber == 1) { // it can only match if it is 0:w/x AND return value is single -- the aggregatetype is already covered 
                System.out.println("Return register is " + this.returnRegister.getName() + " And modified one is " + register.getName());
                events.add(EventFactory.newLocal(this.returnRegister, register));
            }
        }
    }

    @Override
    public Object visitAsm(InlineAArch64Parser.AsmContext ctx) {
        int commaPos = ctx.getText().lastIndexOf("\",\"");
        String[] instructions = ctx.getText().substring(0, commaPos).split("\\\\0A"); // Instructions part
        String[] clobbers = ctx.getText().substring(commaPos + 3, ctx.getText().length() - 1).split(","); // Clobbers part, excluding the surrounding quotes
        boolean pointerAdded = false;
        for (String instruction : instructions) {
            System.out.println(instruction);
            int len = instruction.length();
            for (int i = 0; i < len; i++) {
                char c = instruction.charAt(i);
                if (c == '$') {
                    if (i + 1 < instruction.length() && instruction.charAt(i + 1) == '{') {
                        int closeIndex = instruction.indexOf('}', i);
                        if (closeIndex != -1) {
                            String register = instruction.substring(i, closeIndex + 1);
                            if (!registerNames.contains(register)) {
                                this.registerNames.add(register);
                            }
                            i = closeIndex + 1;
                        }
                    } else if (i + 1 < instruction.length() && Character.isDigit(instruction.charAt(i + 1))) {
                        String register = instruction.substring(i, i + 2);
                        if (!registerNames.contains(register)) {
                            this.registerNames.add(register);
                        }
                        pointerAdded = true;
                    }
                } else if (c == '[' && i + 1 < instruction.length() && instruction.charAt(i + 1) == '$') {
                    int closeIndex = instruction.indexOf(']', i);
                    if (closeIndex != -1) {
                        String register = instruction.substring(i, closeIndex + 1);
                        if (!registerNames.contains(register)) {
                            this.registerNames.add(register);
                        }

                        pointerAdded = true;
                        i = closeIndex + 1;
                    }
                }
            }
        }
        Collections.sort(registerNames);
        if (pointerAdded) { // this is used to check if the list has a $n. I want this one to be the last element in the list
            String pointerRegister = registerNames.removeFirst();
            registerNames.addLast(pointerRegister);
        }
        // now for the clobber part
        if (!registerNames.isEmpty() && !this.fnParameters.isEmpty()) {
            System.out.println("RegisterNames is " + registerNames);
            int registerNameIndex = 0;
            for (String clobber : clobbers) {
                if (clobber.matches("\\d+")) {
                    // https://llvm.org/docs/LangRef.html#input-constraints
                    // For example, a constraint string of “=r,0” says to assign a register for output, and use that register as an input as well (it being the 0’th constraint).
                    // so we have to get the i-th return Value and map it to fnParams
                    int number = Integer.parseInt(clobber);
                    if (number >= 0 && number <= this.returnValuesNumber) {
                        String name = registerNames.get(number);
                        // Map the register to the corresponding function parameter
                        Register toBeChanged = getOrNewRegister(name);
                        events.add(EventFactory.newLocal(toBeChanged, this.fnParameters.get(registerNameIndex - this.returnValuesNumber)));
                    } else {
                        System.err.println("The number provided in the clobber is not a valid index for any return value");
                    }
                } else if (clobber.equals("=*m")) {
                    //if clobber is =*m it means that such pointer is a memory location, so we do not map to any register, we just increase registerNameIndex as we don't want to pick it up
                    registerNameIndex++;
                } else if (!clobber.startsWith("~")) {
                    System.out.println("Evaluating clobber " + clobber + " with registerNameIndex " + registerNameIndex);
                    // if it is a valid clobber create the register
                    String registerName = registerNames.get(registerNameIndex);
                    Register newRegister = getOrNewRegister(registerName);
                    armToLlvmMap.put(this.registerNames.get(registerNameIndex), newRegister);
                    if (clobber.equals("=&r") || clobber.equals("=r")) {
                        // USELESS initialize to 0 
                        // Type type = getTypeGivenReturnTypeString(this.returnRegisterTypes[registerNameIndex]);
                        // events.add(EventFactory.newLocal(newRegister, expressions.parseValue("0", (IntegerType) type)));
                        // maps to returnValue, so we do nothing(?)
                    } else if (clobber.equals("r") || clobber.equals("Q")) {
                        // it has to be mapped to fnParams do as such
                        events.add(EventFactory.newLocal(newRegister, this.fnParameters.get(registerNameIndex - this.returnValuesNumber)));
                    } else {
                        System.out.println("New type of clobber found, you have to add it! " + clobber);
                    }
                    registerNameIndex++;
                }
            }
        }
        // new (AGAIN) rule
        // clobbers can be either 
        // =&r which means I can write into => going to map to the returnValues
        // r which means read only
        // Q is a memory address, or can also be an r if I also have =*m like in ck

        /*
         * index = 0
         * for each clobber in clobbers:
         *      if clobber == '&=r':
         *          allocate returnValue register
         *          index += 1
         *      elif clobber == 'r' || clobber == 'Q':
         *          map clobbers[index] to fnParams(index-k ) or something
         */
        // in the end I'd expect something like "=&r,=&r,=&r,r,Q" to be 3 return values, clobbers[3] maps to fnParams[0] and clobbers[4] maps to fnParams[1] 
        // old rule I guess
        // 1. first return values
        // 2. all of the other ones to fnParams ( if I see a $n it should be a pointer so has to be last one!)
        // create the registers 
        // newRegister WIth asm name <- fnParams
        // if (!this.registerNames.isEmpty()) {
        //     int index = 0;
        //     if (this.returnValuesNumber == 4) { // 'add' corner case
        //         for (int i = 0; i < this.returnValuesNumber; i++) {
        //             Register tmp = getOrNewRegister(this.registerNames.get(index));
        //             if (i == 1 || i == 2) {
        //                 events.add(EventFactory.newLocal(tmp, expressions.parseValue("0", this.integerType))); // maybe it is not necessary
        //             }
        //             if (i == 3) {
        //                 events.add(EventFactory.newLocal(tmp, this.fnParameters.get(1)));
        //             }
        //         }
        //     } else {
        //         if (this.returnValuesNumber == 1) { // if we have just one returnValue we allocate
        //             // else is handled by the visitMetadata 
        //             Register newRegister = getOrNewRegister(this.registerNames.get(index));
        //             armToLlvmMap.put(this.registerNames.get(index), newRegister);
        //             events.add(EventFactory.newLocal(newRegister, expressions.parseValue("0", this.integerType)));
        //         } else { // trying initializing with 0 to suppress the warning -- does not work
        //             while (index < this.returnValuesNumber) {
        //                 Register newRegister = getOrNewRegister(this.registerNames.get(index));
        //                 armToLlvmMap.put(this.registerNames.get(index), newRegister);
        //                 Type type = getTypeGivenReturnTypeString(this.returnRegisterTypes[index]);
        //                 events.add(EventFactory.newLocal(newRegister, expressions.parseValue("0", (IntegerType) type)));
        //                 index++;
        //             }
        //         }
        //         // now we can allocate the ('args') part
        //         index = this.returnValuesNumber;
        //         if (this.fnParameters != null) {
        //             for (Expression register : this.fnParameters) {
        //                 Register newRegister = getOrNewRegister(this.registerNames.get(index));
        //                 armToLlvmMap.put(this.registerNames.get(index), newRegister);
        //                 events.add(EventFactory.newLocal(newRegister, register));
        //                 index++;
        //             }
        //         }
        //     }
        // }
        System.out.println("Currently the map contains " + armToLlvmMap);
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadReg(InlineAArch64Parser.LoadRegContext ctx) {
        Register register = (Register) ctx.register(0).accept(this);
        Register address = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newLoad(register, address));
        updateReturnRegisterIfModified(register);
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadAcquireReg(InlineAArch64Parser.LoadAcquireRegContext ctx) {
        Register register = (Register) ctx.register(0).accept(this);
        Register address = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newLoadWithMo(register, address, Tag.ARMv8.MO_ACQ));
        updateReturnRegisterIfModified(register);
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadExclusiveReg(InlineAArch64Parser.LoadExclusiveRegContext ctx) {
        Register register = (Register) ctx.register(0).accept(this);
        Register address = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newRMWLoadExclusive(register, address));
        updateReturnRegisterIfModified(register);
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadAcquireExclusiveReg(InlineAArch64Parser.LoadAcquireExclusiveRegContext ctx) {
        Register register = (Register) ctx.register(0).accept(this);
        Register address = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newRMWLoadExclusiveWithMo(register, address, Tag.ARMv8.MO_ACQ));
        updateReturnRegisterIfModified(register);
        return visitChildren(ctx);
    }

    @Override
    public Object visitAdd(InlineAArch64Parser.AddContext ctx) {
        Register resultRegister = (Register) ctx.register(0).accept(this);
        Register leftRegister = (Register) ctx.register(1).accept(this);
        Register rightRegister = (Register) ctx.register(2).accept(this);
        Expression exp = expressions.makeAdd(leftRegister, rightRegister);
        updateReturnRegisterIfModified(resultRegister);
        events.add(EventFactory.newLocal(resultRegister, exp));
        return visitChildren(ctx);
    }

    @Override
    public Object visitSub(InlineAArch64Parser.SubContext ctx) {
        Register resultRegister = (Register) ctx.register(0).accept(this);
        Register leftRegister = (Register) ctx.register(1).accept(this);
        Register rightRegister = (Register) ctx.register(2).accept(this);
        Expression exp = expressions.makeSub(leftRegister, rightRegister);
        updateReturnRegisterIfModified(resultRegister);
        events.add(EventFactory.newLocal(resultRegister, exp));
        return visitChildren(ctx);
    }

    @Override
    public Object visitOr(InlineAArch64Parser.OrContext ctx) {
        Register resultRegister = (Register) ctx.register(0).accept(this);
        Register leftRegister = (Register) ctx.register(1).accept(this);
        Register rightRegister = (Register) ctx.register(2).accept(this);
        // Expression leftBoolCast = expressions.makeBooleanCast(leftRegister);
        // Expression rightBoolCast = expressions.makeBooleanCast(rightRegister);
        Expression exp = expressions.makeIntOr(leftRegister, rightRegister);
        updateReturnRegisterIfModified(resultRegister);
        events.add(EventFactory.newLocal(resultRegister, exp));
        return visitChildren(ctx);
    }

    @Override
    public Object visitAnd(InlineAArch64Parser.AndContext ctx) {
        Register resultRegister = (Register) ctx.register(0).accept(this);
        Register leftRegister = (Register) ctx.register(1).accept(this);
        Register rightRegister = (Register) ctx.register(2).accept(this);
        // Expression leftBoolCast = expressions.makeBooleanCast(leftRegister);
        // Expression rightBoolCast = expressions.makeBooleanCast(rightRegister);
        Expression exp = expressions.makeIntAnd(leftRegister, rightRegister);
        updateReturnRegisterIfModified(resultRegister);
        events.add(EventFactory.newLocal(resultRegister, exp));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreReg(InlineAArch64Parser.StoreRegContext ctx) {
        Register value = (Register) ctx.register(0).accept(this);
        Register address = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newStore(address, value));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreReleaseReg(InlineAArch64Parser.StoreReleaseRegContext ctx) {
        Register value = (Register) ctx.register(0).accept(this);
        Register address = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newStoreWithMo(address, value, Tag.ARMv8.MO_REL));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreExclusiveRegister(InlineAArch64Parser.StoreExclusiveRegisterContext ctx) {
        Register freshResultRegister = (Register) ctx.register(0).accept(this);
        Register value = (Register) ctx.register(1).accept(this);
        Register address = (Register) ctx.register(2).accept(this);
        events.add(EventFactory.Common.newExclusiveStore(freshResultRegister, address, value, Tag.ARMv8.MO_RX));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreReleaseExclusiveReg(InlineAArch64Parser.StoreReleaseExclusiveRegContext ctx) {
        Register freshResultRegister = (Register) ctx.register(0).accept(this);
        Register value = (Register) ctx.register(1).accept(this);
        Register address = (Register) ctx.register(2).accept(this);
        events.add(EventFactory.Common.newExclusiveStore(freshResultRegister, address, value, Tag.ARMv8.MO_REL));
        return visitChildren(ctx);
    }

    @Override
    public Object visitCompare(InlineAArch64Parser.CompareContext ctx) {
        Register firstRegister = (Register) ctx.register(0).accept(this);
        Register secondRegister = (Register) ctx.register(1).accept(this);
        this.comparator.updateCompareExpression(firstRegister, IntCmpOp.EQ, secondRegister);
        return visitChildren(ctx);
    }

    @Override
    public Object visitCompareBranchNonZero(InlineAArch64Parser.CompareBranchNonZeroContext ctx) {
        Register registerLlvm = (Register) ctx.register().accept(this);
        this.comparator.updateCompareExpression(registerLlvm, IntCmpOp.NEQ, this.comparator.zeroRegister);
        String cleanedLabelName = cleanLabel(ctx.LabelReference().getText());
        Label label = getOrNewLabel(cleanedLabelName);
        events.add(EventFactory.newJump(this.comparator.compareExpression, label));
        return visitChildren(ctx);
    }

    @Override
    public Object visitMove(InlineAArch64Parser.MoveContext ctx) {
        Register toRegister = (Register) ctx.register(0).accept(this);
        Register fromRegister = (Register) ctx.register(1).accept(this);
        events.add(EventFactory.newLocal(toRegister, fromRegister));
        updateReturnRegisterIfModified(toRegister);
        return visitChildren(ctx);
    }

    @Override
    public Object visitBranchEqual(InlineAArch64Parser.BranchEqualContext ctx) {
        String cleanedLabelName = cleanLabel(ctx.LabelReference().getText());
        Label label = getOrNewLabel(cleanedLabelName);
        this.comparator.updateCompareExpressionOperator(IntCmpOp.EQ);
        events.add(EventFactory.newJump(this.comparator.compareExpression, label));
        return visitChildren(ctx);
    }

    @Override
    public Object visitBranchNotEqual(InlineAArch64Parser.BranchNotEqualContext ctx) {
        String cleanedLabelName = cleanLabel(ctx.LabelReference().getText());
        Label label = getOrNewLabel(cleanedLabelName);
        this.comparator.updateCompareExpressionOperator(IntCmpOp.NEQ);
        events.add(EventFactory.newJump(this.comparator.compareExpression, label));
        return visitChildren(ctx);
    }

    @Override
    public Object visitLabelDefinition(InlineAArch64Parser.LabelDefinitionContext ctx) {
        String labelDefinitionNoColumn = ctx.LabelDefinition().getText().replace(":", "");
        Label label = getOrNewLabel(labelDefinitionNoColumn);
        events.add(label);
        return visitChildren(ctx);
    }

    @Override
    public Object visitAsmMetadataEntries(InlineAArch64Parser.AsmMetadataEntriesContext ctx) {
        if (this.returnValuesNumber > 1) {
            List<Type> typesList = new LinkedList<>();
            for (Expression r : this.pendingRegisters) {
                typesList.add(((Register) r).getType());
            }
            Type aggregateType = types.getAggregateType(typesList);
            // Register returnRegisterMapper = llvmFunction.newRegister(aggregateType);
            Expression finalAssignExpression = expressions.makeConstruct(aggregateType, this.pendingRegisters);
            events.add(EventFactory.newLocal(this.returnRegister, finalAssignExpression));
        }
        return visitChildren(ctx);
    }

    @Override
    public Object visitRegister(InlineAArch64Parser.RegisterContext ctx) {
        // TerminalNode register = ctx.Register() != null ? ctx.VariableInline() : ctx.ConstantInline();
        return getOrNewRegister(ctx.Register().getText());
    }
}
