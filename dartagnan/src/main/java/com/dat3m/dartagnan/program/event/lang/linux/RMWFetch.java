package com.dat3m.dartagnan.program.event.lang.linux;

import com.dat3m.dartagnan.expression.ExprInterface;
import com.dat3m.dartagnan.expression.IExpr;
import com.dat3m.dartagnan.program.Register;
import com.dat3m.dartagnan.program.event.Tag;
import com.dat3m.dartagnan.program.event.core.utils.RegReaderData;
import com.dat3m.dartagnan.program.event.core.utils.RegWriter;
import com.dat3m.dartagnan.program.event.visitors.EventVisitor;

public class RMWFetch extends RMWAbstract implements RegWriter, RegReaderData {

    public RMWFetch(IExpr address, Register register, IExpr value, String mo) {
        super(address, register, value, mo);
    }

    private RMWFetch(RMWFetch other){
        super(other);
    }

    @Override
    public String toString() {
        return resultRegister + " := atomic_fetch" + Tag.Linux.toText(mo) + "(" + value + ", " + address + ")";
    }

    @Override
    public ExprInterface getMemValue(){
        return value;
    }

    // Unrolling
    // -----------------------------------------------------------------------------------------------------------------

    @Override
    public RMWFetch getCopy(){
        return new RMWFetch(this);
    }

	// Visitor
	// -----------------------------------------------------------------------------------------------------------------

	@Override
	public <T> T accept(EventVisitor<T> visitor) {
		return visitor.visitRMWFetch(this);
	}
}