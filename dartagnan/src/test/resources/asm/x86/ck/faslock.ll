; ModuleID = 'tests/faslock.c'
source_filename = "tests/faslock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_fas = type { i32 }

@x = dso_local global i32 0, align 4, !dbg !0
@y = dso_local global i32 0, align 4, !dbg !17
@lock = dso_local global %struct.ck_spinlock_fas zeroinitializer, align 4, !dbg !37
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !20
@.str.1 = private unnamed_addr constant [16 x i8] c"tests/faslock.c\00", align 1, !dbg !26
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1, !dbg !31

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @run(ptr noundef %0) #0 !dbg !52 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !56, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.declare(metadata ptr %3, metadata !58, metadata !DIExpression()), !dbg !59
  %5 = load ptr, ptr %2, align 8, !dbg !60
  %6 = ptrtoint ptr %5 to i64, !dbg !61
  store i64 %6, ptr %3, align 8, !dbg !59
  %7 = load i64, ptr %3, align 8, !dbg !62
  %8 = icmp eq i64 %7, 2, !dbg !64
  br i1 %8, label %9, label %15, !dbg !65

9:                                                ; preds = %1
  call void @llvm.dbg.declare(metadata ptr %4, metadata !66, metadata !DIExpression()), !dbg !69
  %10 = call zeroext i1 @ck_spinlock_fas_trylock(ptr noundef @lock), !dbg !70
  %11 = zext i1 %10 to i8, !dbg !69
  store i8 %11, ptr %4, align 1, !dbg !69
  %12 = load i8, ptr %4, align 1, !dbg !71
  %13 = trunc i8 %12 to i1, !dbg !71
  %14 = zext i1 %13 to i32, !dbg !71
  call void @__VERIFIER_assume(i32 noundef %14), !dbg !72
  br label %16, !dbg !73

15:                                               ; preds = %1
  call void @ck_spinlock_fas_lock(ptr noundef @lock), !dbg !74
  br label %16

16:                                               ; preds = %15, %9
  %17 = load i32, ptr @x, align 4, !dbg !76
  %18 = add nsw i32 %17, 1, !dbg !76
  store i32 %18, ptr @x, align 4, !dbg !76
  %19 = load i32, ptr @y, align 4, !dbg !77
  %20 = add nsw i32 %19, 1, !dbg !77
  store i32 %20, ptr @y, align 4, !dbg !77
  call void @ck_spinlock_fas_unlock(ptr noundef @lock), !dbg !78
  ret ptr null, !dbg !79
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_spinlock_fas_trylock(ptr noundef %0) #0 !dbg !80 {
  %2 = alloca ptr, align 8
  %3 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !84, metadata !DIExpression()), !dbg !85
  call void @llvm.dbg.declare(metadata ptr %3, metadata !86, metadata !DIExpression()), !dbg !87
  %4 = load ptr, ptr %2, align 8, !dbg !88
  %5 = getelementptr inbounds %struct.ck_spinlock_fas, ptr %4, i32 0, i32 0, !dbg !89
  %6 = call i32 @ck_pr_fas_uint(ptr noundef %5, i32 noundef 1), !dbg !90
  %7 = icmp ne i32 %6, 0, !dbg !90
  %8 = zext i1 %7 to i8, !dbg !91
  store i8 %8, ptr %3, align 1, !dbg !91
  call void @ck_pr_fence_lock(), !dbg !92
  %9 = load i8, ptr %3, align 1, !dbg !93
  %10 = trunc i8 %9 to i1, !dbg !93
  %11 = xor i1 %10, true, !dbg !94
  ret i1 %11, !dbg !95
}

declare void @__VERIFIER_assume(i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_fas_lock(ptr noundef %0) #0 !dbg !96 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !99, metadata !DIExpression()), !dbg !100
  br label %3, !dbg !101

3:                                                ; preds = %20, %1
  %4 = load ptr, ptr %2, align 8, !dbg !102
  %5 = getelementptr inbounds %struct.ck_spinlock_fas, ptr %4, i32 0, i32 0, !dbg !102
  %6 = call i32 @ck_pr_fas_uint(ptr noundef %5, i32 noundef 1), !dbg !102
  %7 = icmp eq i32 %6, 1, !dbg !102
  %8 = xor i1 %7, true, !dbg !102
  %9 = xor i1 %8, true, !dbg !102
  %10 = zext i1 %9 to i32, !dbg !102
  %11 = sext i32 %10 to i64, !dbg !102
  %12 = icmp ne i64 %11, 0, !dbg !101
  br i1 %12, label %13, label %21, !dbg !101

13:                                               ; preds = %3
  br label %14, !dbg !103

14:                                               ; preds = %15, %13
  call void @ck_pr_stall(), !dbg !105
  br label %15, !dbg !107

15:                                               ; preds = %14
  %16 = load ptr, ptr %2, align 8, !dbg !108
  %17 = getelementptr inbounds %struct.ck_spinlock_fas, ptr %16, i32 0, i32 0, !dbg !108
  %18 = call i32 @ck_pr_md_load_uint(ptr noundef %17), !dbg !108
  %19 = icmp eq i32 %18, 1, !dbg !109
  br i1 %19, label %14, label %20, !dbg !107, !llvm.loop !110

20:                                               ; preds = %15
  br label %3, !dbg !101, !llvm.loop !113

21:                                               ; preds = %3
  call void @ck_pr_fence_lock(), !dbg !115
  ret void, !dbg !116
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_fas_unlock(ptr noundef %0) #0 !dbg !117 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !118, metadata !DIExpression()), !dbg !119
  call void @ck_pr_fence_unlock(), !dbg !120
  %3 = load ptr, ptr %2, align 8, !dbg !121
  %4 = getelementptr inbounds %struct.ck_spinlock_fas, ptr %3, i32 0, i32 0, !dbg !121
  call void @ck_pr_md_store_uint(ptr noundef %4, i32 noundef 0), !dbg !121
  ret void, !dbg !122
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !123 {
  %1 = alloca i32, align 4
  %2 = alloca [3 x i64], align 16
  %3 = alloca [3 x i32], align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !126, metadata !DIExpression()), !dbg !132
  call void @llvm.dbg.declare(metadata ptr %3, metadata !133, metadata !DIExpression()), !dbg !135
  call void @llvm.dbg.declare(metadata ptr %4, metadata !136, metadata !DIExpression()), !dbg !137
  call void @ck_spinlock_fas_init(ptr noundef @lock), !dbg !138
  store i32 0, ptr %4, align 4, !dbg !139
  br label %5, !dbg !141

5:                                                ; preds = %19, %0
  %6 = load i32, ptr %4, align 4, !dbg !142
  %7 = icmp slt i32 %6, 3, !dbg !144
  br i1 %7, label %8, label %22, !dbg !145

8:                                                ; preds = %5
  %9 = load i32, ptr %4, align 4, !dbg !146
  %10 = sext i32 %9 to i64, !dbg !149
  %11 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %10, !dbg !149
  %12 = load i32, ptr %4, align 4, !dbg !150
  %13 = sext i32 %12 to i64, !dbg !151
  %14 = inttoptr i64 %13 to ptr, !dbg !152
  %15 = call i32 @pthread_create(ptr noundef %11, ptr noundef null, ptr noundef @run, ptr noundef %14) #5, !dbg !153
  %16 = icmp ne i32 %15, 0, !dbg !154
  br i1 %16, label %17, label %18, !dbg !155

17:                                               ; preds = %8
  call void @exit(i32 noundef 1) #6, !dbg !156
  unreachable, !dbg !156

18:                                               ; preds = %8
  br label %19, !dbg !158

19:                                               ; preds = %18
  %20 = load i32, ptr %4, align 4, !dbg !159
  %21 = add nsw i32 %20, 1, !dbg !159
  store i32 %21, ptr %4, align 4, !dbg !159
  br label %5, !dbg !160, !llvm.loop !161

22:                                               ; preds = %5
  store i32 0, ptr %4, align 4, !dbg !163
  br label %23, !dbg !165

23:                                               ; preds = %35, %22
  %24 = load i32, ptr %4, align 4, !dbg !166
  %25 = icmp slt i32 %24, 3, !dbg !168
  br i1 %25, label %26, label %38, !dbg !169

26:                                               ; preds = %23
  %27 = load i32, ptr %4, align 4, !dbg !170
  %28 = sext i32 %27 to i64, !dbg !173
  %29 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %28, !dbg !173
  %30 = load i64, ptr %29, align 8, !dbg !173
  %31 = call i32 @pthread_join(i64 noundef %30, ptr noundef null), !dbg !174
  %32 = icmp ne i32 %31, 0, !dbg !175
  br i1 %32, label %33, label %34, !dbg !176

33:                                               ; preds = %26
  call void @exit(i32 noundef 1) #6, !dbg !177
  unreachable, !dbg !177

34:                                               ; preds = %26
  br label %35, !dbg !179

35:                                               ; preds = %34
  %36 = load i32, ptr %4, align 4, !dbg !180
  %37 = add nsw i32 %36, 1, !dbg !180
  store i32 %37, ptr %4, align 4, !dbg !180
  br label %23, !dbg !181, !llvm.loop !182

38:                                               ; preds = %23
  %39 = load i32, ptr @x, align 4, !dbg !184
  %40 = icmp eq i32 %39, 3, !dbg !184
  br i1 %40, label %41, label %45, !dbg !184

41:                                               ; preds = %38
  %42 = load i32, ptr @y, align 4, !dbg !184
  %43 = icmp eq i32 %42, 3, !dbg !184
  br i1 %43, label %44, label %45, !dbg !187

44:                                               ; preds = %41
  br label %46, !dbg !187

45:                                               ; preds = %41, %38
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 53, ptr noundef @__PRETTY_FUNCTION__.main) #6, !dbg !184
  unreachable, !dbg !184

46:                                               ; preds = %44
  ret i32 0, !dbg !188
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_fas_init(ptr noundef %0) #0 !dbg !189 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !190, metadata !DIExpression()), !dbg !191
  %3 = load ptr, ptr %2, align 8, !dbg !192
  %4 = getelementptr inbounds %struct.ck_spinlock_fas, ptr %3, i32 0, i32 0, !dbg !193
  store i32 0, ptr %4, align 4, !dbg !194
  call void @ck_pr_barrier(), !dbg !195
  ret void, !dbg !196
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_fas_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !197 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !201, metadata !DIExpression()), !dbg !202
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !203, metadata !DIExpression()), !dbg !202
  %5 = load ptr, ptr %3, align 8, !dbg !202
  %6 = load i32, ptr %4, align 4, !dbg !202
  %7 = call i32 asm sideeffect "xchgl $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, ptr elementtype(i32) %5, i32 %6) #5, !dbg !202, !srcloc !204
  store i32 %7, ptr %4, align 4, !dbg !202
  %8 = load i32, ptr %4, align 4, !dbg !202
  ret i32 %8, !dbg !202
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !205 {
  call void @ck_pr_barrier(), !dbg !209
  ret void, !dbg !209
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !210 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #5, !dbg !212, !srcloc !213
  ret void, !dbg !214
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !215 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #5, !dbg !216, !srcloc !217
  ret void, !dbg !218
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !219 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !222, metadata !DIExpression()), !dbg !223
  call void @llvm.dbg.declare(metadata ptr %3, metadata !224, metadata !DIExpression()), !dbg !223
  %4 = load ptr, ptr %2, align 8, !dbg !223
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #5, !dbg !223, !srcloc !225
  store i32 %5, ptr %3, align 4, !dbg !223
  %6 = load i32, ptr %3, align 4, !dbg !223
  ret i32 %6, !dbg !223
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !226 {
  call void @ck_pr_barrier(), !dbg !227
  ret void, !dbg !227
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !228 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !231, metadata !DIExpression()), !dbg !232
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !233, metadata !DIExpression()), !dbg !232
  %5 = load ptr, ptr %3, align 8, !dbg !232
  %6 = load i32, ptr %4, align 4, !dbg !232
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #5, !dbg !232, !srcloc !234
  ret void, !dbg !232
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!44, !45, !46, !47, !48, !49, !50}
!llvm.ident = !{!51}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 11, type: !19, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !16, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/faslock.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "1e2a99fb364862612c862585639e0034")
!4 = !{!5, !8, !9, !12, !14}
!5 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !6, line: 76, baseType: !7)
!6 = !DIFile(filename: "/usr/include/stdint.h", directory: "", checksumkind: CSK_MD5, checksum: "bfb03fa9c46a839e35c32b929fbdbb8e")
!7 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !10, line: 18, baseType: !11)
!10 = !DIFile(filename: "/usr/lib/llvm-18/lib/clang/18/include/__stddef_size_t.h", directory: "", checksumkind: CSK_MD5, checksum: "2c44e821a2b1951cde2eb0fb2e656867")
!11 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!16 = !{!0, !17, !20, !26, !31, !37}
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 11, type: !19, isLocal: false, isDefinition: true)
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DIGlobalVariableExpression(var: !21, expr: !DIExpression())
!21 = distinct !DIGlobalVariable(scope: null, file: !3, line: 53, type: !22, isLocal: true, isDefinition: true)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 248, elements: !24)
!23 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!24 = !{!25}
!25 = !DISubrange(count: 31)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(scope: null, file: !3, line: 53, type: !28, isLocal: true, isDefinition: true)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 128, elements: !29)
!29 = !{!30}
!30 = !DISubrange(count: 16)
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(scope: null, file: !3, line: 53, type: !33, isLocal: true, isDefinition: true)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !34, size: 88, elements: !35)
!34 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !23)
!35 = !{!36}
!36 = !DISubrange(count: 11)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "lock", scope: !2, file: !3, line: 12, type: !39, isLocal: false, isDefinition: true)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_fas_t", file: !40, line: 42, baseType: !41)
!40 = !DIFile(filename: "include/spinlock/fas.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "999805093e3ea65ae15690fa7c76e04b")
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_fas", file: !40, line: 39, size: 32, elements: !42)
!42 = !{!43}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !41, file: !40, line: 40, baseType: !13, size: 32)
!44 = !{i32 7, !"Dwarf Version", i32 5}
!45 = !{i32 2, !"Debug Info Version", i32 3}
!46 = !{i32 1, !"wchar_size", i32 4}
!47 = !{i32 8, !"PIC Level", i32 2}
!48 = !{i32 7, !"PIE Level", i32 2}
!49 = !{i32 7, !"uwtable", i32 2}
!50 = !{i32 7, !"frame-pointer", i32 2}
!51 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!52 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 14, type: !53, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!53 = !DISubroutineType(types: !54)
!54 = !{!8, !8}
!55 = !{}
!56 = !DILocalVariable(name: "arg", arg: 1, scope: !52, file: !3, line: 14, type: !8)
!57 = !DILocation(line: 14, column: 17, scope: !52)
!58 = !DILocalVariable(name: "tid", scope: !52, file: !3, line: 16, type: !5)
!59 = !DILocation(line: 16, column: 14, scope: !52)
!60 = !DILocation(line: 16, column: 32, scope: !52)
!61 = !DILocation(line: 16, column: 21, scope: !52)
!62 = !DILocation(line: 18, column: 9, scope: !63)
!63 = distinct !DILexicalBlock(scope: !52, file: !3, line: 18, column: 9)
!64 = !DILocation(line: 18, column: 13, scope: !63)
!65 = !DILocation(line: 18, column: 9, scope: !52)
!66 = !DILocalVariable(name: "acquired", scope: !67, file: !3, line: 20, type: !68)
!67 = distinct !DILexicalBlock(scope: !63, file: !3, line: 19, column: 5)
!68 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!69 = !DILocation(line: 20, column: 14, scope: !67)
!70 = !DILocation(line: 20, column: 25, scope: !67)
!71 = !DILocation(line: 21, column: 27, scope: !67)
!72 = !DILocation(line: 21, column: 9, scope: !67)
!73 = !DILocation(line: 22, column: 5, scope: !67)
!74 = !DILocation(line: 25, column: 9, scope: !75)
!75 = distinct !DILexicalBlock(scope: !63, file: !3, line: 24, column: 5)
!76 = !DILocation(line: 27, column: 6, scope: !52)
!77 = !DILocation(line: 28, column: 6, scope: !52)
!78 = !DILocation(line: 29, column: 5, scope: !52)
!79 = !DILocation(line: 30, column: 5, scope: !52)
!80 = distinct !DISubprogram(name: "ck_spinlock_fas_trylock", scope: !40, file: !40, line: 56, type: !81, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!81 = !DISubroutineType(types: !82)
!82 = !{!68, !83}
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!84 = !DILocalVariable(name: "lock", arg: 1, scope: !80, file: !40, line: 56, type: !83)
!85 = !DILocation(line: 56, column: 49, scope: !80)
!86 = !DILocalVariable(name: "value", scope: !80, file: !40, line: 58, type: !68)
!87 = !DILocation(line: 58, column: 7, scope: !80)
!88 = !DILocation(line: 60, column: 26, scope: !80)
!89 = !DILocation(line: 60, column: 32, scope: !80)
!90 = !DILocation(line: 60, column: 10, scope: !80)
!91 = !DILocation(line: 60, column: 8, scope: !80)
!92 = !DILocation(line: 61, column: 2, scope: !80)
!93 = !DILocation(line: 63, column: 10, scope: !80)
!94 = !DILocation(line: 63, column: 9, scope: !80)
!95 = !DILocation(line: 63, column: 2, scope: !80)
!96 = distinct !DISubprogram(name: "ck_spinlock_fas_lock", scope: !40, file: !40, line: 77, type: !97, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!97 = !DISubroutineType(types: !98)
!98 = !{null, !83}
!99 = !DILocalVariable(name: "lock", arg: 1, scope: !96, file: !40, line: 77, type: !83)
!100 = !DILocation(line: 77, column: 46, scope: !96)
!101 = !DILocation(line: 80, column: 9, scope: !96)
!102 = !DILocation(line: 80, column: 16, scope: !96)
!103 = !DILocation(line: 81, column: 17, scope: !104)
!104 = distinct !DILexicalBlock(scope: !96, file: !40, line: 80, column: 76)
!105 = !DILocation(line: 82, column: 25, scope: !106)
!106 = distinct !DILexicalBlock(scope: !104, file: !40, line: 81, column: 20)
!107 = !DILocation(line: 83, column: 17, scope: !106)
!108 = !DILocation(line: 83, column: 26, scope: !104)
!109 = !DILocation(line: 83, column: 56, scope: !104)
!110 = distinct !{!110, !103, !111, !112}
!111 = !DILocation(line: 83, column: 63, scope: !104)
!112 = !{!"llvm.loop.mustprogress"}
!113 = distinct !{!113, !101, !114, !112}
!114 = !DILocation(line: 84, column: 9, scope: !96)
!115 = !DILocation(line: 86, column: 2, scope: !96)
!116 = !DILocation(line: 87, column: 2, scope: !96)
!117 = distinct !DISubprogram(name: "ck_spinlock_fas_unlock", scope: !40, file: !40, line: 103, type: !97, scopeLine: 104, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!118 = !DILocalVariable(name: "lock", arg: 1, scope: !117, file: !40, line: 103, type: !83)
!119 = !DILocation(line: 103, column: 48, scope: !117)
!120 = !DILocation(line: 106, column: 2, scope: !117)
!121 = !DILocation(line: 107, column: 2, scope: !117)
!122 = !DILocation(line: 108, column: 2, scope: !117)
!123 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 33, type: !124, scopeLine: 34, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!124 = !DISubroutineType(types: !125)
!125 = !{!19}
!126 = !DILocalVariable(name: "threads", scope: !123, file: !3, line: 35, type: !127)
!127 = !DICompositeType(tag: DW_TAG_array_type, baseType: !128, size: 192, elements: !130)
!128 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !129, line: 27, baseType: !11)
!129 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!130 = !{!131}
!131 = !DISubrange(count: 3)
!132 = !DILocation(line: 35, column: 15, scope: !123)
!133 = !DILocalVariable(name: "tids", scope: !123, file: !3, line: 36, type: !134)
!134 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 96, elements: !130)
!135 = !DILocation(line: 36, column: 9, scope: !123)
!136 = !DILocalVariable(name: "i", scope: !123, file: !3, line: 37, type: !19)
!137 = !DILocation(line: 37, column: 9, scope: !123)
!138 = !DILocation(line: 38, column: 5, scope: !123)
!139 = !DILocation(line: 39, column: 12, scope: !140)
!140 = distinct !DILexicalBlock(scope: !123, file: !3, line: 39, column: 5)
!141 = !DILocation(line: 39, column: 10, scope: !140)
!142 = !DILocation(line: 39, column: 17, scope: !143)
!143 = distinct !DILexicalBlock(scope: !140, file: !3, line: 39, column: 5)
!144 = !DILocation(line: 39, column: 19, scope: !143)
!145 = !DILocation(line: 39, column: 5, scope: !140)
!146 = !DILocation(line: 41, column: 37, scope: !147)
!147 = distinct !DILexicalBlock(scope: !148, file: !3, line: 41, column: 13)
!148 = distinct !DILexicalBlock(scope: !143, file: !3, line: 40, column: 5)
!149 = !DILocation(line: 41, column: 29, scope: !147)
!150 = !DILocation(line: 41, column: 68, scope: !147)
!151 = !DILocation(line: 41, column: 60, scope: !147)
!152 = !DILocation(line: 41, column: 52, scope: !147)
!153 = !DILocation(line: 41, column: 13, scope: !147)
!154 = !DILocation(line: 41, column: 71, scope: !147)
!155 = !DILocation(line: 41, column: 13, scope: !148)
!156 = !DILocation(line: 43, column: 13, scope: !157)
!157 = distinct !DILexicalBlock(scope: !147, file: !3, line: 42, column: 9)
!158 = !DILocation(line: 45, column: 5, scope: !148)
!159 = !DILocation(line: 39, column: 32, scope: !143)
!160 = !DILocation(line: 39, column: 5, scope: !143)
!161 = distinct !{!161, !145, !162, !112}
!162 = !DILocation(line: 45, column: 5, scope: !140)
!163 = !DILocation(line: 46, column: 12, scope: !164)
!164 = distinct !DILexicalBlock(scope: !123, file: !3, line: 46, column: 5)
!165 = !DILocation(line: 46, column: 10, scope: !164)
!166 = !DILocation(line: 46, column: 17, scope: !167)
!167 = distinct !DILexicalBlock(scope: !164, file: !3, line: 46, column: 5)
!168 = !DILocation(line: 46, column: 19, scope: !167)
!169 = !DILocation(line: 46, column: 5, scope: !164)
!170 = !DILocation(line: 48, column: 34, scope: !171)
!171 = distinct !DILexicalBlock(scope: !172, file: !3, line: 48, column: 13)
!172 = distinct !DILexicalBlock(scope: !167, file: !3, line: 47, column: 5)
!173 = !DILocation(line: 48, column: 26, scope: !171)
!174 = !DILocation(line: 48, column: 13, scope: !171)
!175 = !DILocation(line: 48, column: 44, scope: !171)
!176 = !DILocation(line: 48, column: 13, scope: !172)
!177 = !DILocation(line: 50, column: 13, scope: !178)
!178 = distinct !DILexicalBlock(scope: !171, file: !3, line: 49, column: 9)
!179 = !DILocation(line: 52, column: 5, scope: !172)
!180 = !DILocation(line: 46, column: 32, scope: !167)
!181 = !DILocation(line: 46, column: 5, scope: !167)
!182 = distinct !{!182, !169, !183, !112}
!183 = !DILocation(line: 52, column: 5, scope: !164)
!184 = !DILocation(line: 53, column: 5, scope: !185)
!185 = distinct !DILexicalBlock(scope: !186, file: !3, line: 53, column: 5)
!186 = distinct !DILexicalBlock(scope: !123, file: !3, line: 53, column: 5)
!187 = !DILocation(line: 53, column: 5, scope: !186)
!188 = !DILocation(line: 54, column: 5, scope: !123)
!189 = distinct !DISubprogram(name: "ck_spinlock_fas_init", scope: !40, file: !40, line: 47, type: !97, scopeLine: 48, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!190 = !DILocalVariable(name: "lock", arg: 1, scope: !189, file: !40, line: 47, type: !83)
!191 = !DILocation(line: 47, column: 46, scope: !189)
!192 = !DILocation(line: 50, column: 2, scope: !189)
!193 = !DILocation(line: 50, column: 8, scope: !189)
!194 = !DILocation(line: 50, column: 14, scope: !189)
!195 = !DILocation(line: 51, column: 2, scope: !189)
!196 = !DILocation(line: 52, column: 2, scope: !189)
!197 = distinct !DISubprogram(name: "ck_pr_fas_uint", scope: !198, file: !198, line: 160, type: !199, scopeLine: 160, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!198 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!199 = !DISubroutineType(types: !200)
!200 = !{!13, !12, !13}
!201 = !DILocalVariable(name: "target", arg: 1, scope: !197, file: !198, line: 160, type: !12)
!202 = !DILocation(line: 160, column: 1, scope: !197)
!203 = !DILocalVariable(name: "v", arg: 2, scope: !197, file: !198, line: 160, type: !13)
!204 = !{i64 2147749171}
!205 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !206, file: !206, line: 162, type: !207, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!206 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!207 = !DISubroutineType(types: !208)
!208 = !{null}
!209 = !DILocation(line: 162, column: 1, scope: !205)
!210 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !211, file: !211, line: 37, type: !207, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!211 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!212 = !DILocation(line: 40, column: 2, scope: !210)
!213 = !{i64 359638}
!214 = !DILocation(line: 41, column: 2, scope: !210)
!215 = distinct !DISubprogram(name: "ck_pr_stall", scope: !198, file: !198, line: 65, type: !207, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!216 = !DILocation(line: 67, column: 2, scope: !215)
!217 = !{i64 240293}
!218 = !DILocation(line: 68, column: 2, scope: !215)
!219 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !198, file: !198, line: 190, type: !220, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!220 = !DISubroutineType(types: !221)
!221 = !{!13, !14}
!222 = !DILocalVariable(name: "target", arg: 1, scope: !219, file: !198, line: 190, type: !14)
!223 = !DILocation(line: 190, column: 1, scope: !219)
!224 = !DILocalVariable(name: "r", scope: !219, file: !198, line: 190, type: !13)
!225 = !{i64 2147752150}
!226 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !206, file: !206, line: 163, type: !207, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!227 = !DILocation(line: 163, column: 1, scope: !226)
!228 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !198, file: !198, line: 276, type: !229, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!229 = !DISubroutineType(types: !230)
!230 = !{null, !12, !13}
!231 = !DILocalVariable(name: "target", arg: 1, scope: !228, file: !198, line: 276, type: !12)
!232 = !DILocation(line: 276, column: 1, scope: !228)
!233 = !DILocalVariable(name: "v", arg: 2, scope: !228, file: !198, line: 276, type: !13)
!234 = !{i64 2147758144}
