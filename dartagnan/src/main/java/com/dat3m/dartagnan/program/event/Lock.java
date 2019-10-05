package com.dat3m.dartagnan.program.event;

import static com.dat3m.dartagnan.expression.op.COpBin.NEQ;

import java.util.LinkedList;

import com.dat3m.dartagnan.expression.Atom;
import com.dat3m.dartagnan.expression.IConst;
import com.dat3m.dartagnan.expression.IExpr;
import com.dat3m.dartagnan.program.event.Event;
import com.dat3m.dartagnan.program.utils.EType;
import com.dat3m.dartagnan.wmm.utils.Arch;

public class Lock extends Event {

	private IExpr lock;
	private Label label;
	
    public Lock(IExpr lock, Label label) {
    	this.lock = lock;
    	this.label = label;
        addFilters(EType.LOCK);
    }

    protected Lock(Lock other){
		super(other);
	}

    @Override
    public String toString() {
    	return "lock(&" + lock + ")";
    }
    	
    // Compilation
    // -----------------------------------------------------------------------------------------------------------------

    public int compile(Arch target, int nextId, Event predecessor) {
        LinkedList<Event> events = new LinkedList<>();
        events.add(new CondJump(new Atom(lock, NEQ, new IConst(0)), label));
        events.add(new Store(lock, new IConst(1), "NA"));
		return compileSequence(target, nextId, predecessor, events);
	}
}