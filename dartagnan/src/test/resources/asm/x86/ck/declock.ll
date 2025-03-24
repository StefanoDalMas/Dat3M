; ModuleID = 'tests/declock.c'
source_filename = "tests/declock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_dec = type { i32 }

@x = dso_local global i32 0, align 4, !dbg !0
@y = dso_local global i32 0, align 4, !dbg !17
@lock = dso_local global %struct.ck_spinlock_dec zeroinitializer, align 4, !dbg !37
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !20
@.str.1 = private unnamed_addr constant [16 x i8] c"tests/declock.c\00", align 1, !dbg !26
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1, !dbg !31
@nodes = dso_local global ptr null, align 8, !dbg !44

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @run(ptr noundef %0) #0 !dbg !55 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !59, metadata !DIExpression()), !dbg !60
  call void @llvm.dbg.declare(metadata ptr %3, metadata !61, metadata !DIExpression()), !dbg !62
  %5 = load ptr, ptr %2, align 8, !dbg !63
  %6 = ptrtoint ptr %5 to i64, !dbg !64
  store i64 %6, ptr %3, align 8, !dbg !62
  %7 = load i64, ptr %3, align 8, !dbg !65
  %8 = icmp eq i64 %7, 1, !dbg !67
  br i1 %8, label %9, label %15, !dbg !68

9:                                                ; preds = %1
  call void @llvm.dbg.declare(metadata ptr %4, metadata !69, metadata !DIExpression()), !dbg !72
  %10 = call zeroext i1 @ck_spinlock_dec_trylock(ptr noundef @lock), !dbg !73
  %11 = zext i1 %10 to i8, !dbg !72
  store i8 %11, ptr %4, align 1, !dbg !72
  %12 = load i8, ptr %4, align 1, !dbg !74
  %13 = trunc i8 %12 to i1, !dbg !74
  %14 = zext i1 %13 to i32, !dbg !74
  call void @__VERIFIER_assume(i32 noundef %14), !dbg !75
  br label %16, !dbg !76

15:                                               ; preds = %1
  call void @ck_spinlock_dec_lock(ptr noundef @lock), !dbg !77
  br label %16

16:                                               ; preds = %15, %9
  %17 = load i32, ptr @x, align 4, !dbg !79
  %18 = add nsw i32 %17, 1, !dbg !79
  store i32 %18, ptr @x, align 4, !dbg !79
  %19 = load i32, ptr @y, align 4, !dbg !80
  %20 = add nsw i32 %19, 1, !dbg !80
  store i32 %20, ptr @y, align 4, !dbg !80
  call void @ck_spinlock_dec_unlock(ptr noundef @lock), !dbg !81
  ret ptr null, !dbg !82
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_spinlock_dec_trylock(ptr noundef %0) #0 !dbg !83 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !87, metadata !DIExpression()), !dbg !88
  call void @llvm.dbg.declare(metadata ptr %3, metadata !89, metadata !DIExpression()), !dbg !90
  %4 = load ptr, ptr %2, align 8, !dbg !91
  %5 = getelementptr inbounds %struct.ck_spinlock_dec, ptr %4, i32 0, i32 0, !dbg !92
  %6 = call i32 @ck_pr_fas_uint(ptr noundef %5, i32 noundef 0), !dbg !93
  store i32 %6, ptr %3, align 4, !dbg !94
  call void @ck_pr_fence_lock(), !dbg !95
  %7 = load i32, ptr %3, align 4, !dbg !96
  %8 = icmp eq i32 %7, 1, !dbg !97
  ret i1 %8, !dbg !98
}

declare void @__VERIFIER_assume(i32 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_dec_lock(ptr noundef %0) #0 !dbg !99 {
  %2 = alloca ptr, align 8
  %3 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !102, metadata !DIExpression()), !dbg !103
  call void @llvm.dbg.declare(metadata ptr %3, metadata !104, metadata !DIExpression()), !dbg !105
  br label %4, !dbg !106

4:                                                ; preds = %19, %1
  %5 = load ptr, ptr %2, align 8, !dbg !107
  %6 = getelementptr inbounds %struct.ck_spinlock_dec, ptr %5, i32 0, i32 0, !dbg !111
  call void @ck_pr_dec_uint_zero(ptr noundef %6, ptr noundef %3), !dbg !112
  %7 = load i8, ptr %3, align 1, !dbg !113
  %8 = trunc i8 %7 to i1, !dbg !113
  %9 = zext i1 %8 to i32, !dbg !113
  %10 = icmp eq i32 %9, 1, !dbg !115
  br i1 %10, label %11, label %12, !dbg !116

11:                                               ; preds = %4
  br label %20, !dbg !117

12:                                               ; preds = %4
  br label %13, !dbg !118

13:                                               ; preds = %18, %12
  %14 = load ptr, ptr %2, align 8, !dbg !119
  %15 = getelementptr inbounds %struct.ck_spinlock_dec, ptr %14, i32 0, i32 0, !dbg !119
  %16 = call i32 @ck_pr_md_load_uint(ptr noundef %15), !dbg !119
  %17 = icmp ne i32 %16, 1, !dbg !120
  br i1 %17, label %18, label %19, !dbg !118

18:                                               ; preds = %13
  call void @ck_pr_stall(), !dbg !121
  br label %13, !dbg !118, !llvm.loop !122

19:                                               ; preds = %13
  br label %4, !dbg !125, !llvm.loop !126

20:                                               ; preds = %11
  call void @ck_pr_fence_lock(), !dbg !129
  ret void, !dbg !130
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_dec_unlock(ptr noundef %0) #0 !dbg !131 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !132, metadata !DIExpression()), !dbg !133
  call void @ck_pr_fence_unlock(), !dbg !134
  %3 = load ptr, ptr %2, align 8, !dbg !135
  %4 = getelementptr inbounds %struct.ck_spinlock_dec, ptr %3, i32 0, i32 0, !dbg !135
  call void @ck_pr_md_store_uint(ptr noundef %4, i32 noundef 1), !dbg !135
  ret void, !dbg !136
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !137 {
  %1 = alloca i32, align 4
  %2 = alloca [2 x i64], align 16
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !140, metadata !DIExpression()), !dbg !146
  call void @llvm.dbg.declare(metadata ptr %3, metadata !147, metadata !DIExpression()), !dbg !148
  call void @ck_spinlock_dec_init(ptr noundef @lock), !dbg !149
  store i32 0, ptr %3, align 4, !dbg !150
  br label %4, !dbg !152

4:                                                ; preds = %18, %0
  %5 = load i32, ptr %3, align 4, !dbg !153
  %6 = icmp slt i32 %5, 2, !dbg !155
  br i1 %6, label %7, label %21, !dbg !156

7:                                                ; preds = %4
  %8 = load i32, ptr %3, align 4, !dbg !157
  %9 = sext i32 %8 to i64, !dbg !160
  %10 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 %9, !dbg !160
  %11 = load i32, ptr %3, align 4, !dbg !161
  %12 = sext i32 %11 to i64, !dbg !162
  %13 = inttoptr i64 %12 to ptr, !dbg !163
  %14 = call i32 @pthread_create(ptr noundef %10, ptr noundef null, ptr noundef @run, ptr noundef %13) #5, !dbg !164
  %15 = icmp ne i32 %14, 0, !dbg !165
  br i1 %15, label %16, label %17, !dbg !166

16:                                               ; preds = %7
  call void @exit(i32 noundef 1) #6, !dbg !167
  unreachable, !dbg !167

17:                                               ; preds = %7
  br label %18, !dbg !169

18:                                               ; preds = %17
  %19 = load i32, ptr %3, align 4, !dbg !170
  %20 = add nsw i32 %19, 1, !dbg !170
  store i32 %20, ptr %3, align 4, !dbg !170
  br label %4, !dbg !171, !llvm.loop !172

21:                                               ; preds = %4
  store i32 0, ptr %3, align 4, !dbg !174
  br label %22, !dbg !176

22:                                               ; preds = %34, %21
  %23 = load i32, ptr %3, align 4, !dbg !177
  %24 = icmp slt i32 %23, 2, !dbg !179
  br i1 %24, label %25, label %37, !dbg !180

25:                                               ; preds = %22
  %26 = load i32, ptr %3, align 4, !dbg !181
  %27 = sext i32 %26 to i64, !dbg !184
  %28 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 %27, !dbg !184
  %29 = load i64, ptr %28, align 8, !dbg !184
  %30 = call i32 @pthread_join(i64 noundef %29, ptr noundef null), !dbg !185
  %31 = icmp ne i32 %30, 0, !dbg !186
  br i1 %31, label %32, label %33, !dbg !187

32:                                               ; preds = %25
  call void @exit(i32 noundef 1) #6, !dbg !188
  unreachable, !dbg !188

33:                                               ; preds = %25
  br label %34, !dbg !190

34:                                               ; preds = %33
  %35 = load i32, ptr %3, align 4, !dbg !191
  %36 = add nsw i32 %35, 1, !dbg !191
  store i32 %36, ptr %3, align 4, !dbg !191
  br label %22, !dbg !192, !llvm.loop !193

37:                                               ; preds = %22
  %38 = load i32, ptr @x, align 4, !dbg !195
  %39 = icmp eq i32 %38, 2, !dbg !195
  br i1 %39, label %40, label %44, !dbg !195

40:                                               ; preds = %37
  %41 = load i32, ptr @y, align 4, !dbg !195
  %42 = icmp eq i32 %41, 2, !dbg !195
  br i1 %42, label %43, label %44, !dbg !198

43:                                               ; preds = %40
  br label %45, !dbg !198

44:                                               ; preds = %40, %37
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 59, ptr noundef @__PRETTY_FUNCTION__.main) #6, !dbg !195
  unreachable, !dbg !195

45:                                               ; preds = %43
  ret i32 0, !dbg !199
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_dec_init(ptr noundef %0) #0 !dbg !200 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !201, metadata !DIExpression()), !dbg !202
  %3 = load ptr, ptr %2, align 8, !dbg !203
  %4 = getelementptr inbounds %struct.ck_spinlock_dec, ptr %3, i32 0, i32 0, !dbg !204
  store i32 1, ptr %4, align 4, !dbg !205
  call void @ck_pr_barrier(), !dbg !206
  ret void, !dbg !207
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #3

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_fas_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !208 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !212, metadata !DIExpression()), !dbg !213
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !214, metadata !DIExpression()), !dbg !213
  %5 = load ptr, ptr %3, align 8, !dbg !213
  %6 = load i32, ptr %4, align 4, !dbg !213
  %7 = call i32 asm sideeffect "xchgl $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, ptr elementtype(i32) %5, i32 %6) #5, !dbg !213, !srcloc !215
  store i32 %7, ptr %4, align 4, !dbg !213
  %8 = load i32, ptr %4, align 4, !dbg !213
  ret i32 %8, !dbg !213
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !216 {
  call void @ck_pr_barrier(), !dbg !220
  ret void, !dbg !220
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !221 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #5, !dbg !223, !srcloc !224
  ret void, !dbg !225
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_dec_uint_zero(ptr noundef %0, ptr noundef %1) #0 !dbg !226 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !230, metadata !DIExpression()), !dbg !231
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !232, metadata !DIExpression()), !dbg !231
  %5 = load ptr, ptr %3, align 8, !dbg !231
  %6 = call zeroext i1 @ck_pr_dec_uint_is_zero(ptr noundef %5), !dbg !231
  %7 = load ptr, ptr %4, align 8, !dbg !231
  %8 = zext i1 %6 to i8, !dbg !231
  store i8 %8, ptr %7, align 1, !dbg !231
  ret void, !dbg !231
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !233 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !236, metadata !DIExpression()), !dbg !237
  call void @llvm.dbg.declare(metadata ptr %3, metadata !238, metadata !DIExpression()), !dbg !237
  %4 = load ptr, ptr %2, align 8, !dbg !237
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #5, !dbg !237, !srcloc !239
  store i32 %5, ptr %3, align 4, !dbg !237
  %6 = load i32, ptr %3, align 4, !dbg !237
  ret i32 %6, !dbg !237
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !240 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #5, !dbg !241, !srcloc !242
  ret void, !dbg !243
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_dec_uint_is_zero(ptr noundef %0) #0 !dbg !244 {
  %2 = alloca ptr, align 8
  %3 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !247, metadata !DIExpression()), !dbg !248
  call void @llvm.dbg.declare(metadata ptr %3, metadata !249, metadata !DIExpression()), !dbg !248
  %4 = load ptr, ptr %2, align 8, !dbg !248
  call void asm sideeffect "lock decl $0; setz $1", "=*m,=*rm,*m,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4, ptr elementtype(i8) %3, ptr elementtype(i32) %4) #5, !dbg !248, !srcloc !250
  %5 = load i8, ptr %3, align 1, !dbg !248
  %6 = trunc i8 %5 to i1, !dbg !248
  ret i1 %6, !dbg !248
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !251 {
  call void @ck_pr_barrier(), !dbg !252
  ret void, !dbg !252
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !253 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !256, metadata !DIExpression()), !dbg !257
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !258, metadata !DIExpression()), !dbg !257
  %5 = load ptr, ptr %3, align 8, !dbg !257
  %6 = load i32, ptr %4, align 4, !dbg !257
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #5, !dbg !257, !srcloc !259
  ret void, !dbg !257
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!47, !48, !49, !50, !51, !52, !53}
!llvm.ident = !{!54}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 12, type: !19, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !16, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/declock.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "30fa24ff6bfc9964c8665f42f6017fd2")
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
!16 = !{!0, !17, !20, !26, !31, !37, !44}
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 12, type: !19, isLocal: false, isDefinition: true)
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
!38 = distinct !DIGlobalVariable(name: "lock", scope: !2, file: !3, line: 13, type: !39, isLocal: false, isDefinition: true)
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_dec_t", file: !40, line: 46, baseType: !41)
!40 = !DIFile(filename: "include/spinlock/dec.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "ebf75fdec979dfc7f06fb0ef6eee88f9")
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_dec", file: !40, line: 43, size: 32, elements: !42)
!42 = !{!43}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !41, file: !40, line: 44, baseType: !13, size: 32)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(name: "nodes", scope: !2, file: !3, line: 14, type: !46, isLocal: false, isDefinition: true)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!47 = !{i32 7, !"Dwarf Version", i32 5}
!48 = !{i32 2, !"Debug Info Version", i32 3}
!49 = !{i32 1, !"wchar_size", i32 4}
!50 = !{i32 8, !"PIC Level", i32 2}
!51 = !{i32 7, !"PIE Level", i32 2}
!52 = !{i32 7, !"uwtable", i32 2}
!53 = !{i32 7, !"frame-pointer", i32 2}
!54 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!55 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 16, type: !56, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !58)
!56 = !DISubroutineType(types: !57)
!57 = !{!8, !8}
!58 = !{}
!59 = !DILocalVariable(name: "arg", arg: 1, scope: !55, file: !3, line: 16, type: !8)
!60 = !DILocation(line: 16, column: 17, scope: !55)
!61 = !DILocalVariable(name: "tid", scope: !55, file: !3, line: 18, type: !5)
!62 = !DILocation(line: 18, column: 14, scope: !55)
!63 = !DILocation(line: 18, column: 31, scope: !55)
!64 = !DILocation(line: 18, column: 21, scope: !55)
!65 = !DILocation(line: 20, column: 9, scope: !66)
!66 = distinct !DILexicalBlock(scope: !55, file: !3, line: 20, column: 9)
!67 = !DILocation(line: 20, column: 13, scope: !66)
!68 = !DILocation(line: 20, column: 9, scope: !55)
!69 = !DILocalVariable(name: "acquired", scope: !70, file: !3, line: 22, type: !71)
!70 = distinct !DILexicalBlock(scope: !66, file: !3, line: 21, column: 5)
!71 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!72 = !DILocation(line: 22, column: 14, scope: !70)
!73 = !DILocation(line: 22, column: 25, scope: !70)
!74 = !DILocation(line: 23, column: 27, scope: !70)
!75 = !DILocation(line: 23, column: 9, scope: !70)
!76 = !DILocation(line: 24, column: 5, scope: !70)
!77 = !DILocation(line: 27, column: 9, scope: !78)
!78 = distinct !DILexicalBlock(scope: !66, file: !3, line: 26, column: 5)
!79 = !DILocation(line: 29, column: 6, scope: !55)
!80 = !DILocation(line: 30, column: 6, scope: !55)
!81 = !DILocation(line: 31, column: 5, scope: !55)
!82 = !DILocation(line: 33, column: 5, scope: !55)
!83 = distinct !DISubprogram(name: "ck_spinlock_dec_trylock", scope: !40, file: !40, line: 60, type: !84, scopeLine: 61, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!84 = !DISubroutineType(types: !85)
!85 = !{!71, !86}
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!87 = !DILocalVariable(name: "lock", arg: 1, scope: !83, file: !40, line: 60, type: !86)
!88 = !DILocation(line: 60, column: 49, scope: !83)
!89 = !DILocalVariable(name: "value", scope: !83, file: !40, line: 62, type: !13)
!90 = !DILocation(line: 62, column: 15, scope: !83)
!91 = !DILocation(line: 64, column: 26, scope: !83)
!92 = !DILocation(line: 64, column: 32, scope: !83)
!93 = !DILocation(line: 64, column: 10, scope: !83)
!94 = !DILocation(line: 64, column: 8, scope: !83)
!95 = !DILocation(line: 65, column: 2, scope: !83)
!96 = !DILocation(line: 66, column: 9, scope: !83)
!97 = !DILocation(line: 66, column: 15, scope: !83)
!98 = !DILocation(line: 66, column: 2, scope: !83)
!99 = distinct !DISubprogram(name: "ck_spinlock_dec_lock", scope: !40, file: !40, line: 80, type: !100, scopeLine: 81, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!100 = !DISubroutineType(types: !101)
!101 = !{null, !86}
!102 = !DILocalVariable(name: "lock", arg: 1, scope: !99, file: !40, line: 80, type: !86)
!103 = !DILocation(line: 80, column: 46, scope: !99)
!104 = !DILocalVariable(name: "r", scope: !99, file: !40, line: 82, type: !71)
!105 = !DILocation(line: 82, column: 7, scope: !99)
!106 = !DILocation(line: 84, column: 2, scope: !99)
!107 = !DILocation(line: 90, column: 24, scope: !108)
!108 = distinct !DILexicalBlock(scope: !109, file: !40, line: 84, column: 11)
!109 = distinct !DILexicalBlock(scope: !110, file: !40, line: 84, column: 2)
!110 = distinct !DILexicalBlock(scope: !99, file: !40, line: 84, column: 2)
!111 = !DILocation(line: 90, column: 30, scope: !108)
!112 = !DILocation(line: 90, column: 3, scope: !108)
!113 = !DILocation(line: 91, column: 7, scope: !114)
!114 = distinct !DILexicalBlock(scope: !108, file: !40, line: 91, column: 7)
!115 = !DILocation(line: 91, column: 9, scope: !114)
!116 = !DILocation(line: 91, column: 7, scope: !108)
!117 = !DILocation(line: 92, column: 4, scope: !114)
!118 = !DILocation(line: 95, column: 3, scope: !108)
!119 = !DILocation(line: 95, column: 10, scope: !108)
!120 = !DILocation(line: 95, column: 40, scope: !108)
!121 = !DILocation(line: 96, column: 4, scope: !108)
!122 = distinct !{!122, !118, !123, !124}
!123 = !DILocation(line: 96, column: 16, scope: !108)
!124 = !{!"llvm.loop.mustprogress"}
!125 = !DILocation(line: 84, column: 2, scope: !109)
!126 = distinct !{!126, !127, !128}
!127 = !DILocation(line: 84, column: 2, scope: !110)
!128 = !DILocation(line: 97, column: 2, scope: !110)
!129 = !DILocation(line: 99, column: 2, scope: !99)
!130 = !DILocation(line: 100, column: 2, scope: !99)
!131 = distinct !DISubprogram(name: "ck_spinlock_dec_unlock", scope: !40, file: !40, line: 123, type: !100, scopeLine: 124, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!132 = !DILocalVariable(name: "lock", arg: 1, scope: !131, file: !40, line: 123, type: !86)
!133 = !DILocation(line: 123, column: 48, scope: !131)
!134 = !DILocation(line: 126, column: 2, scope: !131)
!135 = !DILocation(line: 132, column: 2, scope: !131)
!136 = !DILocation(line: 133, column: 2, scope: !131)
!137 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 36, type: !138, scopeLine: 37, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !58)
!138 = !DISubroutineType(types: !139)
!139 = !{!19}
!140 = !DILocalVariable(name: "threads", scope: !137, file: !3, line: 38, type: !141)
!141 = !DICompositeType(tag: DW_TAG_array_type, baseType: !142, size: 128, elements: !144)
!142 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !143, line: 27, baseType: !11)
!143 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!144 = !{!145}
!145 = !DISubrange(count: 2)
!146 = !DILocation(line: 38, column: 15, scope: !137)
!147 = !DILocalVariable(name: "i", scope: !137, file: !3, line: 39, type: !19)
!148 = !DILocation(line: 39, column: 9, scope: !137)
!149 = !DILocation(line: 41, column: 5, scope: !137)
!150 = !DILocation(line: 43, column: 12, scope: !151)
!151 = distinct !DILexicalBlock(scope: !137, file: !3, line: 43, column: 5)
!152 = !DILocation(line: 43, column: 10, scope: !151)
!153 = !DILocation(line: 43, column: 17, scope: !154)
!154 = distinct !DILexicalBlock(scope: !151, file: !3, line: 43, column: 5)
!155 = !DILocation(line: 43, column: 19, scope: !154)
!156 = !DILocation(line: 43, column: 5, scope: !151)
!157 = !DILocation(line: 45, column: 37, scope: !158)
!158 = distinct !DILexicalBlock(scope: !159, file: !3, line: 45, column: 13)
!159 = distinct !DILexicalBlock(scope: !154, file: !3, line: 44, column: 5)
!160 = !DILocation(line: 45, column: 29, scope: !158)
!161 = !DILocation(line: 45, column: 68, scope: !158)
!162 = !DILocation(line: 45, column: 60, scope: !158)
!163 = !DILocation(line: 45, column: 52, scope: !158)
!164 = !DILocation(line: 45, column: 13, scope: !158)
!165 = !DILocation(line: 45, column: 71, scope: !158)
!166 = !DILocation(line: 45, column: 13, scope: !159)
!167 = !DILocation(line: 47, column: 13, scope: !168)
!168 = distinct !DILexicalBlock(scope: !158, file: !3, line: 46, column: 9)
!169 = !DILocation(line: 49, column: 5, scope: !159)
!170 = !DILocation(line: 43, column: 32, scope: !154)
!171 = !DILocation(line: 43, column: 5, scope: !154)
!172 = distinct !{!172, !156, !173, !124}
!173 = !DILocation(line: 49, column: 5, scope: !151)
!174 = !DILocation(line: 51, column: 12, scope: !175)
!175 = distinct !DILexicalBlock(scope: !137, file: !3, line: 51, column: 5)
!176 = !DILocation(line: 51, column: 10, scope: !175)
!177 = !DILocation(line: 51, column: 17, scope: !178)
!178 = distinct !DILexicalBlock(scope: !175, file: !3, line: 51, column: 5)
!179 = !DILocation(line: 51, column: 19, scope: !178)
!180 = !DILocation(line: 51, column: 5, scope: !175)
!181 = !DILocation(line: 53, column: 34, scope: !182)
!182 = distinct !DILexicalBlock(scope: !183, file: !3, line: 53, column: 13)
!183 = distinct !DILexicalBlock(scope: !178, file: !3, line: 52, column: 5)
!184 = !DILocation(line: 53, column: 26, scope: !182)
!185 = !DILocation(line: 53, column: 13, scope: !182)
!186 = !DILocation(line: 53, column: 44, scope: !182)
!187 = !DILocation(line: 53, column: 13, scope: !183)
!188 = !DILocation(line: 55, column: 13, scope: !189)
!189 = distinct !DILexicalBlock(scope: !182, file: !3, line: 54, column: 9)
!190 = !DILocation(line: 57, column: 5, scope: !183)
!191 = !DILocation(line: 51, column: 32, scope: !178)
!192 = !DILocation(line: 51, column: 5, scope: !178)
!193 = distinct !{!193, !180, !194, !124}
!194 = !DILocation(line: 57, column: 5, scope: !175)
!195 = !DILocation(line: 59, column: 5, scope: !196)
!196 = distinct !DILexicalBlock(scope: !197, file: !3, line: 59, column: 5)
!197 = distinct !DILexicalBlock(scope: !137, file: !3, line: 59, column: 5)
!198 = !DILocation(line: 59, column: 5, scope: !197)
!199 = !DILocation(line: 61, column: 5, scope: !137)
!200 = distinct !DISubprogram(name: "ck_spinlock_dec_init", scope: !40, file: !40, line: 51, type: !100, scopeLine: 52, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!201 = !DILocalVariable(name: "lock", arg: 1, scope: !200, file: !40, line: 51, type: !86)
!202 = !DILocation(line: 51, column: 46, scope: !200)
!203 = !DILocation(line: 54, column: 2, scope: !200)
!204 = !DILocation(line: 54, column: 8, scope: !200)
!205 = !DILocation(line: 54, column: 14, scope: !200)
!206 = !DILocation(line: 55, column: 2, scope: !200)
!207 = !DILocation(line: 56, column: 2, scope: !200)
!208 = distinct !DISubprogram(name: "ck_pr_fas_uint", scope: !209, file: !209, line: 160, type: !210, scopeLine: 160, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!209 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!210 = !DISubroutineType(types: !211)
!211 = !{!13, !12, !13}
!212 = !DILocalVariable(name: "target", arg: 1, scope: !208, file: !209, line: 160, type: !12)
!213 = !DILocation(line: 160, column: 1, scope: !208)
!214 = !DILocalVariable(name: "v", arg: 2, scope: !208, file: !209, line: 160, type: !13)
!215 = !{i64 2147749198}
!216 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !217, file: !217, line: 162, type: !218, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!217 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!218 = !DISubroutineType(types: !219)
!219 = !{null}
!220 = !DILocation(line: 162, column: 1, scope: !216)
!221 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !222, file: !222, line: 37, type: !218, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!222 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!223 = !DILocation(line: 40, column: 2, scope: !221)
!224 = !{i64 359665}
!225 = !DILocation(line: 41, column: 2, scope: !221)
!226 = distinct !DISubprogram(name: "ck_pr_dec_uint_zero", scope: !217, file: !217, line: 755, type: !227, scopeLine: 755, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!227 = !DISubroutineType(types: !228)
!228 = !{null, !12, !229}
!229 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!230 = !DILocalVariable(name: "target", arg: 1, scope: !226, file: !217, line: 755, type: !12)
!231 = !DILocation(line: 755, column: 1, scope: !226)
!232 = !DILocalVariable(name: "zero", arg: 2, scope: !226, file: !217, line: 755, type: !229)
!233 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !209, file: !209, line: 190, type: !234, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!234 = !DISubroutineType(types: !235)
!235 = !{!13, !14}
!236 = !DILocalVariable(name: "target", arg: 1, scope: !233, file: !209, line: 190, type: !14)
!237 = !DILocation(line: 190, column: 1, scope: !233)
!238 = !DILocalVariable(name: "r", scope: !233, file: !209, line: 190, type: !13)
!239 = !{i64 2147752177}
!240 = distinct !DISubprogram(name: "ck_pr_stall", scope: !209, file: !209, line: 65, type: !218, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!241 = !DILocation(line: 67, column: 2, scope: !240)
!242 = !{i64 240320}
!243 = !DILocation(line: 68, column: 2, scope: !240)
!244 = distinct !DISubprogram(name: "ck_pr_dec_uint_is_zero", scope: !209, file: !209, line: 360, type: !245, scopeLine: 360, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!245 = !DISubroutineType(types: !246)
!246 = !{!71, !12}
!247 = !DILocalVariable(name: "target", arg: 1, scope: !244, file: !209, line: 360, type: !12)
!248 = !DILocation(line: 360, column: 1, scope: !244)
!249 = !DILocalVariable(name: "ret", scope: !244, file: !209, line: 360, type: !71)
!250 = !{i64 2147774423}
!251 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !217, file: !217, line: 163, type: !218, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!252 = !DILocation(line: 163, column: 1, scope: !251)
!253 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !209, file: !209, line: 276, type: !254, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !58)
!254 = !DISubroutineType(types: !255)
!255 = !{null, !12, !13}
!256 = !DILocalVariable(name: "target", arg: 1, scope: !253, file: !209, line: 276, type: !12)
!257 = !DILocation(line: 276, column: 1, scope: !253)
!258 = !DILocalVariable(name: "v", arg: 2, scope: !253, file: !209, line: 276, type: !13)
!259 = !{i64 2147758171}
