grammar InlineAsm;

options {tokenVocab=InlineAsmLexer;}

asm                                 
    :
    (Quot(asmInstrEntries)*Quot)Comma (Quot(asmMetadataEntries)+ Quot)+ EOF?
;

asmInstrEntries : EndInstruction?((armInstr | riscvInstr | ppcInstr | x86Instr )(EndInstruction | Semi)*);
asmMetadataEntries : metaInstr(Comma metaInstr)*;


armInstr 
    : load
    | loadAcquire
    | loadExclusive
    | loadAcquireExclusive
    | add
    | sub
    | or 
    | and
    | store
    | storeExclusive
    | storeReleaseExclusive
    | storeRelease
    | compare
    | compareBranchNonZero
    | move
    | branchEqual
    | branchNotEqual
    | setEventLocally
    | waitForEvent
    | labelDefinition
    | alignInline
    | prefetchMemory
    | yieldtask
    | asmFence
;
riscvInstr : riscvFence;
ppcInstr : ppcFence;
x86Instr : x86Fence;

// rules divised like this in order to generate single visitors
load : (Load register)Comma register;
loadAcquire : (LoadAcquire register)Comma register;
loadExclusive : (LoadExclusive register)Comma register;
loadAcquireExclusive : (LoadAcquireExclusive register)Comma register;
add : ((Add register)Comma register)Comma register;
sub : ((Sub register)Comma register)Comma register;
or : ((Or register)Comma register)Comma register;
and : ((And register)Comma register)Comma register;
store : (Store register)Comma register;
storeRelease : (StoreRelease register)Comma register;
storeExclusive : ((StoreExclusive register)Comma register)Comma register ;
storeReleaseExclusive : ((StoreReleaseExclusive register)Comma register)Comma register;
compare : (Compare register)Comma register;
compareBranchNonZero : (CompareBranchNonZero register)Comma LabelReference;
move : (Move register)Comma register;
branchEqual : BranchEqual LabelReference;
branchNotEqual : BranchNotEqual LabelReference;
setEventLocally : SetEventLocally;
waitForEvent : WaitForEvent;
labelDefinition : LabelDefinition;
alignInline : AlignInline;
prefetchMemory : (PrefetchMemory PrefetchStoreL1Once)Comma register;
yieldtask : YieldTask;

//fences
asmFence : DataMemoryBarrier FenceArmOpt | DataSynchronizationBarrier FenceArmOpt;
riscvFence : RISCVFence FenceRISCVOpt | RISCVFence FenceRISCVOpt Comma FenceRISCVOpt;
x86Fence : X86Fence;
ppcFence : PPCFence;

metaInstr : clobber | flag;
clobber : OutputOpAssign | IsMemoryAddress | InputOpGeneralReg | OverlapInOutRegister | PointerToMemoryLocation;

flag : Tilde LBrace clobberType RBrace;

clobberType : ClobberMemory | ClobberModifyFlags | ClobberDirectionFlag | ClobberFlags | ClobberFloatPntStatusReg;

register : Register;