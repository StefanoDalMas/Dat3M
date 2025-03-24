; ModuleID = 'tests/caslock.c'
source_filename = "tests/caslock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_cas = type { i32 }

@x = dso_local global i32 0, align 4, !dbg !0
@y = dso_local global i32 0, align 4, !dbg !17
@lock = dso_local global %struct.ck_spinlock_cas zeroinitializer, align 4, !dbg !37
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !20
@.str.1 = private unnamed_addr constant [16 x i8] c"tests/caslock.c\00", align 1, !dbg !26
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
  %10 = call zeroext i1 @ck_spinlock_cas_trylock(ptr noundef @lock), !dbg !70
  %11 = zext i1 %10 to i8, !dbg !69
  store i8 %11, ptr %4, align 1, !dbg !69
  %12 = load i8, ptr %4, align 1, !dbg !71
  %13 = trunc i8 %12 to i1, !dbg !71
  %14 = zext i1 %13 to i32, !dbg !71
  call void @__VERIFIER_assume(i32 noundef %14), !dbg !72
  br label %16, !dbg !73

15:                                               ; preds = %1
  call void @ck_spinlock_cas_lock(ptr noundef @lock), !dbg !74
  br label %16

16:                                               ; preds = %15, %9
  %17 = load i32, ptr @x, align 4, !dbg !76
  %18 = add nsw i32 %17, 1, !dbg !76
  store i32 %18, ptr @x, align 4, !dbg !76
  %19 = load i32, ptr @y, align 4, !dbg !77
  %20 = add nsw i32 %19, 1, !dbg !77
  store i32 %20, ptr @y, align 4, !dbg !77
  call void @ck_spinlock_cas_unlock(ptr noundef @lock), !dbg !78
  ret ptr null, !dbg !79
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_spinlock_cas_trylock(ptr noundef %0) #0 !dbg !80 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !84, metadata !DIExpression()), !dbg !85
  call void @llvm.dbg.declare(metadata ptr %3, metadata !86, metadata !DIExpression()), !dbg !87
  %4 = load ptr, ptr %2, align 8, !dbg !88
  %5 = getelementptr inbounds %struct.ck_spinlock_cas, ptr %4, i32 0, i32 0, !dbg !89
  %6 = call i32 @ck_pr_fas_uint(ptr noundef %5, i32 noundef 1), !dbg !90
  store i32 %6, ptr %3, align 4, !dbg !91
  call void @ck_pr_fence_lock(), !dbg !92
  %7 = load i32, ptr %3, align 4, !dbg !93
  %8 = icmp ne i32 %7, 0, !dbg !94
  %9 = xor i1 %8, true, !dbg !94
  ret i1 %9, !dbg !95
}

declare void @__VERIFIER_assume(i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_cas_lock(ptr noundef %0) #0 !dbg !96 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !99, metadata !DIExpression()), !dbg !100
  br label %3, !dbg !101

3:                                                ; preds = %16, %1
  %4 = load ptr, ptr %2, align 8, !dbg !102
  %5 = getelementptr inbounds %struct.ck_spinlock_cas, ptr %4, i32 0, i32 0, !dbg !103
  %6 = call zeroext i1 @ck_pr_cas_uint(ptr noundef %5, i32 noundef 0, i32 noundef 1), !dbg !104
  %7 = zext i1 %6 to i32, !dbg !104
  %8 = icmp eq i32 %7, 0, !dbg !105
  br i1 %8, label %9, label %17, !dbg !101

9:                                                ; preds = %3
  br label %10, !dbg !106

10:                                               ; preds = %15, %9
  %11 = load ptr, ptr %2, align 8, !dbg !108
  %12 = getelementptr inbounds %struct.ck_spinlock_cas, ptr %11, i32 0, i32 0, !dbg !108
  %13 = call i32 @ck_pr_md_load_uint(ptr noundef %12), !dbg !108
  %14 = icmp eq i32 %13, 1, !dbg !109
  br i1 %14, label %15, label %16, !dbg !106

15:                                               ; preds = %10
  call void @ck_pr_stall(), !dbg !110
  br label %10, !dbg !106, !llvm.loop !111

16:                                               ; preds = %10
  br label %3, !dbg !101, !llvm.loop !114

17:                                               ; preds = %3
  call void @ck_pr_fence_lock(), !dbg !116
  ret void, !dbg !117
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_cas_unlock(ptr noundef %0) #0 !dbg !118 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !119, metadata !DIExpression()), !dbg !120
  call void @ck_pr_fence_unlock(), !dbg !121
  %3 = load ptr, ptr %2, align 8, !dbg !122
  %4 = getelementptr inbounds %struct.ck_spinlock_cas, ptr %3, i32 0, i32 0, !dbg !122
  call void @ck_pr_md_store_uint(ptr noundef %4, i32 noundef 0), !dbg !122
  ret void, !dbg !123
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !124 {
  %1 = alloca i32, align 4
  %2 = alloca [3 x i64], align 16
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !127, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.declare(metadata ptr %3, metadata !134, metadata !DIExpression()), !dbg !135
  call void @ck_spinlock_cas_init(ptr noundef @lock), !dbg !136
  store i32 0, ptr %3, align 4, !dbg !137
  br label %4, !dbg !139

4:                                                ; preds = %18, %0
  %5 = load i32, ptr %3, align 4, !dbg !140
  %6 = icmp slt i32 %5, 3, !dbg !142
  br i1 %6, label %7, label %21, !dbg !143

7:                                                ; preds = %4
  %8 = load i32, ptr %3, align 4, !dbg !144
  %9 = sext i32 %8 to i64, !dbg !147
  %10 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %9, !dbg !147
  %11 = load i32, ptr %3, align 4, !dbg !148
  %12 = sext i32 %11 to i64, !dbg !149
  %13 = inttoptr i64 %12 to ptr, !dbg !150
  %14 = call i32 @pthread_create(ptr noundef %10, ptr noundef null, ptr noundef @run, ptr noundef %13) #6, !dbg !151
  %15 = icmp ne i32 %14, 0, !dbg !152
  br i1 %15, label %16, label %17, !dbg !153

16:                                               ; preds = %7
  call void @exit(i32 noundef 1) #7, !dbg !154
  unreachable, !dbg !154

17:                                               ; preds = %7
  br label %18, !dbg !156

18:                                               ; preds = %17
  %19 = load i32, ptr %3, align 4, !dbg !157
  %20 = add nsw i32 %19, 1, !dbg !157
  store i32 %20, ptr %3, align 4, !dbg !157
  br label %4, !dbg !158, !llvm.loop !159

21:                                               ; preds = %4
  store i32 0, ptr %3, align 4, !dbg !161
  br label %22, !dbg !163

22:                                               ; preds = %34, %21
  %23 = load i32, ptr %3, align 4, !dbg !164
  %24 = icmp slt i32 %23, 3, !dbg !166
  br i1 %24, label %25, label %37, !dbg !167

25:                                               ; preds = %22
  %26 = load i32, ptr %3, align 4, !dbg !168
  %27 = sext i32 %26 to i64, !dbg !171
  %28 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %27, !dbg !171
  %29 = load i64, ptr %28, align 8, !dbg !171
  %30 = call i32 @pthread_join(i64 noundef %29, ptr noundef null), !dbg !172
  %31 = icmp ne i32 %30, 0, !dbg !173
  br i1 %31, label %32, label %33, !dbg !174

32:                                               ; preds = %25
  call void @exit(i32 noundef 1) #7, !dbg !175
  unreachable, !dbg !175

33:                                               ; preds = %25
  br label %34, !dbg !177

34:                                               ; preds = %33
  %35 = load i32, ptr %3, align 4, !dbg !178
  %36 = add nsw i32 %35, 1, !dbg !178
  store i32 %36, ptr %3, align 4, !dbg !178
  br label %22, !dbg !179, !llvm.loop !180

37:                                               ; preds = %22
  %38 = load i32, ptr @x, align 4, !dbg !182
  %39 = icmp eq i32 %38, 3, !dbg !182
  br i1 %39, label %40, label %44, !dbg !182

40:                                               ; preds = %37
  %41 = load i32, ptr @y, align 4, !dbg !182
  %42 = icmp eq i32 %41, 3, !dbg !182
  br i1 %42, label %43, label %44, !dbg !185

43:                                               ; preds = %40
  br label %45, !dbg !185

44:                                               ; preds = %40, %37
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 59, ptr noundef @__PRETTY_FUNCTION__.main) #7, !dbg !182
  unreachable, !dbg !182

45:                                               ; preds = %43
  ret i32 0, !dbg !186
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_cas_init(ptr noundef %0) #0 !dbg !187 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !188, metadata !DIExpression()), !dbg !189
  %3 = load ptr, ptr %2, align 8, !dbg !190
  %4 = getelementptr inbounds %struct.ck_spinlock_cas, ptr %3, i32 0, i32 0, !dbg !191
  store i32 0, ptr %4, align 4, !dbg !192
  call void @ck_pr_barrier(), !dbg !193
  ret void, !dbg !194
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_fas_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !195 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !199, metadata !DIExpression()), !dbg !200
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !201, metadata !DIExpression()), !dbg !200
  %5 = load ptr, ptr %3, align 8, !dbg !200
  %6 = load i32, ptr %4, align 4, !dbg !200
  %7 = call i32 asm sideeffect "xchgl $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, ptr elementtype(i32) %5, i32 %6) #6, !dbg !200, !srcloc !202
  store i32 %7, ptr %4, align 4, !dbg !200
  %8 = load i32, ptr %4, align 4, !dbg !200
  ret i32 %8, !dbg !200
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !203 {
  call void @ck_pr_barrier(), !dbg !207
  ret void, !dbg !207
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !208 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #6, !dbg !210, !srcloc !211
  ret void, !dbg !212
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_uint(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !213 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !216, metadata !DIExpression()), !dbg !217
  store i32 %1, ptr %5, align 4
  call void @llvm.dbg.declare(metadata ptr %5, metadata !218, metadata !DIExpression()), !dbg !217
  store i32 %2, ptr %6, align 4
  call void @llvm.dbg.declare(metadata ptr %6, metadata !219, metadata !DIExpression()), !dbg !217
  call void @llvm.dbg.declare(metadata ptr %7, metadata !220, metadata !DIExpression()), !dbg !217
  %8 = load ptr, ptr %4, align 8, !dbg !217
  %9 = load i32, ptr %5, align 4, !dbg !217
  %10 = load i32, ptr %6, align 4, !dbg !217
  %11 = call { i8, i32 } asm sideeffect "lock cmpxchgl $3, $0", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %8, i32 %10, ptr elementtype(i32) %8, i32 %9) #6, !dbg !217, !srcloc !221
  %12 = extractvalue { i8, i32 } %11, 0, !dbg !217
  %13 = extractvalue { i8, i32 } %11, 1, !dbg !217
  %14 = icmp ult i8 %12, 2, !dbg !217
  call void @llvm.assume(i1 %14), !dbg !217
  store i8 %12, ptr %7, align 1, !dbg !217
  store i32 %13, ptr %5, align 4, !dbg !217
  %15 = load i8, ptr %7, align 1, !dbg !217
  %16 = trunc i8 %15 to i1, !dbg !217
  ret i1 %16, !dbg !217
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !222 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !225, metadata !DIExpression()), !dbg !226
  call void @llvm.dbg.declare(metadata ptr %3, metadata !227, metadata !DIExpression()), !dbg !226
  %4 = load ptr, ptr %2, align 8, !dbg !226
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #6, !dbg !226, !srcloc !228
  store i32 %5, ptr %3, align 4, !dbg !226
  %6 = load i32, ptr %3, align 4, !dbg !226
  ret i32 %6, !dbg !226
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !229 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #6, !dbg !230, !srcloc !231
  ret void, !dbg !232
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !233 {
  call void @ck_pr_barrier(), !dbg !234
  ret void, !dbg !234
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !235 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !238, metadata !DIExpression()), !dbg !239
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !240, metadata !DIExpression()), !dbg !239
  %5 = load ptr, ptr %3, align 8, !dbg !239
  %6 = load i32, ptr %4, align 4, !dbg !239
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #6, !dbg !239, !srcloc !241
  ret void, !dbg !239
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!44, !45, !46, !47, !48, !49, !50}
!llvm.ident = !{!51}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 15, type: !19, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !16, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/caslock.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "eaf093b9cc44413a628cfc72d3a4aa19")
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
!18 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 15, type: !19, isLocal: false, isDefinition: true)
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DIGlobalVariableExpression(var: !21, expr: !DIExpression())
!21 = distinct !DIGlobalVariable(scope: null, file: !3, line: 59, type: !22, isLocal: true, isDefinition: true)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 248, elements: !24)
!23 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!24 = !{!25}
!25 = !DISubrange(count: 31)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(scope: null, file: !3, line: 59, type: !28, isLocal: true, isDefinition: true)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 128, elements: !29)
!29 = !{!30}
!30 = !DISubrange(count: 16)
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(scope: null, file: !3, line: 59, type: !33, isLocal: true, isDefinition: true)
!33 = !DICompositeType(tag: DW_TAG_array_type, baseType: !34, size: 88, elements: !35)
!34 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !23)
!35 = !{!36}
!36 = !DISubrange(count: 11)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "lock", scope: !2, file: !3, line: 14, type: !39, isLocal: false, isDefinition: true)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_cas_t", file: !40, line: 44, baseType: !41)
!40 = !DIFile(filename: "include/spinlock/cas.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "ce076f374c67b364c8434ea638760107")
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_cas", file: !40, line: 41, size: 32, elements: !42)
!42 = !{!43}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !41, file: !40, line: 42, baseType: !13, size: 32)
!44 = !{i32 7, !"Dwarf Version", i32 5}
!45 = !{i32 2, !"Debug Info Version", i32 3}
!46 = !{i32 1, !"wchar_size", i32 4}
!47 = !{i32 8, !"PIC Level", i32 2}
!48 = !{i32 7, !"PIE Level", i32 2}
!49 = !{i32 7, !"uwtable", i32 2}
!50 = !{i32 7, !"frame-pointer", i32 2}
!51 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!52 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 17, type: !53, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!53 = !DISubroutineType(types: !54)
!54 = !{!8, !8}
!55 = !{}
!56 = !DILocalVariable(name: "arg", arg: 1, scope: !52, file: !3, line: 17, type: !8)
!57 = !DILocation(line: 17, column: 17, scope: !52)
!58 = !DILocalVariable(name: "tid", scope: !52, file: !3, line: 20, type: !5)
!59 = !DILocation(line: 20, column: 14, scope: !52)
!60 = !DILocation(line: 20, column: 32, scope: !52)
!61 = !DILocation(line: 20, column: 21, scope: !52)
!62 = !DILocation(line: 24, column: 9, scope: !63)
!63 = distinct !DILexicalBlock(scope: !52, file: !3, line: 24, column: 9)
!64 = !DILocation(line: 24, column: 13, scope: !63)
!65 = !DILocation(line: 24, column: 9, scope: !52)
!66 = !DILocalVariable(name: "acquired", scope: !67, file: !3, line: 26, type: !68)
!67 = distinct !DILexicalBlock(scope: !63, file: !3, line: 25, column: 5)
!68 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!69 = !DILocation(line: 26, column: 14, scope: !67)
!70 = !DILocation(line: 26, column: 25, scope: !67)
!71 = !DILocation(line: 27, column: 27, scope: !67)
!72 = !DILocation(line: 27, column: 9, scope: !67)
!73 = !DILocation(line: 28, column: 5, scope: !67)
!74 = !DILocation(line: 31, column: 9, scope: !75)
!75 = distinct !DILexicalBlock(scope: !63, file: !3, line: 30, column: 5)
!76 = !DILocation(line: 34, column: 6, scope: !52)
!77 = !DILocation(line: 35, column: 6, scope: !52)
!78 = !DILocation(line: 36, column: 5, scope: !52)
!79 = !DILocation(line: 37, column: 5, scope: !52)
!80 = distinct !DISubprogram(name: "ck_spinlock_cas_trylock", scope: !40, file: !40, line: 58, type: !81, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!81 = !DISubroutineType(types: !82)
!82 = !{!68, !83}
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!84 = !DILocalVariable(name: "lock", arg: 1, scope: !80, file: !40, line: 58, type: !83)
!85 = !DILocation(line: 58, column: 49, scope: !80)
!86 = !DILocalVariable(name: "value", scope: !80, file: !40, line: 60, type: !13)
!87 = !DILocation(line: 60, column: 15, scope: !80)
!88 = !DILocation(line: 62, column: 26, scope: !80)
!89 = !DILocation(line: 62, column: 32, scope: !80)
!90 = !DILocation(line: 62, column: 10, scope: !80)
!91 = !DILocation(line: 62, column: 8, scope: !80)
!92 = !DILocation(line: 63, column: 2, scope: !80)
!93 = !DILocation(line: 64, column: 10, scope: !80)
!94 = !DILocation(line: 64, column: 9, scope: !80)
!95 = !DILocation(line: 64, column: 2, scope: !80)
!96 = distinct !DISubprogram(name: "ck_spinlock_cas_lock", scope: !40, file: !40, line: 77, type: !97, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!97 = !DISubroutineType(types: !98)
!98 = !{null, !83}
!99 = !DILocalVariable(name: "lock", arg: 1, scope: !96, file: !40, line: 77, type: !83)
!100 = !DILocation(line: 77, column: 46, scope: !96)
!101 = !DILocation(line: 80, column: 2, scope: !96)
!102 = !DILocation(line: 80, column: 25, scope: !96)
!103 = !DILocation(line: 80, column: 31, scope: !96)
!104 = !DILocation(line: 80, column: 9, scope: !96)
!105 = !DILocation(line: 80, column: 51, scope: !96)
!106 = !DILocation(line: 81, column: 3, scope: !107)
!107 = distinct !DILexicalBlock(scope: !96, file: !40, line: 80, column: 61)
!108 = !DILocation(line: 81, column: 10, scope: !107)
!109 = !DILocation(line: 81, column: 40, scope: !107)
!110 = !DILocation(line: 82, column: 4, scope: !107)
!111 = distinct !{!111, !106, !112, !113}
!112 = !DILocation(line: 82, column: 16, scope: !107)
!113 = !{!"llvm.loop.mustprogress"}
!114 = distinct !{!114, !101, !115, !113}
!115 = !DILocation(line: 83, column: 2, scope: !96)
!116 = !DILocation(line: 85, column: 2, scope: !96)
!117 = !DILocation(line: 86, column: 2, scope: !96)
!118 = distinct !DISubprogram(name: "ck_spinlock_cas_unlock", scope: !40, file: !40, line: 102, type: !97, scopeLine: 103, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!119 = !DILocalVariable(name: "lock", arg: 1, scope: !118, file: !40, line: 102, type: !83)
!120 = !DILocation(line: 102, column: 48, scope: !118)
!121 = !DILocation(line: 106, column: 2, scope: !118)
!122 = !DILocation(line: 107, column: 2, scope: !118)
!123 = !DILocation(line: 108, column: 2, scope: !118)
!124 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 40, type: !125, scopeLine: 41, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!125 = !DISubroutineType(types: !126)
!126 = !{!19}
!127 = !DILocalVariable(name: "threads", scope: !124, file: !3, line: 42, type: !128)
!128 = !DICompositeType(tag: DW_TAG_array_type, baseType: !129, size: 192, elements: !131)
!129 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !130, line: 27, baseType: !11)
!130 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!131 = !{!132}
!132 = !DISubrange(count: 3)
!133 = !DILocation(line: 42, column: 15, scope: !124)
!134 = !DILocalVariable(name: "i", scope: !124, file: !3, line: 43, type: !19)
!135 = !DILocation(line: 43, column: 9, scope: !124)
!136 = !DILocation(line: 44, column: 5, scope: !124)
!137 = !DILocation(line: 45, column: 12, scope: !138)
!138 = distinct !DILexicalBlock(scope: !124, file: !3, line: 45, column: 5)
!139 = !DILocation(line: 45, column: 10, scope: !138)
!140 = !DILocation(line: 45, column: 17, scope: !141)
!141 = distinct !DILexicalBlock(scope: !138, file: !3, line: 45, column: 5)
!142 = !DILocation(line: 45, column: 19, scope: !141)
!143 = !DILocation(line: 45, column: 5, scope: !138)
!144 = !DILocation(line: 47, column: 37, scope: !145)
!145 = distinct !DILexicalBlock(scope: !146, file: !3, line: 47, column: 13)
!146 = distinct !DILexicalBlock(scope: !141, file: !3, line: 46, column: 5)
!147 = !DILocation(line: 47, column: 29, scope: !145)
!148 = !DILocation(line: 47, column: 69, scope: !145)
!149 = !DILocation(line: 47, column: 60, scope: !145)
!150 = !DILocation(line: 47, column: 52, scope: !145)
!151 = !DILocation(line: 47, column: 13, scope: !145)
!152 = !DILocation(line: 47, column: 72, scope: !145)
!153 = !DILocation(line: 47, column: 13, scope: !146)
!154 = !DILocation(line: 49, column: 13, scope: !155)
!155 = distinct !DILexicalBlock(scope: !145, file: !3, line: 48, column: 9)
!156 = !DILocation(line: 51, column: 5, scope: !146)
!157 = !DILocation(line: 45, column: 32, scope: !141)
!158 = !DILocation(line: 45, column: 5, scope: !141)
!159 = distinct !{!159, !143, !160, !113}
!160 = !DILocation(line: 51, column: 5, scope: !138)
!161 = !DILocation(line: 52, column: 12, scope: !162)
!162 = distinct !DILexicalBlock(scope: !124, file: !3, line: 52, column: 5)
!163 = !DILocation(line: 52, column: 10, scope: !162)
!164 = !DILocation(line: 52, column: 17, scope: !165)
!165 = distinct !DILexicalBlock(scope: !162, file: !3, line: 52, column: 5)
!166 = !DILocation(line: 52, column: 19, scope: !165)
!167 = !DILocation(line: 52, column: 5, scope: !162)
!168 = !DILocation(line: 54, column: 34, scope: !169)
!169 = distinct !DILexicalBlock(scope: !170, file: !3, line: 54, column: 13)
!170 = distinct !DILexicalBlock(scope: !165, file: !3, line: 53, column: 5)
!171 = !DILocation(line: 54, column: 26, scope: !169)
!172 = !DILocation(line: 54, column: 13, scope: !169)
!173 = !DILocation(line: 54, column: 44, scope: !169)
!174 = !DILocation(line: 54, column: 13, scope: !170)
!175 = !DILocation(line: 56, column: 13, scope: !176)
!176 = distinct !DILexicalBlock(scope: !169, file: !3, line: 55, column: 9)
!177 = !DILocation(line: 58, column: 5, scope: !170)
!178 = !DILocation(line: 52, column: 32, scope: !165)
!179 = !DILocation(line: 52, column: 5, scope: !165)
!180 = distinct !{!180, !167, !181, !113}
!181 = !DILocation(line: 58, column: 5, scope: !162)
!182 = !DILocation(line: 59, column: 5, scope: !183)
!183 = distinct !DILexicalBlock(scope: !184, file: !3, line: 59, column: 5)
!184 = distinct !DILexicalBlock(scope: !124, file: !3, line: 59, column: 5)
!185 = !DILocation(line: 59, column: 5, scope: !184)
!186 = !DILocation(line: 60, column: 5, scope: !124)
!187 = distinct !DISubprogram(name: "ck_spinlock_cas_init", scope: !40, file: !40, line: 49, type: !97, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!188 = !DILocalVariable(name: "lock", arg: 1, scope: !187, file: !40, line: 49, type: !83)
!189 = !DILocation(line: 49, column: 46, scope: !187)
!190 = !DILocation(line: 52, column: 2, scope: !187)
!191 = !DILocation(line: 52, column: 8, scope: !187)
!192 = !DILocation(line: 52, column: 14, scope: !187)
!193 = !DILocation(line: 53, column: 2, scope: !187)
!194 = !DILocation(line: 54, column: 2, scope: !187)
!195 = distinct !DISubprogram(name: "ck_pr_fas_uint", scope: !196, file: !196, line: 160, type: !197, scopeLine: 160, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!196 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!197 = !DISubroutineType(types: !198)
!198 = !{!13, !12, !13}
!199 = !DILocalVariable(name: "target", arg: 1, scope: !195, file: !196, line: 160, type: !12)
!200 = !DILocation(line: 160, column: 1, scope: !195)
!201 = !DILocalVariable(name: "v", arg: 2, scope: !195, file: !196, line: 160, type: !13)
!202 = !{i64 2147749354}
!203 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !204, file: !204, line: 162, type: !205, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!204 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!205 = !DISubroutineType(types: !206)
!206 = !{null}
!207 = !DILocation(line: 162, column: 1, scope: !203)
!208 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !209, file: !209, line: 37, type: !205, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!209 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!210 = !DILocation(line: 40, column: 2, scope: !208)
!211 = !{i64 359821}
!212 = !DILocation(line: 41, column: 2, scope: !208)
!213 = distinct !DISubprogram(name: "ck_pr_cas_uint", scope: !196, file: !196, line: 479, type: !214, scopeLine: 479, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!214 = !DISubroutineType(types: !215)
!215 = !{!68, !12, !13, !13}
!216 = !DILocalVariable(name: "target", arg: 1, scope: !213, file: !196, line: 479, type: !12)
!217 = !DILocation(line: 479, column: 1, scope: !213)
!218 = !DILocalVariable(name: "compare", arg: 2, scope: !213, file: !196, line: 479, type: !13)
!219 = !DILocalVariable(name: "set", arg: 3, scope: !213, file: !196, line: 479, type: !13)
!220 = !DILocalVariable(name: "z", scope: !213, file: !196, line: 479, type: !68)
!221 = !{i64 2147817588}
!222 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !196, file: !196, line: 190, type: !223, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!223 = !DISubroutineType(types: !224)
!224 = !{!13, !14}
!225 = !DILocalVariable(name: "target", arg: 1, scope: !222, file: !196, line: 190, type: !14)
!226 = !DILocation(line: 190, column: 1, scope: !222)
!227 = !DILocalVariable(name: "r", scope: !222, file: !196, line: 190, type: !13)
!228 = !{i64 2147752333}
!229 = distinct !DISubprogram(name: "ck_pr_stall", scope: !196, file: !196, line: 65, type: !205, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!230 = !DILocation(line: 67, column: 2, scope: !229)
!231 = !{i64 240476}
!232 = !DILocation(line: 68, column: 2, scope: !229)
!233 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !204, file: !204, line: 163, type: !205, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!234 = !DILocation(line: 163, column: 1, scope: !233)
!235 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !196, file: !196, line: 276, type: !236, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!236 = !DISubroutineType(types: !237)
!237 = !{null, !12, !13}
!238 = !DILocalVariable(name: "target", arg: 1, scope: !235, file: !196, line: 276, type: !12)
!239 = !DILocation(line: 276, column: 1, scope: !235)
!240 = !DILocalVariable(name: "v", arg: 2, scope: !235, file: !196, line: 276, type: !13)
!241 = !{i64 2147758327}
