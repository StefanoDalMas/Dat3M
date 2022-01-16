package com.dat3m.dartagnan.program.event.visitors;

import com.dat3m.dartagnan.program.event.arch.tso.*;
import com.dat3m.dartagnan.program.event.arch.aarch64.*;
import com.dat3m.dartagnan.program.event.core.*;
import com.dat3m.dartagnan.program.event.core.rmw.*;
import com.dat3m.dartagnan.program.event.lang.catomic.*;
import com.dat3m.dartagnan.program.event.lang.linux.*;
import com.dat3m.dartagnan.program.event.lang.linux.cond.*;
import com.dat3m.dartagnan.program.event.lang.pthread.*;
import com.dat3m.dartagnan.program.event.lang.svcomp.*;

public interface EventVisitor<T> {

	T visitEvent(Event e);

	// Basic events
	default T visitAssume(Assume e) { return visitEvent(e); };
	default T visitCmp(Cmp e) { return visitSkip(e); };
	default T visitCondJump(CondJump e) { return visitEvent(e); };
	default T visitExecutionStatus(ExecutionStatus e) { return visitEvent(e); };
	default T visitFence(Fence e) { return visitEvent(e); };
	default T visitFunCall(FunCall e) { return visitEvent(e); };
	default T visitFunRet(FunRet e) { return visitEvent(e); };
	default T visitIfAsJump(IfAsJump e) { return visitCondJump(e); };
	default T visitInit(Init e) { return visitMemEvent(e); };
	default T visitLabel(Label e) { return visitEvent(e); };
	default T visitLoad(Load e) { return visitMemEvent(e); };
	default T visitLocal(Local e) { return visitEvent(e); };
	default T visitMemEvent(MemEvent e) { return visitEvent(e); };
	default T visitSkip(Skip e) { return visitEvent(e); };
	default T visitStore(Store e) { return visitMemEvent(e); };

	// Pthread Events
	default T visitCreate(Create e) { return visitStore(e); };
	default T visitEnd(End e) { return visitStore(e); };
	default T visitInitLock(InitLock e) { return visitStore(e); };
	default T visitJoin(Join e) { return visitLoad(e); };
	default T visitLock(Lock e) { return visitMemEvent(e); };
	default T visitStart(Start e) { return visitLoad(e); };
	default T visitUnlock(Unlock e) { return visitMemEvent(e); };
	
	// RMW Events
	default T visitRMWStore(RMWStore e) { return visitStore(e); };
	default T visitRMWStoreExclusive(RMWStoreExclusive e) { return visitStore(e); };

	// AARCH64 Events
	default T visitStoreExclusive(StoreExclusive e) { return visitStore(e); };

	// Linux Events
	default T visitRMWAbstract(RMWAbstract e) { return visitMemEvent(e); };
	default T visitRMWAddUnless(RMWAddUnless e) { return visitRMWAbstract(e); };
	default T visitRMWCmpXchg(RMWCmpXchg e) { return visitRMWAbstract(e); };
	default T visitRMWFetchOp(RMWFetchOp e) { return visitRMWAbstract(e); };
	default T visitRMWFetch(RMWFetch e) { return visitRMWAbstract(e); };
	default T visitRMWOp(RMWOp e) { return visitRMWAbstract(e); };
	default T visitRMWOpAndTest(RMWOpAndTest e) { return visitRMWAbstract(e); };
	default T visitRMWOpReturn(RMWOpReturn e) { return visitRMWAbstract(e); };
	default T visitRMWXchg(RMWXchg e) { return visitRMWAbstract(e); };

	// Linux Cond Events
	default T visitFenceCond(FenceCond e) { return visitFence(e); };
	default T visitRMWReadCond(RMWReadCond e) { return visitLoad(e); };
	default T visitRMWReadCondCmp(RMWReadCondCmp e) { return visitRMWReadCond(e); };
	default T visitRMWReadCondUnless(RMWReadCondUnless e) { return visitRMWReadCond(e); };
	default T visitRMWStoreCond(RMWStoreCond e) { return visitRMWStore(e); };

	// TSO Events
	default T visitXchg(Xchg e) { return visitMemEvent(e); };

	// Atomic Events
	default T visitAtomicAbstract(AtomicAbstract e) { return visitMemEvent(e); };
	default T visitAtomicCmpXchg(AtomicCmpXchg e) { return visitAtomicAbstract(e); };
	default T visitAtomicFetchOp(AtomicFetchOp e) { return visitAtomicAbstract(e); };
	default T visitAtomicLoad(AtomicLoad e) { return visitMemEvent(e); };
	default T visitAtomicStore(AtomicStore e) { return visitMemEvent(e); };
	default T visitAtomicThreadFence(AtomicThreadFence e) { return visitFence(e); };
	default T visitAtomicXchg(AtomicXchg e) { return visitAtomicAbstract(e); };
	default T visitDat3mCAS(Dat3mCAS e) { return visitAtomicAbstract(e); };

	// SVCOMP Events
	default T visitBeginAtomic(BeginAtomic e) { return visitEvent(e); };
	default T visitEndAtomic(EndAtomic e) { return visitEvent(e); };
}