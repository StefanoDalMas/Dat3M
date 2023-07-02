package com.dat3m.dartagnan.encoding;

import com.dat3m.dartagnan.expression.*;
import com.dat3m.dartagnan.expression.op.COpBin;
import com.dat3m.dartagnan.expression.op.IOpUn;
import com.dat3m.dartagnan.expression.processing.ExpressionVisitor;
import com.dat3m.dartagnan.expression.type.IntegerType;
import com.dat3m.dartagnan.expression.type.Type;
import com.dat3m.dartagnan.program.Register;
import com.dat3m.dartagnan.program.event.core.Event;
import com.dat3m.dartagnan.program.memory.Location;
import com.dat3m.dartagnan.program.memory.MemoryObject;
import org.sosy_lab.java_smt.api.*;
import org.sosy_lab.java_smt.api.NumeralFormula.IntegerFormula;

import java.math.BigInteger;

import static com.dat3m.dartagnan.GlobalSettings.getArchPrecision;
import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Preconditions.checkState;
import static java.util.Arrays.asList;

class ExpressionEncoder implements ExpressionVisitor<Formula> {

    private final FormulaManager formulaManager;
    private final BooleanFormulaManager booleanFormulaManager;
    private final Event event;

    public ExpressionEncoder(FormulaManager formulaManager, Event event) {
        this.formulaManager = formulaManager;
        this.booleanFormulaManager = formulaManager.getBooleanFormulaManager();
        this.event = event;
    }

    private IntegerFormulaManager integerFormulaManager() {
        return formulaManager.getIntegerFormulaManager();
    }

    private BitvectorFormulaManager bitvectorFormulaManager() {
        return formulaManager.getBitvectorFormulaManager();
    }

    BooleanFormula encodeAsBoolean(Expression expression) {
        Formula formula = expression.visit(this);
        if (formula instanceof BooleanFormula bForm) {
            return bForm;
        }
        if (formula instanceof BitvectorFormula bvForm) {
            BitvectorFormulaManager bitvectorFormulaManager = bitvectorFormulaManager();
            int length = bitvectorFormulaManager.getLength(bvForm);
            BitvectorFormula zero = bitvectorFormulaManager.makeBitvector(length, 0);
            return bitvectorFormulaManager.greaterThan(bvForm, zero, false);
        }
        assert formula instanceof IntegerFormula;
        IntegerFormulaManager integerFormulaManager = integerFormulaManager();
        IntegerFormula zero = integerFormulaManager.makeNumber(0);
        return integerFormulaManager.greaterThan((IntegerFormula) formula, zero);
    }

    Formula encodeAsInteger(Expression expression) {
        return expression.visit(this);
    }

    static BooleanFormula encodeComparison(COpBin op, Formula lhs, Formula rhs, FormulaManager fmgr) {
        BooleanFormulaManager bmgr = fmgr.getBooleanFormulaManager();
        if (lhs instanceof BooleanFormula b1 && rhs instanceof BooleanFormula b2) {
            switch (op) {
                case EQ:
                    return bmgr.equivalence(b1, b2);
                case NEQ:
                    return bmgr.not(bmgr.equivalence(b1, b2));
                default:
                    throw new UnsupportedOperationException("Encoding of COpBin operation" + op + " not supported on boolean formulas.");
            }
        }
        if (lhs instanceof IntegerFormula i1 && rhs instanceof IntegerFormula i2) {
            IntegerFormulaManager imgr = fmgr.getIntegerFormulaManager();
            switch (op) {
                case EQ:
                    return imgr.equal(i1, i2);
                case NEQ:
                    return bmgr.not(imgr.equal(i1, i2));
                case LT:
                case ULT:
                    return imgr.lessThan(i1, i2);
                case LTE:
                case ULTE:
                    return imgr.lessOrEquals(i1, i2);
                case GT:
                case UGT:
                    return imgr.greaterThan(i1, i2);
                case GTE:
                case UGTE:
                    return imgr.greaterOrEquals(i1, i2);
            }
        }
        if (lhs instanceof BitvectorFormula bv1 && rhs instanceof BitvectorFormula bv2) {
            BitvectorFormulaManager bvmgr = fmgr.getBitvectorFormulaManager();
            switch (op) {
                case EQ:
                    return bvmgr.equal(bv1, bv2);
                case NEQ:
                    return bmgr.not(bvmgr.equal(bv1, bv2));
                case LT:
                case ULT:
                    return bvmgr.lessThan(bv1, bv2, op.equals(COpBin.LT));
                case LTE:
                case ULTE:
                    return bvmgr.lessOrEquals(bv1, bv2, op.equals(COpBin.LTE));
                case GT:
                case UGT:
                    return bvmgr.greaterThan(bv1, bv2, op.equals(COpBin.GT));
                case GTE:
                case UGTE:
                    return bvmgr.greaterOrEquals(bv1, bv2, op.equals(COpBin.GTE));
            }
        }
        throw new UnsupportedOperationException("Encoding not supported for COpBin: " + lhs + " " + op + " " + rhs);
    }

    static Formula getLastMemValueExpr(MemoryObject object, int offset, FormulaManager formulaManager) {
        checkArgument(0 <= offset && offset < object.size(), "array index out of bounds");
        String name = String.format("last_val_at_%s_%d", object, offset);
        if (getArchPrecision() > -1) {
            return formulaManager.getBitvectorFormulaManager().makeVariable(getArchPrecision(), name);
        } else {
            return formulaManager.getIntegerFormulaManager().makeVariable(name);
        }
    }

    @Override
    public Formula visit(Atom atom) {
        Formula lhs = encodeAsInteger(atom.getLHS());
        Formula rhs = encodeAsInteger(atom.getRHS());
        return encodeComparison(atom.getOp(), lhs, rhs, formulaManager);
    }

    @Override
    public Formula visit(BConst bConst) {
        return booleanFormulaManager.makeBoolean(bConst.getValue());
    }

    @Override
    public Formula visit(BExprBin bBin) {
        BooleanFormula lhs = encodeAsBoolean(bBin.getLHS());
        BooleanFormula rhs = encodeAsBoolean(bBin.getRHS());
        switch (bBin.getOp()) {
            case AND:
                return booleanFormulaManager.and(lhs, rhs);
            case OR:
                return booleanFormulaManager.or(lhs, rhs);
        }
        throw new UnsupportedOperationException("Encoding not supported for BOpBin " + bBin.getOp());
    }

    @Override
    public Formula visit(BExprUn bUn) {
        BooleanFormula inner = encodeAsBoolean(bUn.getInner());
        return booleanFormulaManager.not(inner);
    }

    @Override
    public Formula visit(BNonDet bNonDet) {
        return booleanFormulaManager.makeVariable(Integer.toString(bNonDet.hashCode()));
    }

    @Override
    public Formula visit(IValue iValue) {
        BigInteger value = iValue.getValue();
        Type type = iValue.getType();
        return makeLiteral(type, value);
    }

    @Override
    public Formula visit(IExprBin iBin) {
        Formula lhs = encodeAsInteger(iBin.getLHS());
        Formula rhs = encodeAsInteger(iBin.getRHS());
        if (lhs instanceof IntegerFormula i1 && rhs instanceof IntegerFormula i2) {
            BitvectorFormulaManager bitvectorFormulaManager;
            IntegerFormulaManager integerFormulaManager = integerFormulaManager();
            switch (iBin.getOp()) {
                case PLUS:
                    return integerFormulaManager.add(i1, i2);
                case MINUS:
                    return integerFormulaManager.subtract(i1, i2);
                case MULT:
                    return integerFormulaManager.multiply(i1, i2);
                case DIV:
                case UDIV:
                    return integerFormulaManager.divide(i1, i2);
                case MOD:
                    return integerFormulaManager.modulo(i1, i2);
                case AND:
                    bitvectorFormulaManager = bitvectorFormulaManager();
                    return bitvectorFormulaManager.toIntegerFormula(
                            bitvectorFormulaManager.and(
                                    bitvectorFormulaManager.makeBitvector(32, i1),
                                    bitvectorFormulaManager.makeBitvector(32, i2)),
                            false);
                case OR:
                    bitvectorFormulaManager = bitvectorFormulaManager();
                    return bitvectorFormulaManager.toIntegerFormula(
                            bitvectorFormulaManager.or(
                                    bitvectorFormulaManager.makeBitvector(32, i1),
                                    bitvectorFormulaManager.makeBitvector(32, i2)),
                            false);
                case XOR:
                    bitvectorFormulaManager = bitvectorFormulaManager();
                    return bitvectorFormulaManager.toIntegerFormula(
                            bitvectorFormulaManager.xor(
                                    bitvectorFormulaManager.makeBitvector(32, i1),
                                    bitvectorFormulaManager.makeBitvector(32, i2)),
                            false);
                case L_SHIFT:
                    bitvectorFormulaManager = bitvectorFormulaManager();
                    return bitvectorFormulaManager.toIntegerFormula(
                            bitvectorFormulaManager.shiftLeft(
                                    bitvectorFormulaManager.makeBitvector(32, i1),
                                    bitvectorFormulaManager.makeBitvector(32, i2)),
                            false);
                case R_SHIFT:
                    bitvectorFormulaManager = bitvectorFormulaManager();
                    return bitvectorFormulaManager.toIntegerFormula(
                            bitvectorFormulaManager.shiftRight(
                                    bitvectorFormulaManager.makeBitvector(32, i1),
                                    bitvectorFormulaManager.makeBitvector(32, i2),
                                    false),
                            false);
                case AR_SHIFT:
                    bitvectorFormulaManager = bitvectorFormulaManager();
                    return bitvectorFormulaManager.toIntegerFormula(
                            bitvectorFormulaManager.shiftRight(
                                    bitvectorFormulaManager.makeBitvector(32, i1),
                                    bitvectorFormulaManager.makeBitvector(32, i2),
                                    true),
                            false);
                case SREM:
                case UREM:
                    IntegerFormula zero = integerFormulaManager.makeNumber(0);
                    IntegerFormula modulo = integerFormulaManager.modulo(i1, i2);
                    BooleanFormula cond = booleanFormulaManager.and(
                            integerFormulaManager.distinct(asList(modulo, zero)),
                            integerFormulaManager.lessThan(i1, zero));
                    return booleanFormulaManager.ifThenElse(cond, integerFormulaManager.subtract(modulo, i2), modulo);
                default:
                    throw new UnsupportedOperationException("Encoding of IOpBin operation " + iBin.getOp() + " not supported on integer formulas.");
            }
        } else if (lhs instanceof BitvectorFormula bv1 && rhs instanceof BitvectorFormula bv2) {
            BitvectorFormulaManager bitvectorFormulaManager = bitvectorFormulaManager();
            switch (iBin.getOp()) {
                case PLUS:
                    return bitvectorFormulaManager.add(bv1, bv2);
                case MINUS:
                    return bitvectorFormulaManager.subtract(bv1, bv2);
                case MULT:
                    return bitvectorFormulaManager.multiply(bv1, bv2);
                case DIV:
                    return bitvectorFormulaManager.divide(bv1, bv2, true);
                case UDIV:
                    return bitvectorFormulaManager.divide(bv1, bv2, false);
                case MOD:
                    BitvectorFormula rem = bitvectorFormulaManager.modulo(bv1, bv2, true);
                    // Check if rem and bv2 have the same sign
                    int rem_length = bitvectorFormulaManager.getLength(rem);
                    int bv2_length = bitvectorFormulaManager.getLength(bv2);
                    BitvectorFormula srem = bitvectorFormulaManager.extract(rem, rem_length - 1, rem_length - 1);
                    BitvectorFormula sbv2 = bitvectorFormulaManager.extract(bv2, bv2_length - 1, bv2_length - 1);
                    BooleanFormula cond = bitvectorFormulaManager.equal(srem, sbv2);
                    // If they have the same sign, return the reminder, otherwise invert it
                    return booleanFormulaManager.ifThenElse(cond, rem, bitvectorFormulaManager.negate(rem));
                case SREM:
                    return bitvectorFormulaManager.modulo(bv1, bv2, true);
                case UREM:
                    return bitvectorFormulaManager.modulo(bv1, bv2, false);
                case AND:
                    return bitvectorFormulaManager.and(bv1, bv2);
                case OR:
                    return bitvectorFormulaManager.or(bv1, bv2);
                case XOR:
                    return bitvectorFormulaManager.xor(bv1, bv2);
                case L_SHIFT:
                    return bitvectorFormulaManager.shiftLeft(bv1, bv2);
                case R_SHIFT:
                    return bitvectorFormulaManager.shiftRight(bv1, bv2, false);
                case AR_SHIFT:
                    return bitvectorFormulaManager.shiftRight(bv1, bv2, true);
                default:
                    throw new UnsupportedOperationException("Encoding of IOpBin operation " + iBin.getOp() + " not supported on bitvector formulas.");
            }
        } else {
            throw new UnsupportedOperationException("Encoding of IOpBin operation " + iBin.getOp() + " not supported on formulas of mismatching type.");
        }
    }

    @Override
    public Formula visit(IExprUn iUn) {
        //TODO if inner is a boolean formula, we still want to encode it as boolean in case of conversions
        Formula inner = encodeAsInteger(iUn.getInner());
        Type targetType = iUn.getType();
        switch (iUn.getOp()) {
            case MINUS -> {
                if (inner instanceof IntegerFormula number) {
                    return integerFormulaManager().negate(number);
                }
                if (inner instanceof BitvectorFormula number) {
                    return bitvectorFormulaManager().negate(number);
                }
            }
            case CAST_SIGNED, CAST_UNSIGNED -> {
                boolean signed = iUn.getOp().equals(IOpUn.CAST_SIGNED);
                if (targetType instanceof IntegerType integerTargetType) {
                    if (integerTargetType.isMathematical()) {
                        if (inner instanceof IntegerFormula) {
                            return inner;
                        }
                        if (inner instanceof BitvectorFormula number) {
                            return bitvectorFormulaManager().toIntegerFormula(number, signed);
                        }
                    }
                    int bitWidth = integerTargetType.getBitWidth();
                    if (inner instanceof IntegerFormula number) {
                        return bitvectorFormulaManager().makeBitvector(bitWidth, number);
                    }
                    if (inner instanceof BitvectorFormula number) {
                        int innerBitWidth = bitvectorFormulaManager().getLength(number);
                        if (innerBitWidth < bitWidth) {
                            return bitvectorFormulaManager().extend(number, bitWidth - innerBitWidth, signed);
                        }
                        return bitvectorFormulaManager().extract(number, bitWidth - 1, 0);
                    }
                }
            }
            case CTLZ -> {
                if (inner instanceof BitvectorFormula bv) {
                    BitvectorFormulaManager bitvectorFormulaManager = bitvectorFormulaManager();
                    // enc = extract(bv, 63, 63) == 1 ? 0 : (extract(bv, 62, 62) == 1 ? 1 : extract ... extract(bv, 0, 0) ? 63 : 64)
                    int bvLength = bitvectorFormulaManager.getLength(bv);
                    BitvectorFormula bv1 = bitvectorFormulaManager.makeBitvector(1, 1);
                    BitvectorFormula enc = bitvectorFormulaManager.makeBitvector(bvLength, bvLength);
                    for(int i = bitvectorFormulaManager.getLength(bv) - 1; i >= 0; i--) {
                        BitvectorFormula bvi = bitvectorFormulaManager.makeBitvector(bvLength, i);
                        BitvectorFormula bvbit = bitvectorFormulaManager.extract(bv, bvLength - (i + 1), bvLength - (i + 1));
                        enc = booleanFormulaManager.ifThenElse(bitvectorFormulaManager.equal(bvbit, bv1), bvi, enc);
                    }
                    return enc;
                }
            }
        }
        throw new UnsupportedOperationException(
                String.format("Encoding of (%s) %s %s not supported.", targetType, iUn.getOp(), inner));
    }

    @Override
    public Formula visit(IfExpr ifExpr) {
        BooleanFormula guard = encodeAsBoolean(ifExpr.getGuard());
        Formula tBranch = encodeAsInteger(ifExpr.getTrueBranch());
        Formula fBranch = encodeAsInteger(ifExpr.getFalseBranch());
        return booleanFormulaManager.ifThenElse(guard, tBranch, fBranch);
    }

    @Override
    public Formula visit(INonDet iNonDet) {
        String name = iNonDet.getName();
        Type type = iNonDet.getType();
        return makeVariable(type, name);
    }

    @Override
    public Formula visit(Register reg) {
        String name = event == null ?
                reg.getName() + "_" + reg.getThreadId() + "_final" :
                reg.getName() + "(" + event.getGlobalId() + ")";
        Type type = reg.getType();
        return makeVariable(type, name);
    }

    @Override
    public Formula visit(MemoryObject address) {
        BigInteger value = address.getValue();
        Type type = address.getType();
        return makeLiteral(type, value);
    }

    @Override
    public Formula visit(Location location) {
        checkState(event == null, "Cannot evaluate %s at event %s.", location, event);
        return getLastMemValueExpr(location.getMemoryObject(), location.getOffset(), formulaManager);
    }

    private Formula makeVariable(Type type, String name) {
        if (type instanceof IntegerType integerType) {
            if (integerType.isMathematical()) {
                return integerFormulaManager().makeVariable(name);
            }
            int bitWidth = integerType.getBitWidth();
            return bitvectorFormulaManager().makeVariable(bitWidth, name);
        }
        throw new UnsupportedOperationException(String.format("Encoding variable of type %s.", type));
    }

    private Formula makeLiteral(Type type, BigInteger value) {
        if (type instanceof IntegerType integerType) {
            if (integerType.isMathematical()) {
                return integerFormulaManager().makeNumber(value);
            }
            int bitWidth = integerType.getBitWidth();
            return bitvectorFormulaManager().makeBitvector(bitWidth, value);
        }
        throw new UnsupportedOperationException(String.format("Encoding literal of type %s.", type));
    }
}