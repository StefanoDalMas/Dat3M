package com.dat3m.dartagnan.parsers.program.visitors;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.antlr.v4.runtime.tree.TerminalNode;

import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.expression.ExpressionFactory;
import com.dat3m.dartagnan.expression.Type;
import com.dat3m.dartagnan.expression.integers.IntCmpOp;
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
        public Register secondRegister;
        public boolean storeSucceeded; // holds 0 if last store was successful
        public Register zeroRegister; // used to mock the check of a register read

        public CompareExpression() {
            this.storeSucceeded = false;
            this.zeroRegister = llvmFunction.getOrNewRegister("MOCK_ZERO_REGISTER", integerType);
        }

        public void updateCompareExpression(Register firstRegister, IntCmpOp intCmpOp, Register secondRegister) {
            this.firstRegister = firstRegister;
            this.secondRegister = secondRegister;
            this.compareExpression = expressions.makeIntCmp(firstRegister, intCmpOp, secondRegister);
        }

        public void updateCompareExpressionOperator(IntCmpOp intCmpOp) {
            this.compareExpression = expressions.makeIntCmp(this.firstRegister, intCmpOp, this.secondRegister);
        }

        public void updateStoreSucceeded(boolean status) {
            if (!status) {
                System.out.println("Last store was successful");
            }
            this.storeSucceeded = status;
        }
    }

    private class LlvmToArmRegisterMapping{
        // the rule is like this 
        // $n means r0, n \in Nats to "keep an id of the function"
        // the first ${n:w}s are used to lock return values e.g. ${0:w}, ${1:w} means it is going to return 2 values in LLVM
        // the other ones are the remaining args
        private final List<Register> returnValues;
        private final int returnValuesNumber;
        private final HashMap<String,String> llvmToArmMap;

        public LlvmToArmRegisterMapping(Function llvmFunction,Type returnType){
            this.llvmToArmMap = new HashMap<>();
            this.returnValues = llvmFunction.getParameterRegisters();
            this.returnValuesNumber = assignReturnValues(returnType);
            System.out.println(returnValuesNumber);
            assert(this.returnValuesNumber >= 0);
            // now we have to fill our map
            for (int i = 0; i < returnValuesNumber; i++){
                String key = String.format("${%d:w}", i);
                String value = this.returnValues.get(i).getName();
                llvmToArmMap.put(key,value);
            }
            System.out.println("State is " + llvmToArmMap);
        }

        private int assignReturnValues(Type returnType){
            if (returnType == null){ //its a void fn
                return 0;
            }
            String str = returnType.toString(); 
            if (str.equals("bv32")){
                return 1;
            } else if (str.startsWith("{") && str.endsWith("}")){
                String content = str.substring(1, str.length() - 1).trim(); // Remove curly braces
                String[] elements = content.split(","); // Split by commas
                return elements.length;
            }
            return -1;
        }
    }

    private final List<Event> events = new ArrayList();
    private final Function llvmFunction;
    private final Register returnRegister;
    private final Type returnType;
    private final ExpressionFactory expressions = ExpressionFactory.getInstance();
    private final TypeFactory types = TypeFactory.getInstance();
    private final IntegerType integerType = types.getIntegerType(32);
    private final CompareExpression comparator; // class used to use compare and set flags
    private final HashMap<String, Label> labelsDefined;
    private final LlvmToArmRegisterMapping llvmToArmMap; // keeps track of all mappings
    

    public VisitorInlineAArch64(Function llvmFunction, Register returnRegister,Type returnType) {
        this.llvmFunction = llvmFunction;
        this.returnRegister = returnRegister; //this one is used to perform sideeffects if needed
        this.returnType = returnType;
        this.comparator = new CompareExpression();
        this.labelsDefined = new HashMap<>();
        this.llvmToArmMap = new LlvmToArmRegisterMapping(llvmFunction, returnType);
    }

    public List<Event> getEvents() {
        return this.events;
    }

    /* given the VariableInline as String it picks up if it is a 32 or 64 bit */
    public Type getVariableSize(String variable) {
        int width = - 1;
        if (variable.startsWith("${") && variable.endsWith("}")) {
            char letter = variable.charAt(4);
            switch (letter) {
                case 'w' ->
                    width = 32;
                case 'x' ->
                    width = 64;
                default ->
                    throw new UnsupportedOperationException("Unrecognized pattern for variable : does not fit into ${NUM:x/w}");
            }
        } else if (variable.length() == 2) {
            width = 32; // assuming that $1,$2 are 32 bit
        }
        return TypeFactory.getInstance().getIntegerType(width);
    }

    // if the label already exists return it, otherwise create it and append its event
    public Label getOrNewLabel(String labelName) {
        Label label;
        if (this.labelsDefined.containsKey(labelName)) {
            label = this.labelsDefined.get(labelName);
        } else {
            label = EventFactory.newLabel(labelName);
            this.labelsDefined.put(labelName, label);
            events.add(label);
        }
        return label;
    }


    private boolean isVariable(String registerName) {
        return registerName.startsWith("${") && registerName.endsWith("}");
    }

    private Register makeRegister(TerminalNode node) {
        String nodeName = node.getText();
        return llvmFunction.getOrNewRegister(nodeName, getVariableSize(nodeName));
    }

    @Override
    public Object visitLoadReg(InlineAArch64Parser.LoadRegContext ctx) {
        // this is the base example for an event with sideeffect
        Register register = makeRegister(ctx.VariableInline());
        System.out.println(" the register is " + register);
        Register address = makeRegister(ctx.ConstantInline()); //address
        System.out.println(" the address is " + address);
        Expression exp = isVariable(address.getName()) ? expressions.parseValue("22222", integerType) : expressions.parseValue(address.getName().substring(1), integerType); // TODO Change to a real value to parse
        events.add(EventFactory.newLoad(returnRegister, exp)); // we add to returnRegister because it is sideeffect
        System.out.println("Added " + events.toString());
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadAcquireReg(InlineAArch64Parser.LoadAcquireRegContext ctx) {
        Register register = makeRegister(ctx.VariableInline());
        System.out.println(" the register is " + register);
        Register address = makeRegister(ctx.ConstantInline());
        System.out.println(" the second register is " + address);
        String mo = Tag.ARMv8.MO_ACQ;
        var exp = isVariable(address.getName()) ? expressions.parseValue("22222", integerType) : expressions.parseValue(address.getName().substring(1), integerType);
        events.add(EventFactory.newLoadWithMo(returnRegister, exp, mo)); // we add to returnRegister because it is sideeffect
        // events.add(EventFactory.newLoadWithMo(register,address,mo.getValue()));
        System.out.println("Added " + events.toString());
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadExclusiveReg(InlineAArch64Parser.LoadExclusiveRegContext ctx) {
        // for now LDR and LDXR are the same from Memory Ordering point of view
        Register register = makeRegister(ctx.VariableInline());
        Register address = makeRegister(ctx.ConstantInline());
        // events.add(EventFactory.newLoadWithMo(register,address,mo.getValue()));
        Expression exp = isVariable(address.getName()) ? expressions.parseValue("22222", integerType) : expressions.parseValue(address.getName().substring(1), integerType);
        events.add(EventFactory.newLocal(register, exp)); // this one can be skipped since it is in a loop, so I make it local
        System.out.println("Added " + events.toString());
        return visitChildren(ctx);
    }

    @Override
    public Object visitLoadAcquireExclusiveReg(InlineAArch64Parser.LoadAcquireExclusiveRegContext ctx) {
        Register register = makeRegister(ctx.VariableInline());
        Register address = makeRegister(ctx.ConstantInline());
        String mo = Tag.ARMv8.MO_ACQ;
        Expression exp = isVariable(address.getName()) ? expressions.parseValue("22222", integerType) : expressions.parseValue(address.getName().substring(1), integerType);
        events.add(EventFactory.newLocal(register, exp));
        // events.add(EventFactory.newLoadWithMo(returnRegister, exp, mo)); this one break due to "aggregate construct".. maybe something with returning 2 values and not 1 -- still it should return the value!!!
        System.out.println("Added " + events.toString());
        return visitChildren(ctx);
    }

    @Override
    public Object visitAdd(InlineAArch64Parser.AddContext ctx) {
        System.out.println("Add");
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreReg(InlineAArch64Parser.StoreRegContext ctx) {
        Register register = makeRegister(ctx.VariableInline());
        Register address = makeRegister(ctx.ConstantInline());
        events.add(EventFactory.newStore(register, address));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreExclusiveRegister(InlineAArch64Parser.StoreExclusiveRegisterContext ctx) {
        String result = ctx.VariableInline(0).getText(); // this register either holds 0 or 1 if the operation was successful or not
        this.comparator.updateStoreSucceeded(result.equals("1"));
        Register register = makeRegister(ctx.VariableInline(1));
        Register address = makeRegister(ctx.ConstantInline());
        events.add(EventFactory.newStore(register, address));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreReleaseExclusiveReg(InlineAArch64Parser.StoreReleaseExclusiveRegContext ctx) {
        String result = ctx.VariableInline(0).getText();
        this.comparator.updateStoreSucceeded(result.equals("1"));
        Register register = makeRegister(ctx.VariableInline(1));
        Register address = makeRegister(ctx.ConstantInline());
        String mo = Tag.ARMv8.MO_REL;
        events.add(EventFactory.newStoreWithMo(register, address, mo));
        return visitChildren(ctx);
    }

    @Override
    public Object visitStoreReleaseReg(InlineAArch64Parser.StoreReleaseRegContext ctx) {
        //  TODO: this one breaks apparently randomly.. or I did not get how to make events correctly
        // reference run ttaslock.ll (write_rel function) and hclhlock.ll and see that...
        Register register = makeRegister(ctx.VariableInline());
        Register address = makeRegister(ctx.ConstantInline());
        String mo = Tag.ARMv8.MO_ACQ;
        events.add(EventFactory.newStoreWithMo(register, address,mo)); // this one can be skipped since it is in a loop
        return visitChildren(ctx);
    }

    @Override
    public Object visitAtomicAddDoubleWordRelease(InlineAArch64Parser.AtomicAddDoubleWordReleaseContext ctx) {
        System.out.println("AtomicAddDoubleWordRelease");
        return visitChildren(ctx);
    }

    @Override
    public Object visitDataMemoryBarrier(InlineAArch64Parser.DataMemoryBarrierContext ctx) {
        System.out.println("DataMemoryBarrier");
        return visitChildren(ctx);
    }

    @Override
    public Object visitSwapWordAcquire(InlineAArch64Parser.SwapWordAcquireContext ctx) {
        System.out.println("SwapWordAcquire");
        // write constant into newValueR and return to resultRegister the oldValueR
        Register newValueRegister = makeRegister(ctx.VariableInline(0));
        Register oldValueRegister = makeRegister(ctx.VariableInline(1));
        Register value = makeRegister(ctx.ConstantInline());
        String mo = Tag.ARMv8.MO_ACQ;
        Expression exp = expressions.parseValue("1", integerType); // should hold oldValueRegister
        events.add(EventFactory.newLoad(returnRegister, exp)); // for now mock and save 1
        System.out.println("Added returnregister to events");
        exp = expressions.parseValue(value.getName().substring(1), integerType); // TODO Change to a real value to parse
        events.add(EventFactory.newLocal(newValueRegister, exp));
        return visitChildren(ctx);
    }

    @Override
    public Object visitCompare(InlineAArch64Parser.CompareContext ctx) {
        System.out.println("Compare");
        Register firstRegister = makeRegister(ctx.VariableInline(0));
        Register secondRegister = makeRegister(ctx.VariableInline(1));
        this.comparator.updateCompareExpression(firstRegister, IntCmpOp.EQ, secondRegister);
        System.out.println("Update object now it is " + this.comparator.firstRegister + this.comparator.secondRegister + this.comparator.compareExpression);
        //events.add(EventFactory.newLocal(this.comparator.boolRegister,this.comparator.cmpTmp)); I don't think I need to make events
        return visitChildren(ctx);
    }

    @Override
    public Object visitCompareBranchNonZero(InlineAArch64Parser.CompareBranchNonZeroContext ctx) {
        System.out.println("CompareBranchNonZero");
        //we should perform both compare and branch operations
        Register firstRegister = makeRegister(ctx.VariableInline());
        this.comparator.updateCompareExpression(firstRegister, IntCmpOp.NEQ, this.comparator.zeroRegister);
        String cleanedLabelName = ctx.LabelReference().getText().replaceAll("(\\d)[a-z]", "$1");// remove the letter from the label
        Label label = getOrNewLabel(cleanedLabelName);
        events.add(EventFactory.newJump(this.comparator.compareExpression, label));
        return visitChildren(ctx);
    }

    @Override
    public Object visitCompareAndSwap(InlineAArch64Parser.CompareAndSwapContext ctx) {
        System.out.println("CompareAndSwap");
        return visitChildren(ctx);
    }

    @Override
    public Object visitCompareAndSwapAcquire(InlineAArch64Parser.CompareAndSwapAcquireContext ctx) {
        System.out.println("CompareAndSwapAcquire");
        return visitChildren(ctx);
    }

    @Override
    public Object visitMove(InlineAArch64Parser.MoveContext ctx) {
        System.out.println("Move");
        return visitChildren(ctx);
    }

    @Override
    public Object visitBranchEqual(InlineAArch64Parser.BranchEqualContext ctx) {
        System.out.println("BranchEqual");
        String cleanedLabelName = ctx.LabelReference().getText().replaceAll("(\\d)[a-z]", "$1");
        Label label = getOrNewLabel(cleanedLabelName);
        this.comparator.updateCompareExpressionOperator(IntCmpOp.EQ);
        events.add(EventFactory.newJump(this.comparator.compareExpression, label));
        return visitChildren(ctx);
    }

    @Override
    public Object visitBranchNotEqual(InlineAArch64Parser.BranchNotEqualContext ctx) {
        System.out.println("BranchNotEqual");
        String cleanedLabelName = ctx.LabelReference().getText().replaceAll("(\\d)[a-z]", "$1");
        Label label = getOrNewLabel(cleanedLabelName);
        this.comparator.updateCompareExpressionOperator(IntCmpOp.NEQ);
        events.add(EventFactory.newJump(this.comparator.compareExpression, label));
        return visitChildren(ctx);
    }

    @Override
    public Object visitSetEventLocally(InlineAArch64Parser.SetEventLocallyContext ctx) {
        System.out.println("SetEventlocally");
        return visitChildren(ctx);
    }

    @Override
    public Object visitWaitForEvent(InlineAArch64Parser.WaitForEventContext ctx) {
        System.out.println("WaitForEvent");
        return visitChildren(ctx);
    }

    @Override
    public Object visitLabelDefinition(InlineAArch64Parser.LabelDefinitionContext ctx) {
        System.out.println("LabelDefinition");
        Label label = getOrNewLabel(ctx.LabelDefinition().getText().replace(":", ""));
        return visitChildren(ctx);
    }

    @Override
    public Object visitAlignInline(InlineAArch64Parser.AlignInlineContext ctx) {
        System.out.println("AlignInline");
        return visitChildren(ctx);
    }

    @Override
    public Object visitPrefetchMemory(InlineAArch64Parser.PrefetchMemoryContext ctx) {
        System.out.println("PrefetchMemory");
        return visitChildren(ctx);
    }

    @Override
    public Object visitYieldtask(InlineAArch64Parser.YieldtaskContext ctx) {
        System.out.println("YieldTask");
        return visitChildren(ctx);
    }

    @Override
    public Object visitMetaInstr(InlineAArch64Parser.MetaInstrContext ctx) {
        System.out.println("MetaInstr");
        return visitChildren(ctx);
    }

    @Override
    public Object visitMetadataInline(InlineAArch64Parser.MetadataInlineContext ctx) {
        System.out.println("MetadataInline");
        return visitChildren(ctx);
    }

    @Override
    public Object visitClobber(InlineAArch64Parser.ClobberContext ctx) {
        System.out.println("Clobber");
        return visitChildren(ctx);
    }

}
