package com.dat3m.dartagnan.expression;

import java.math.BigInteger;

import org.sosy_lab.java_smt.api.Formula;
import org.sosy_lab.java_smt.api.FormulaManager;
import org.sosy_lab.java_smt.api.Model;
import org.sosy_lab.java_smt.api.SolverContext;

import com.dat3m.dartagnan.program.event.Event;

public abstract class BExpr implements ExprInterface {

    @Override
    public Formula toZ3Int(Event e, SolverContext ctx) {
    	FormulaManager fmgr = ctx.getFormulaManager();
		return fmgr.getBooleanFormulaManager().ifThenElse(toZ3Bool(e, ctx), 
				fmgr.getIntegerFormulaManager().makeNumber(BigInteger.ONE), 
				fmgr.getIntegerFormulaManager().makeNumber(BigInteger.ZERO));
    }

    @Override
    public BigInteger getIntValue(Event e, Model model, SolverContext ctx){
        return getBoolValue(e, model, ctx) ? BigInteger.ONE : BigInteger.ZERO;
    }
    
	@Override
	public int getPrecision() {
		throw new UnsupportedOperationException("getPrecision() not supported for " + this);
	}
	
	@Override
	public IExpr getBase() {
		return null;
	}

	public boolean isTrue() {
		return this.equals(BConst.TRUE);
	}

    public boolean isFalse() {
    	return this.equals(BConst.FALSE);
    }
}
