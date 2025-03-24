; ModuleID = 'tests/ticketlock.c'
source_filename = "tests/ticketlock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_ticket = type { i32 }

@x = dso_local global i32 0, align 4, !dbg !0
@y = dso_local global i32 0, align 4, !dbg !25
@ticket_lock = dso_local global ptr null, align 8, !dbg !45
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !28
@.str.1 = private unnamed_addr constant [19 x i8] c"tests/ticketlock.c\00", align 1, !dbg !34
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1, !dbg !39

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @run(ptr noundef %0) #0 !dbg !55 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !59, metadata !DIExpression()), !dbg !60
  %3 = load ptr, ptr @ticket_lock, align 8, !dbg !61
  call void @ck_spinlock_ticket_lock(ptr noundef %3), !dbg !62
  %4 = load i32, ptr @x, align 4, !dbg !63
  %5 = add nsw i32 %4, 1, !dbg !63
  store i32 %5, ptr @x, align 4, !dbg !63
  %6 = load i32, ptr @y, align 4, !dbg !64
  %7 = add nsw i32 %6, 1, !dbg !64
  store i32 %7, ptr @y, align 4, !dbg !64
  %8 = load ptr, ptr @ticket_lock, align 8, !dbg !65
  call void @ck_spinlock_ticket_unlock(ptr noundef %8), !dbg !66
  ret ptr null, !dbg !67
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_ticket_lock(ptr noundef %0) #0 !dbg !68 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !72, metadata !DIExpression()), !dbg !73
  call void @llvm.dbg.declare(metadata ptr %3, metadata !74, metadata !DIExpression()), !dbg !75
  call void @llvm.dbg.declare(metadata ptr %4, metadata !76, metadata !DIExpression()), !dbg !77
  %5 = load ptr, ptr %2, align 8, !dbg !78
  %6 = getelementptr inbounds %struct.ck_spinlock_ticket, ptr %5, i32 0, i32 0, !dbg !78
  %7 = call i32 @ck_pr_faa_32(ptr noundef %6, i32 noundef 65536), !dbg !78
  store i32 %7, ptr %3, align 4, !dbg !79
  %8 = load i32, ptr %3, align 4, !dbg !80
  %9 = zext i32 %8 to i64, !dbg !80
  %10 = and i64 %9, 65535, !dbg !81
  %11 = trunc i64 %10 to i32, !dbg !80
  store i32 %11, ptr %4, align 4, !dbg !82
  %12 = load i32, ptr %3, align 4, !dbg !83
  %13 = lshr i32 %12, 16, !dbg !83
  store i32 %13, ptr %3, align 4, !dbg !83
  br label %14, !dbg !84

14:                                               ; preds = %18, %1
  %15 = load i32, ptr %3, align 4, !dbg !85
  %16 = load i32, ptr %4, align 4, !dbg !86
  %17 = icmp ne i32 %15, %16, !dbg !87
  br i1 %17, label %18, label %25, !dbg !84

18:                                               ; preds = %14
  call void @ck_pr_stall(), !dbg !88
  %19 = load ptr, ptr %2, align 8, !dbg !90
  %20 = getelementptr inbounds %struct.ck_spinlock_ticket, ptr %19, i32 0, i32 0, !dbg !90
  %21 = call i32 @ck_pr_md_load_32(ptr noundef %20), !dbg !90
  %22 = zext i32 %21 to i64, !dbg !90
  %23 = and i64 %22, 65535, !dbg !91
  %24 = trunc i64 %23 to i32, !dbg !90
  store i32 %24, ptr %4, align 4, !dbg !92
  br label %14, !dbg !84, !llvm.loop !93

25:                                               ; preds = %14
  call void @ck_pr_fence_lock(), !dbg !96
  ret void, !dbg !97
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_ticket_unlock(ptr noundef %0) #0 !dbg !98 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !99, metadata !DIExpression()), !dbg !100
  call void @ck_pr_fence_unlock(), !dbg !101
  %3 = load ptr, ptr %2, align 8, !dbg !102
  %4 = getelementptr inbounds %struct.ck_spinlock_ticket, ptr %3, i32 0, i32 0, !dbg !102
  call void @ck_pr_inc_16(ptr noundef %4), !dbg !102
  ret void, !dbg !103
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !104 {
  %1 = alloca i32, align 4
  %2 = alloca [3 x i64], align 16
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !107, metadata !DIExpression()), !dbg !114
  call void @llvm.dbg.declare(metadata ptr %3, metadata !115, metadata !DIExpression()), !dbg !116
  %4 = call noalias ptr @malloc(i64 noundef 4) #6, !dbg !117
  store ptr %4, ptr @ticket_lock, align 8, !dbg !118
  %5 = load ptr, ptr @ticket_lock, align 8, !dbg !119
  call void @ck_spinlock_ticket_init(ptr noundef %5), !dbg !120
  store i32 0, ptr %3, align 4, !dbg !121
  br label %6, !dbg !123

6:                                                ; preds = %17, %0
  %7 = load i32, ptr %3, align 4, !dbg !124
  %8 = icmp slt i32 %7, 3, !dbg !126
  br i1 %8, label %9, label %20, !dbg !127

9:                                                ; preds = %6
  %10 = load i32, ptr %3, align 4, !dbg !128
  %11 = sext i32 %10 to i64, !dbg !131
  %12 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %11, !dbg !131
  %13 = call i32 @pthread_create(ptr noundef %12, ptr noundef null, ptr noundef @run, ptr noundef null) #7, !dbg !132
  %14 = icmp ne i32 %13, 0, !dbg !133
  br i1 %14, label %15, label %16, !dbg !134

15:                                               ; preds = %9
  call void @exit(i32 noundef 1) #8, !dbg !135
  unreachable, !dbg !135

16:                                               ; preds = %9
  br label %17, !dbg !137

17:                                               ; preds = %16
  %18 = load i32, ptr %3, align 4, !dbg !138
  %19 = add nsw i32 %18, 1, !dbg !138
  store i32 %19, ptr %3, align 4, !dbg !138
  br label %6, !dbg !139, !llvm.loop !140

20:                                               ; preds = %6
  store i32 0, ptr %3, align 4, !dbg !142
  br label %21, !dbg !144

21:                                               ; preds = %33, %20
  %22 = load i32, ptr %3, align 4, !dbg !145
  %23 = icmp slt i32 %22, 3, !dbg !147
  br i1 %23, label %24, label %36, !dbg !148

24:                                               ; preds = %21
  %25 = load i32, ptr %3, align 4, !dbg !149
  %26 = sext i32 %25 to i64, !dbg !152
  %27 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %26, !dbg !152
  %28 = load i64, ptr %27, align 8, !dbg !152
  %29 = call i32 @pthread_join(i64 noundef %28, ptr noundef null), !dbg !153
  %30 = icmp ne i32 %29, 0, !dbg !154
  br i1 %30, label %31, label %32, !dbg !155

31:                                               ; preds = %24
  call void @exit(i32 noundef 1) #8, !dbg !156
  unreachable, !dbg !156

32:                                               ; preds = %24
  br label %33, !dbg !158

33:                                               ; preds = %32
  %34 = load i32, ptr %3, align 4, !dbg !159
  %35 = add nsw i32 %34, 1, !dbg !159
  store i32 %35, ptr %3, align 4, !dbg !159
  br label %21, !dbg !160, !llvm.loop !161

36:                                               ; preds = %21
  %37 = load i32, ptr @x, align 4, !dbg !163
  %38 = icmp eq i32 %37, 3, !dbg !163
  br i1 %38, label %39, label %43, !dbg !163

39:                                               ; preds = %36
  %40 = load i32, ptr @y, align 4, !dbg !163
  %41 = icmp eq i32 %40, 3, !dbg !163
  br i1 %41, label %42, label %43, !dbg !166

42:                                               ; preds = %39
  br label %44, !dbg !166

43:                                               ; preds = %39, %36
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 50, ptr noundef @__PRETTY_FUNCTION__.main) #8, !dbg !163
  unreachable, !dbg !163

44:                                               ; preds = %42
  %45 = load ptr, ptr @ticket_lock, align 8, !dbg !167
  call void @free(ptr noundef %45) #7, !dbg !168
  ret i32 0, !dbg !169
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_ticket_init(ptr noundef %0) #0 !dbg !170 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !171, metadata !DIExpression()), !dbg !172
  %3 = load ptr, ptr %2, align 8, !dbg !173
  %4 = getelementptr inbounds %struct.ck_spinlock_ticket, ptr %3, i32 0, i32 0, !dbg !174
  store i32 0, ptr %4, align 4, !dbg !175
  call void @ck_pr_barrier(), !dbg !176
  ret void, !dbg !177
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #5

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #4

; Function Attrs: nounwind
declare void @free(ptr noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_faa_32(ptr noundef %0, i32 noundef %1) #0 !dbg !178 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !182, metadata !DIExpression()), !dbg !183
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !184, metadata !DIExpression()), !dbg !183
  %5 = load ptr, ptr %3, align 8, !dbg !183
  %6 = load i32, ptr %4, align 4, !dbg !183
  %7 = call i32 asm sideeffect "lock xaddl $1, $0", "=*m,=q,*m,1,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, ptr elementtype(i32) %5, i32 %6) #7, !dbg !183, !srcloc !185
  store i32 %7, ptr %4, align 4, !dbg !183
  %8 = load i32, ptr %4, align 4, !dbg !183
  ret i32 %8, !dbg !183
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !186 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !189, !srcloc !190
  ret void, !dbg !191
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_32(ptr noundef %0) #0 !dbg !192 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !195, metadata !DIExpression()), !dbg !196
  call void @llvm.dbg.declare(metadata ptr %3, metadata !197, metadata !DIExpression()), !dbg !196
  %4 = load ptr, ptr %2, align 8, !dbg !196
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #7, !dbg !196, !srcloc !198
  store i32 %5, ptr %3, align 4, !dbg !196
  %6 = load i32, ptr %3, align 4, !dbg !196
  ret i32 %6, !dbg !196
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !199 {
  call void @ck_pr_barrier(), !dbg !201
  ret void, !dbg !201
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !202 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !204, !srcloc !205
  ret void, !dbg !206
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !207 {
  call void @ck_pr_barrier(), !dbg !208
  ret void, !dbg !208
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_inc_16(ptr noundef %0) #0 !dbg !209 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !212, metadata !DIExpression()), !dbg !213
  %3 = load ptr, ptr %2, align 8, !dbg !213
  call void asm sideeffect "lock incw $0", "=*m,*m,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i16) %3, ptr elementtype(i16) %3) #7, !dbg !213, !srcloc !214
  ret void, !dbg !213
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind allocsize(0) }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!47, !48, !49, !50, !51, !52, !53}
!llvm.ident = !{!54}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 10, type: !27, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !24, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/ticketlock.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "2e42b97c575f8696a63db17614240b11")
!4 = !{!5, !6, !17, !18, !20}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_ticket_t", file: !8, line: 74, baseType: !9)
!8 = !DIFile(filename: "include/spinlock/ticket.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "c308b76e8f50dc3a0a4f98ae540c37c4")
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_ticket", file: !8, line: 71, size: 32, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !9, file: !8, line: 72, baseType: !12, size: 32)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !13, line: 26, baseType: !14)
!13 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !15, line: 42, baseType: !16)
!15 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!16 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !12)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !13, line: 25, baseType: !22)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !15, line: 40, baseType: !23)
!23 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!24 = !{!0, !25, !28, !34, !39, !45}
!25 = !DIGlobalVariableExpression(var: !26, expr: !DIExpression())
!26 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 10, type: !27, isLocal: false, isDefinition: true)
!27 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(scope: null, file: !3, line: 50, type: !30, isLocal: true, isDefinition: true)
!30 = !DICompositeType(tag: DW_TAG_array_type, baseType: !31, size: 248, elements: !32)
!31 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!32 = !{!33}
!33 = !DISubrange(count: 31)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(scope: null, file: !3, line: 50, type: !36, isLocal: true, isDefinition: true)
!36 = !DICompositeType(tag: DW_TAG_array_type, baseType: !31, size: 152, elements: !37)
!37 = !{!38}
!38 = !DISubrange(count: 19)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(scope: null, file: !3, line: 50, type: !41, isLocal: true, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !42, size: 88, elements: !43)
!42 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !31)
!43 = !{!44}
!44 = !DISubrange(count: 11)
!45 = !DIGlobalVariableExpression(var: !46, expr: !DIExpression())
!46 = distinct !DIGlobalVariable(name: "ticket_lock", scope: !2, file: !3, line: 11, type: !6, isLocal: false, isDefinition: true)
!47 = !{i32 7, !"Dwarf Version", i32 5}
!48 = !{i32 2, !"Debug Info Version", i32 3}
!49 = !{i32 1, !"wchar_size", i32 4}
!50 = !{i32 8, !"PIC Level", i32 2}
!51 = !{i32 7, !"PIE Level", i32 2}
!52 = !{i32 7, !"uwtable", i32 2}
!53 = !{i32 7, !"frame-pointer", i32 2}
!54 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!55 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 13, type: !56, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !58)
!56 = !DISubroutineType(types: !57)
!57 = !{!5, !5}
!58 = !{}
!59 = !DILocalVariable(name: "arg", arg: 1, scope: !55, file: !3, line: 13, type: !5)
!60 = !DILocation(line: 13, column: 17, scope: !55)
!61 = !DILocation(line: 16, column: 29, scope: !55)
!62 = !DILocation(line: 16, column: 5, scope: !55)
!63 = !DILocation(line: 18, column: 6, scope: !55)
!64 = !DILocation(line: 19, column: 6, scope: !55)
!65 = !DILocation(line: 21, column: 31, scope: !55)
!66 = !DILocation(line: 21, column: 5, scope: !55)
!67 = !DILocation(line: 23, column: 5, scope: !55)
!68 = distinct !DISubprogram(name: "ck_spinlock_ticket_lock", scope: !8, file: !8, line: 100, type: !69, scopeLine: 101, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!69 = !DISubroutineType(types: !70)
!70 = !{null, !71}
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!72 = !DILocalVariable(name: "ticket", arg: 1, scope: !68, file: !8, line: 100, type: !71)
!73 = !DILocation(line: 100, column: 52, scope: !68)
!74 = !DILocalVariable(name: "request", scope: !68, file: !8, line: 102, type: !12)
!75 = !DILocation(line: 102, column: 26, scope: !68)
!76 = !DILocalVariable(name: "position", scope: !68, file: !8, line: 102, type: !12)
!77 = !DILocation(line: 102, column: 35, scope: !68)
!78 = !DILocation(line: 105, column: 12, scope: !68)
!79 = !DILocation(line: 105, column: 10, scope: !68)
!80 = !DILocation(line: 108, column: 13, scope: !68)
!81 = !DILocation(line: 108, column: 21, scope: !68)
!82 = !DILocation(line: 108, column: 11, scope: !68)
!83 = !DILocation(line: 109, column: 10, scope: !68)
!84 = !DILocation(line: 111, column: 2, scope: !68)
!85 = !DILocation(line: 111, column: 9, scope: !68)
!86 = !DILocation(line: 111, column: 20, scope: !68)
!87 = !DILocation(line: 111, column: 17, scope: !68)
!88 = !DILocation(line: 112, column: 3, scope: !89)
!89 = distinct !DILexicalBlock(scope: !68, file: !8, line: 111, column: 30)
!90 = !DILocation(line: 113, column: 14, scope: !89)
!91 = !DILocation(line: 113, column: 54, scope: !89)
!92 = !DILocation(line: 113, column: 12, scope: !89)
!93 = distinct !{!93, !84, !94, !95}
!94 = !DILocation(line: 115, column: 2, scope: !68)
!95 = !{!"llvm.loop.mustprogress"}
!96 = !DILocation(line: 117, column: 2, scope: !68)
!97 = !DILocation(line: 118, column: 2, scope: !68)
!98 = distinct !DISubprogram(name: "ck_spinlock_ticket_unlock", scope: !8, file: !8, line: 170, type: !69, scopeLine: 171, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!99 = !DILocalVariable(name: "ticket", arg: 1, scope: !98, file: !8, line: 170, type: !71)
!100 = !DILocation(line: 170, column: 54, scope: !98)
!101 = !DILocation(line: 173, column: 2, scope: !98)
!102 = !DILocation(line: 174, column: 2, scope: !98)
!103 = !DILocation(line: 175, column: 2, scope: !98)
!104 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !105, scopeLine: 27, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !58)
!105 = !DISubroutineType(types: !106)
!106 = !{!27}
!107 = !DILocalVariable(name: "threads", scope: !104, file: !3, line: 28, type: !108)
!108 = !DICompositeType(tag: DW_TAG_array_type, baseType: !109, size: 192, elements: !112)
!109 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !110, line: 27, baseType: !111)
!110 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!111 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!112 = !{!113}
!113 = !DISubrange(count: 3)
!114 = !DILocation(line: 28, column: 15, scope: !104)
!115 = !DILocalVariable(name: "i", scope: !104, file: !3, line: 29, type: !27)
!116 = !DILocation(line: 29, column: 9, scope: !104)
!117 = !DILocation(line: 31, column: 43, scope: !104)
!118 = !DILocation(line: 31, column: 17, scope: !104)
!119 = !DILocation(line: 32, column: 29, scope: !104)
!120 = !DILocation(line: 32, column: 5, scope: !104)
!121 = !DILocation(line: 34, column: 12, scope: !122)
!122 = distinct !DILexicalBlock(scope: !104, file: !3, line: 34, column: 5)
!123 = !DILocation(line: 34, column: 10, scope: !122)
!124 = !DILocation(line: 34, column: 17, scope: !125)
!125 = distinct !DILexicalBlock(scope: !122, file: !3, line: 34, column: 5)
!126 = !DILocation(line: 34, column: 19, scope: !125)
!127 = !DILocation(line: 34, column: 5, scope: !122)
!128 = !DILocation(line: 36, column: 37, scope: !129)
!129 = distinct !DILexicalBlock(scope: !130, file: !3, line: 36, column: 13)
!130 = distinct !DILexicalBlock(scope: !125, file: !3, line: 35, column: 5)
!131 = !DILocation(line: 36, column: 29, scope: !129)
!132 = !DILocation(line: 36, column: 13, scope: !129)
!133 = !DILocation(line: 36, column: 58, scope: !129)
!134 = !DILocation(line: 36, column: 13, scope: !130)
!135 = !DILocation(line: 38, column: 13, scope: !136)
!136 = distinct !DILexicalBlock(scope: !129, file: !3, line: 37, column: 9)
!137 = !DILocation(line: 40, column: 5, scope: !130)
!138 = !DILocation(line: 34, column: 32, scope: !125)
!139 = !DILocation(line: 34, column: 5, scope: !125)
!140 = distinct !{!140, !127, !141, !95}
!141 = !DILocation(line: 40, column: 5, scope: !122)
!142 = !DILocation(line: 42, column: 12, scope: !143)
!143 = distinct !DILexicalBlock(scope: !104, file: !3, line: 42, column: 5)
!144 = !DILocation(line: 42, column: 10, scope: !143)
!145 = !DILocation(line: 42, column: 17, scope: !146)
!146 = distinct !DILexicalBlock(scope: !143, file: !3, line: 42, column: 5)
!147 = !DILocation(line: 42, column: 19, scope: !146)
!148 = !DILocation(line: 42, column: 5, scope: !143)
!149 = !DILocation(line: 44, column: 34, scope: !150)
!150 = distinct !DILexicalBlock(scope: !151, file: !3, line: 44, column: 13)
!151 = distinct !DILexicalBlock(scope: !146, file: !3, line: 43, column: 5)
!152 = !DILocation(line: 44, column: 26, scope: !150)
!153 = !DILocation(line: 44, column: 13, scope: !150)
!154 = !DILocation(line: 44, column: 44, scope: !150)
!155 = !DILocation(line: 44, column: 13, scope: !151)
!156 = !DILocation(line: 46, column: 13, scope: !157)
!157 = distinct !DILexicalBlock(scope: !150, file: !3, line: 45, column: 9)
!158 = !DILocation(line: 48, column: 5, scope: !151)
!159 = !DILocation(line: 42, column: 32, scope: !146)
!160 = !DILocation(line: 42, column: 5, scope: !146)
!161 = distinct !{!161, !148, !162, !95}
!162 = !DILocation(line: 48, column: 5, scope: !143)
!163 = !DILocation(line: 50, column: 5, scope: !164)
!164 = distinct !DILexicalBlock(scope: !165, file: !3, line: 50, column: 5)
!165 = distinct !DILexicalBlock(scope: !104, file: !3, line: 50, column: 5)
!166 = !DILocation(line: 50, column: 5, scope: !165)
!167 = !DILocation(line: 52, column: 10, scope: !104)
!168 = !DILocation(line: 52, column: 5, scope: !104)
!169 = !DILocation(line: 54, column: 5, scope: !104)
!170 = distinct !DISubprogram(name: "ck_spinlock_ticket_init", scope: !8, file: !8, line: 78, type: !69, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!171 = !DILocalVariable(name: "ticket", arg: 1, scope: !170, file: !8, line: 78, type: !71)
!172 = !DILocation(line: 78, column: 52, scope: !170)
!173 = !DILocation(line: 81, column: 2, scope: !170)
!174 = !DILocation(line: 81, column: 10, scope: !170)
!175 = !DILocation(line: 81, column: 16, scope: !170)
!176 = !DILocation(line: 82, column: 2, scope: !170)
!177 = !DILocation(line: 83, column: 2, scope: !170)
!178 = distinct !DISubprogram(name: "ck_pr_faa_32", scope: !179, file: !179, line: 309, type: !180, scopeLine: 309, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!179 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!180 = !DISubroutineType(types: !181)
!181 = !{!12, !17, !12}
!182 = !DILocalVariable(name: "target", arg: 1, scope: !178, file: !179, line: 309, type: !17)
!183 = !DILocation(line: 309, column: 1, scope: !178)
!184 = !DILocalVariable(name: "d", arg: 2, scope: !178, file: !179, line: 309, type: !12)
!185 = !{i64 2147762080}
!186 = distinct !DISubprogram(name: "ck_pr_stall", scope: !179, file: !179, line: 65, type: !187, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!187 = !DISubroutineType(types: !188)
!188 = !{null}
!189 = !DILocation(line: 67, column: 2, scope: !186)
!190 = !{i64 240190}
!191 = !DILocation(line: 68, column: 2, scope: !186)
!192 = distinct !DISubprogram(name: "ck_pr_md_load_32", scope: !179, file: !179, line: 196, type: !193, scopeLine: 196, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!193 = !DISubroutineType(types: !194)
!194 = !{!12, !18}
!195 = !DILocalVariable(name: "target", arg: 1, scope: !192, file: !179, line: 196, type: !18)
!196 = !DILocation(line: 196, column: 1, scope: !192)
!197 = !DILocalVariable(name: "r", scope: !192, file: !179, line: 196, type: !12)
!198 = !{i64 2147753627}
!199 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !200, file: !200, line: 162, type: !187, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!200 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!201 = !DILocation(line: 162, column: 1, scope: !199)
!202 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !203, file: !203, line: 37, type: !187, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!203 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!204 = !DILocation(line: 40, column: 2, scope: !202)
!205 = !{i64 359535}
!206 = !DILocation(line: 41, column: 2, scope: !202)
!207 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !200, file: !200, line: 163, type: !187, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!208 = !DILocation(line: 163, column: 1, scope: !207)
!209 = distinct !DISubprogram(name: "ck_pr_inc_16", scope: !179, file: !179, line: 359, type: !210, scopeLine: 359, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!210 = !DISubroutineType(types: !211)
!211 = !{null, !20}
!212 = !DILocalVariable(name: "target", arg: 1, scope: !209, file: !179, line: 359, type: !20)
!213 = !DILocation(line: 359, column: 1, scope: !209)
!214 = !{i64 2147769105}
