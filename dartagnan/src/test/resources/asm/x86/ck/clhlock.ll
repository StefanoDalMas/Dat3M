; ModuleID = 'tests/clhlock.c'
source_filename = "tests/clhlock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_clh = type { i32, ptr }

@x = dso_local global i32 0, align 4, !dbg !0
@y = dso_local global i32 0, align 4, !dbg !30
@nodes = dso_local global ptr null, align 8, !dbg !52
@lock = dso_local global ptr null, align 8, !dbg !50
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !33
@.str.1 = private unnamed_addr constant [16 x i8] c"tests/clhlock.c\00", align 1, !dbg !39
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1, !dbg !44

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @run(ptr noundef %0) #0 !dbg !62 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !66, metadata !DIExpression()), !dbg !67
  call void @llvm.dbg.declare(metadata ptr %3, metadata !68, metadata !DIExpression()), !dbg !69
  %5 = load ptr, ptr %2, align 8, !dbg !70
  %6 = ptrtoint ptr %5 to i64, !dbg !71
  store i64 %6, ptr %3, align 8, !dbg !69
  call void @llvm.dbg.declare(metadata ptr %4, metadata !72, metadata !DIExpression()), !dbg !73
  %7 = load ptr, ptr @nodes, align 8, !dbg !74
  %8 = load i64, ptr %3, align 8, !dbg !75
  %9 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %7, i64 %8, !dbg !74
  store ptr %9, ptr %4, align 8, !dbg !73
  %10 = load ptr, ptr %4, align 8, !dbg !76
  call void @ck_spinlock_clh_lock(ptr noundef @lock, ptr noundef %10), !dbg !77
  %11 = load i32, ptr @x, align 4, !dbg !78
  %12 = add nsw i32 %11, 1, !dbg !78
  store i32 %12, ptr @x, align 4, !dbg !78
  %13 = load i32, ptr @y, align 4, !dbg !79
  %14 = add nsw i32 %13, 1, !dbg !79
  store i32 %14, ptr @y, align 4, !dbg !79
  call void @ck_spinlock_clh_unlock(ptr noundef %4), !dbg !80
  ret ptr null, !dbg !81
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_clh_lock(ptr noundef %0, ptr noundef %1) #0 !dbg !82 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !86, metadata !DIExpression()), !dbg !87
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !88, metadata !DIExpression()), !dbg !89
  call void @llvm.dbg.declare(metadata ptr %5, metadata !90, metadata !DIExpression()), !dbg !91
  %6 = load ptr, ptr %4, align 8, !dbg !92
  %7 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %6, i32 0, i32 0, !dbg !93
  store i32 1, ptr %7, align 8, !dbg !94
  call void @ck_pr_fence_store_atomic(), !dbg !95
  %8 = load ptr, ptr %3, align 8, !dbg !96
  %9 = load ptr, ptr %4, align 8, !dbg !97
  %10 = call ptr @ck_pr_fas_ptr(ptr noundef %8, ptr noundef %9), !dbg !98
  store ptr %10, ptr %5, align 8, !dbg !99
  %11 = load ptr, ptr %5, align 8, !dbg !100
  %12 = load ptr, ptr %4, align 8, !dbg !101
  %13 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %12, i32 0, i32 1, !dbg !102
  store ptr %11, ptr %13, align 8, !dbg !103
  call void @ck_pr_fence_load(), !dbg !104
  br label %14, !dbg !105

14:                                               ; preds = %19, %2
  %15 = load ptr, ptr %5, align 8, !dbg !106
  %16 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %15, i32 0, i32 0, !dbg !106
  %17 = call i32 @ck_pr_md_load_uint(ptr noundef %16), !dbg !106
  %18 = icmp eq i32 %17, 1, !dbg !107
  br i1 %18, label %19, label %20, !dbg !105

19:                                               ; preds = %14
  call void @ck_pr_stall(), !dbg !108
  br label %14, !dbg !105, !llvm.loop !109

20:                                               ; preds = %14
  call void @ck_pr_fence_lock(), !dbg !112
  ret void, !dbg !113
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_clh_unlock(ptr noundef %0) #0 !dbg !114 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !117, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.declare(metadata ptr %3, metadata !119, metadata !DIExpression()), !dbg !120
  %4 = load ptr, ptr %2, align 8, !dbg !121
  %5 = getelementptr inbounds ptr, ptr %4, i64 0, !dbg !121
  %6 = load ptr, ptr %5, align 8, !dbg !121
  %7 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %6, i32 0, i32 1, !dbg !122
  %8 = load ptr, ptr %7, align 8, !dbg !122
  store ptr %8, ptr %3, align 8, !dbg !123
  call void @ck_pr_fence_unlock(), !dbg !124
  %9 = load ptr, ptr %2, align 8, !dbg !125
  %10 = load ptr, ptr %9, align 8, !dbg !125
  %11 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %10, i32 0, i32 0, !dbg !125
  call void @ck_pr_md_store_uint(ptr noundef %11, i32 noundef 0), !dbg !125
  %12 = load ptr, ptr %3, align 8, !dbg !126
  %13 = load ptr, ptr %2, align 8, !dbg !127
  store ptr %12, ptr %13, align 8, !dbg !128
  ret void, !dbg !129
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !130 {
  %1 = alloca i32, align 4
  %2 = alloca [3 x i64], align 16
  %3 = alloca [3 x i32], align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.ck_spinlock_clh, align 8
  %6 = alloca %struct.ck_spinlock_clh, align 8
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !133, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.declare(metadata ptr %3, metadata !140, metadata !DIExpression()), !dbg !142
  call void @llvm.dbg.declare(metadata ptr %4, metadata !143, metadata !DIExpression()), !dbg !144
  call void @llvm.dbg.declare(metadata ptr %5, metadata !145, metadata !DIExpression()), !dbg !146
  call void @ck_spinlock_clh_init(ptr noundef @lock, ptr noundef %5), !dbg !147
  %7 = call noalias ptr @malloc(i64 noundef 48) #6, !dbg !148
  store ptr %7, ptr @nodes, align 8, !dbg !149
  store i32 0, ptr %4, align 4, !dbg !150
  br label %8, !dbg !152

8:                                                ; preds = %16, %0
  %9 = load i32, ptr %4, align 4, !dbg !153
  %10 = icmp slt i32 %9, 3, !dbg !155
  br i1 %10, label %11, label %19, !dbg !156

11:                                               ; preds = %8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !157, metadata !DIExpression()), !dbg !159
  %12 = load ptr, ptr @nodes, align 8, !dbg !160
  %13 = load i32, ptr %4, align 4, !dbg !161
  %14 = sext i32 %13 to i64, !dbg !160
  %15 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %12, i64 %14, !dbg !160
  call void @ck_spinlock_clh_init(ptr noundef %15, ptr noundef %6), !dbg !162
  br label %16, !dbg !163

16:                                               ; preds = %11
  %17 = load i32, ptr %4, align 4, !dbg !164
  %18 = add nsw i32 %17, 1, !dbg !164
  store i32 %18, ptr %4, align 4, !dbg !164
  br label %8, !dbg !165, !llvm.loop !166

19:                                               ; preds = %8
  store i32 0, ptr %4, align 4, !dbg !168
  br label %20, !dbg !170

20:                                               ; preds = %34, %19
  %21 = load i32, ptr %4, align 4, !dbg !171
  %22 = icmp slt i32 %21, 3, !dbg !173
  br i1 %22, label %23, label %37, !dbg !174

23:                                               ; preds = %20
  %24 = load i32, ptr %4, align 4, !dbg !175
  %25 = sext i32 %24 to i64, !dbg !178
  %26 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %25, !dbg !178
  %27 = load i32, ptr %4, align 4, !dbg !179
  %28 = sext i32 %27 to i64, !dbg !180
  %29 = inttoptr i64 %28 to ptr, !dbg !181
  %30 = call i32 @pthread_create(ptr noundef %26, ptr noundef null, ptr noundef @run, ptr noundef %29) #7, !dbg !182
  %31 = icmp ne i32 %30, 0, !dbg !183
  br i1 %31, label %32, label %33, !dbg !184

32:                                               ; preds = %23
  call void @exit(i32 noundef 1) #8, !dbg !185
  unreachable, !dbg !185

33:                                               ; preds = %23
  br label %34, !dbg !187

34:                                               ; preds = %33
  %35 = load i32, ptr %4, align 4, !dbg !188
  %36 = add nsw i32 %35, 1, !dbg !188
  store i32 %36, ptr %4, align 4, !dbg !188
  br label %20, !dbg !189, !llvm.loop !190

37:                                               ; preds = %20
  store i32 0, ptr %4, align 4, !dbg !192
  br label %38, !dbg !194

38:                                               ; preds = %50, %37
  %39 = load i32, ptr %4, align 4, !dbg !195
  %40 = icmp slt i32 %39, 3, !dbg !197
  br i1 %40, label %41, label %53, !dbg !198

41:                                               ; preds = %38
  %42 = load i32, ptr %4, align 4, !dbg !199
  %43 = sext i32 %42 to i64, !dbg !202
  %44 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %43, !dbg !202
  %45 = load i64, ptr %44, align 8, !dbg !202
  %46 = call i32 @pthread_join(i64 noundef %45, ptr noundef null), !dbg !203
  %47 = icmp ne i32 %46, 0, !dbg !204
  br i1 %47, label %48, label %49, !dbg !205

48:                                               ; preds = %41
  call void @exit(i32 noundef 1) #8, !dbg !206
  unreachable, !dbg !206

49:                                               ; preds = %41
  br label %50, !dbg !208

50:                                               ; preds = %49
  %51 = load i32, ptr %4, align 4, !dbg !209
  %52 = add nsw i32 %51, 1, !dbg !209
  store i32 %52, ptr %4, align 4, !dbg !209
  br label %38, !dbg !210, !llvm.loop !211

53:                                               ; preds = %38
  %54 = load i32, ptr @x, align 4, !dbg !213
  %55 = icmp eq i32 %54, 3, !dbg !213
  br i1 %55, label %56, label %60, !dbg !213

56:                                               ; preds = %53
  %57 = load i32, ptr @y, align 4, !dbg !213
  %58 = icmp eq i32 %57, 3, !dbg !213
  br i1 %58, label %59, label %60, !dbg !216

59:                                               ; preds = %56
  br label %61, !dbg !216

60:                                               ; preds = %56, %53
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 62, ptr noundef @__PRETTY_FUNCTION__.main) #8, !dbg !213
  unreachable, !dbg !213

61:                                               ; preds = %59
  %62 = load ptr, ptr @nodes, align 8, !dbg !217
  call void @free(ptr noundef %62) #7, !dbg !218
  ret i32 0, !dbg !219
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_clh_init(ptr noundef %0, ptr noundef %1) #0 !dbg !220 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !221, metadata !DIExpression()), !dbg !222
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !223, metadata !DIExpression()), !dbg !224
  %5 = load ptr, ptr %4, align 8, !dbg !225
  %6 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %5, i32 0, i32 1, !dbg !226
  store ptr null, ptr %6, align 8, !dbg !227
  %7 = load ptr, ptr %4, align 8, !dbg !228
  %8 = getelementptr inbounds %struct.ck_spinlock_clh, ptr %7, i32 0, i32 0, !dbg !229
  store i32 0, ptr %8, align 8, !dbg !230
  %9 = load ptr, ptr %4, align 8, !dbg !231
  %10 = load ptr, ptr %3, align 8, !dbg !232
  store ptr %9, ptr %10, align 8, !dbg !233
  call void @ck_pr_barrier(), !dbg !234
  ret void, !dbg !235
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

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
define internal void @ck_pr_fence_store_atomic() #0 !dbg !236 {
  call void @ck_pr_barrier(), !dbg !240
  ret void, !dbg !240
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_fas_ptr(ptr noundef %0, ptr noundef %1) #0 !dbg !241 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !245, metadata !DIExpression()), !dbg !246
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !247, metadata !DIExpression()), !dbg !246
  %5 = load ptr, ptr %3, align 8, !dbg !246
  %6 = load ptr, ptr %4, align 8, !dbg !246
  %7 = call ptr asm sideeffect "xchgq $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %5, ptr elementtype(i64) %5, ptr %6) #7, !dbg !246, !srcloc !248
  store ptr %7, ptr %4, align 8, !dbg !246
  %8 = load ptr, ptr %4, align 8, !dbg !246
  ret ptr %8, !dbg !246
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_load() #0 !dbg !249 {
  call void @ck_pr_barrier(), !dbg !250
  ret void, !dbg !250
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !251 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !254, metadata !DIExpression()), !dbg !255
  call void @llvm.dbg.declare(metadata ptr %3, metadata !256, metadata !DIExpression()), !dbg !255
  %4 = load ptr, ptr %2, align 8, !dbg !255
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #7, !dbg !255, !srcloc !257
  store i32 %5, ptr %3, align 4, !dbg !255
  %6 = load i32, ptr %3, align 4, !dbg !255
  ret i32 %6, !dbg !255
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !258 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !259, !srcloc !260
  ret void, !dbg !261
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !262 {
  call void @ck_pr_barrier(), !dbg !263
  ret void, !dbg !263
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !264 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !266, !srcloc !267
  ret void, !dbg !268
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !269 {
  call void @ck_pr_barrier(), !dbg !270
  ret void, !dbg !270
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !271 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !274, metadata !DIExpression()), !dbg !275
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !276, metadata !DIExpression()), !dbg !275
  %5 = load ptr, ptr %3, align 8, !dbg !275
  %6 = load i32, ptr %4, align 4, !dbg !275
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #7, !dbg !275, !srcloc !277
  ret void, !dbg !275
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
!llvm.module.flags = !{!54, !55, !56, !57, !58, !59, !60}
!llvm.ident = !{!61}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 10, type: !32, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !29, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/clhlock.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "5a15870b5dfc2dfc5b27464e1e257b19")
!4 = !{!5, !8, !9, !18, !21, !26, !28}
!5 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !6, line: 76, baseType: !7)
!6 = !DIFile(filename: "/usr/include/stdint.h", directory: "", checksumkind: CSK_MD5, checksum: "bfb03fa9c46a839e35c32b929fbdbb8e")
!7 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_clh_t", file: !11, line: 43, baseType: !12)
!11 = !DIFile(filename: "include/spinlock/clh.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "322aa46b9b9d14e37fa2ad3ef8618ff8")
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_clh", file: !11, line: 39, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "wait", scope: !12, file: !11, line: 40, baseType: !15, size: 32)
!15 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "previous", scope: !12, file: !11, line: 41, baseType: !17, size: 64, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !19, line: 18, baseType: !20)
!19 = !DIFile(filename: "/usr/lib/llvm-18/lib/clang/18/include/__stddef_size_t.h", directory: "", checksumkind: CSK_MD5, checksum: "2c44e821a2b1951cde2eb0fb2e656867")
!20 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !23, line: 27, baseType: !24)
!23 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!24 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !25, line: 45, baseType: !20)
!25 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!29 = !{!0, !30, !33, !39, !44, !50, !52}
!30 = !DIGlobalVariableExpression(var: !31, expr: !DIExpression())
!31 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 10, type: !32, isLocal: false, isDefinition: true)
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(scope: null, file: !3, line: 62, type: !35, isLocal: true, isDefinition: true)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !36, size: 248, elements: !37)
!36 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!37 = !{!38}
!38 = !DISubrange(count: 31)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(scope: null, file: !3, line: 62, type: !41, isLocal: true, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !36, size: 128, elements: !42)
!42 = !{!43}
!43 = !DISubrange(count: 16)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(scope: null, file: !3, line: 62, type: !46, isLocal: true, isDefinition: true)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !47, size: 88, elements: !48)
!47 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !36)
!48 = !{!49}
!49 = !DISubrange(count: 11)
!50 = !DIGlobalVariableExpression(var: !51, expr: !DIExpression())
!51 = distinct !DIGlobalVariable(name: "lock", scope: !2, file: !3, line: 11, type: !9, isLocal: false, isDefinition: true)
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "nodes", scope: !2, file: !3, line: 12, type: !9, isLocal: false, isDefinition: true)
!54 = !{i32 7, !"Dwarf Version", i32 5}
!55 = !{i32 2, !"Debug Info Version", i32 3}
!56 = !{i32 1, !"wchar_size", i32 4}
!57 = !{i32 8, !"PIC Level", i32 2}
!58 = !{i32 7, !"PIE Level", i32 2}
!59 = !{i32 7, !"uwtable", i32 2}
!60 = !{i32 7, !"frame-pointer", i32 2}
!61 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!62 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 14, type: !63, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !65)
!63 = !DISubroutineType(types: !64)
!64 = !{!8, !8}
!65 = !{}
!66 = !DILocalVariable(name: "arg", arg: 1, scope: !62, file: !3, line: 14, type: !8)
!67 = !DILocation(line: 14, column: 17, scope: !62)
!68 = !DILocalVariable(name: "tid", scope: !62, file: !3, line: 16, type: !5)
!69 = !DILocation(line: 16, column: 14, scope: !62)
!70 = !DILocation(line: 16, column: 32, scope: !62)
!71 = !DILocation(line: 16, column: 21, scope: !62)
!72 = !DILocalVariable(name: "thread_node", scope: !62, file: !3, line: 18, type: !9)
!73 = !DILocation(line: 18, column: 24, scope: !62)
!74 = !DILocation(line: 18, column: 39, scope: !62)
!75 = !DILocation(line: 18, column: 45, scope: !62)
!76 = !DILocation(line: 20, column: 33, scope: !62)
!77 = !DILocation(line: 20, column: 5, scope: !62)
!78 = !DILocation(line: 22, column: 6, scope: !62)
!79 = !DILocation(line: 23, column: 6, scope: !62)
!80 = !DILocation(line: 25, column: 5, scope: !62)
!81 = !DILocation(line: 27, column: 5, scope: !62)
!82 = distinct !DISubprogram(name: "ck_spinlock_clh_lock", scope: !11, file: !11, line: 69, type: !83, scopeLine: 70, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !65)
!83 = !DISubroutineType(types: !84)
!84 = !{null, !85, !17}
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!86 = !DILocalVariable(name: "queue", arg: 1, scope: !82, file: !11, line: 69, type: !85)
!87 = !DILocation(line: 69, column: 47, scope: !82)
!88 = !DILocalVariable(name: "thread", arg: 2, scope: !82, file: !11, line: 69, type: !17)
!89 = !DILocation(line: 69, column: 78, scope: !82)
!90 = !DILocalVariable(name: "previous", scope: !82, file: !11, line: 71, type: !17)
!91 = !DILocation(line: 71, column: 26, scope: !82)
!92 = !DILocation(line: 74, column: 2, scope: !82)
!93 = !DILocation(line: 74, column: 10, scope: !82)
!94 = !DILocation(line: 74, column: 15, scope: !82)
!95 = !DILocation(line: 75, column: 2, scope: !82)
!96 = !DILocation(line: 81, column: 27, scope: !82)
!97 = !DILocation(line: 81, column: 34, scope: !82)
!98 = !DILocation(line: 81, column: 13, scope: !82)
!99 = !DILocation(line: 81, column: 11, scope: !82)
!100 = !DILocation(line: 82, column: 21, scope: !82)
!101 = !DILocation(line: 82, column: 2, scope: !82)
!102 = !DILocation(line: 82, column: 10, scope: !82)
!103 = !DILocation(line: 82, column: 19, scope: !82)
!104 = !DILocation(line: 85, column: 2, scope: !82)
!105 = !DILocation(line: 86, column: 2, scope: !82)
!106 = !DILocation(line: 86, column: 9, scope: !82)
!107 = !DILocation(line: 86, column: 42, scope: !82)
!108 = !DILocation(line: 87, column: 3, scope: !82)
!109 = distinct !{!109, !105, !110, !111}
!110 = !DILocation(line: 87, column: 15, scope: !82)
!111 = !{!"llvm.loop.mustprogress"}
!112 = !DILocation(line: 89, column: 2, scope: !82)
!113 = !DILocation(line: 90, column: 2, scope: !82)
!114 = distinct !DISubprogram(name: "ck_spinlock_clh_unlock", scope: !11, file: !11, line: 94, type: !115, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !65)
!115 = !DISubroutineType(types: !116)
!116 = !{null, !85}
!117 = !DILocalVariable(name: "thread", arg: 1, scope: !114, file: !11, line: 94, type: !85)
!118 = !DILocation(line: 94, column: 49, scope: !114)
!119 = !DILocalVariable(name: "previous", scope: !114, file: !11, line: 96, type: !17)
!120 = !DILocation(line: 96, column: 26, scope: !114)
!121 = !DILocation(line: 105, column: 13, scope: !114)
!122 = !DILocation(line: 105, column: 24, scope: !114)
!123 = !DILocation(line: 105, column: 11, scope: !114)
!124 = !DILocation(line: 110, column: 2, scope: !114)
!125 = !DILocation(line: 111, column: 2, scope: !114)
!126 = !DILocation(line: 118, column: 12, scope: !114)
!127 = !DILocation(line: 118, column: 3, scope: !114)
!128 = !DILocation(line: 118, column: 10, scope: !114)
!129 = !DILocation(line: 119, column: 2, scope: !114)
!130 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 30, type: !131, scopeLine: 31, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !65)
!131 = !DISubroutineType(types: !132)
!132 = !{!32}
!133 = !DILocalVariable(name: "threads", scope: !130, file: !3, line: 32, type: !134)
!134 = !DICompositeType(tag: DW_TAG_array_type, baseType: !135, size: 192, elements: !137)
!135 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !136, line: 27, baseType: !20)
!136 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!137 = !{!138}
!138 = !DISubrange(count: 3)
!139 = !DILocation(line: 32, column: 15, scope: !130)
!140 = !DILocalVariable(name: "tids", scope: !130, file: !3, line: 33, type: !141)
!141 = !DICompositeType(tag: DW_TAG_array_type, baseType: !32, size: 96, elements: !137)
!142 = !DILocation(line: 33, column: 9, scope: !130)
!143 = !DILocalVariable(name: "i", scope: !130, file: !3, line: 34, type: !32)
!144 = !DILocation(line: 34, column: 9, scope: !130)
!145 = !DILocalVariable(name: "unowned", scope: !130, file: !3, line: 36, type: !10)
!146 = !DILocation(line: 36, column: 23, scope: !130)
!147 = !DILocation(line: 37, column: 5, scope: !130)
!148 = !DILocation(line: 39, column: 34, scope: !130)
!149 = !DILocation(line: 39, column: 11, scope: !130)
!150 = !DILocation(line: 40, column: 12, scope: !151)
!151 = distinct !DILexicalBlock(scope: !130, file: !3, line: 40, column: 5)
!152 = !DILocation(line: 40, column: 10, scope: !151)
!153 = !DILocation(line: 40, column: 17, scope: !154)
!154 = distinct !DILexicalBlock(scope: !151, file: !3, line: 40, column: 5)
!155 = !DILocation(line: 40, column: 19, scope: !154)
!156 = !DILocation(line: 40, column: 5, scope: !151)
!157 = !DILocalVariable(name: "unowned_node", scope: !158, file: !3, line: 42, type: !10)
!158 = distinct !DILexicalBlock(scope: !154, file: !3, line: 41, column: 5)
!159 = !DILocation(line: 42, column: 27, scope: !158)
!160 = !DILocation(line: 43, column: 31, scope: !158)
!161 = !DILocation(line: 43, column: 37, scope: !158)
!162 = !DILocation(line: 43, column: 9, scope: !158)
!163 = !DILocation(line: 44, column: 5, scope: !158)
!164 = !DILocation(line: 40, column: 32, scope: !154)
!165 = !DILocation(line: 40, column: 5, scope: !154)
!166 = distinct !{!166, !156, !167, !111}
!167 = !DILocation(line: 44, column: 5, scope: !151)
!168 = !DILocation(line: 46, column: 12, scope: !169)
!169 = distinct !DILexicalBlock(scope: !130, file: !3, line: 46, column: 5)
!170 = !DILocation(line: 46, column: 10, scope: !169)
!171 = !DILocation(line: 46, column: 17, scope: !172)
!172 = distinct !DILexicalBlock(scope: !169, file: !3, line: 46, column: 5)
!173 = !DILocation(line: 46, column: 19, scope: !172)
!174 = !DILocation(line: 46, column: 5, scope: !169)
!175 = !DILocation(line: 48, column: 37, scope: !176)
!176 = distinct !DILexicalBlock(scope: !177, file: !3, line: 48, column: 13)
!177 = distinct !DILexicalBlock(scope: !172, file: !3, line: 47, column: 5)
!178 = !DILocation(line: 48, column: 29, scope: !176)
!179 = !DILocation(line: 48, column: 69, scope: !176)
!180 = !DILocation(line: 48, column: 60, scope: !176)
!181 = !DILocation(line: 48, column: 52, scope: !176)
!182 = !DILocation(line: 48, column: 13, scope: !176)
!183 = !DILocation(line: 48, column: 72, scope: !176)
!184 = !DILocation(line: 48, column: 13, scope: !177)
!185 = !DILocation(line: 50, column: 13, scope: !186)
!186 = distinct !DILexicalBlock(scope: !176, file: !3, line: 49, column: 9)
!187 = !DILocation(line: 52, column: 5, scope: !177)
!188 = !DILocation(line: 46, column: 32, scope: !172)
!189 = !DILocation(line: 46, column: 5, scope: !172)
!190 = distinct !{!190, !174, !191, !111}
!191 = !DILocation(line: 52, column: 5, scope: !169)
!192 = !DILocation(line: 54, column: 12, scope: !193)
!193 = distinct !DILexicalBlock(scope: !130, file: !3, line: 54, column: 5)
!194 = !DILocation(line: 54, column: 10, scope: !193)
!195 = !DILocation(line: 54, column: 17, scope: !196)
!196 = distinct !DILexicalBlock(scope: !193, file: !3, line: 54, column: 5)
!197 = !DILocation(line: 54, column: 19, scope: !196)
!198 = !DILocation(line: 54, column: 5, scope: !193)
!199 = !DILocation(line: 56, column: 34, scope: !200)
!200 = distinct !DILexicalBlock(scope: !201, file: !3, line: 56, column: 13)
!201 = distinct !DILexicalBlock(scope: !196, file: !3, line: 55, column: 5)
!202 = !DILocation(line: 56, column: 26, scope: !200)
!203 = !DILocation(line: 56, column: 13, scope: !200)
!204 = !DILocation(line: 56, column: 44, scope: !200)
!205 = !DILocation(line: 56, column: 13, scope: !201)
!206 = !DILocation(line: 58, column: 13, scope: !207)
!207 = distinct !DILexicalBlock(scope: !200, file: !3, line: 57, column: 9)
!208 = !DILocation(line: 60, column: 5, scope: !201)
!209 = !DILocation(line: 54, column: 32, scope: !196)
!210 = !DILocation(line: 54, column: 5, scope: !196)
!211 = distinct !{!211, !198, !212, !111}
!212 = !DILocation(line: 60, column: 5, scope: !193)
!213 = !DILocation(line: 62, column: 5, scope: !214)
!214 = distinct !DILexicalBlock(scope: !215, file: !3, line: 62, column: 5)
!215 = distinct !DILexicalBlock(scope: !130, file: !3, line: 62, column: 5)
!216 = !DILocation(line: 62, column: 5, scope: !215)
!217 = !DILocation(line: 64, column: 10, scope: !130)
!218 = !DILocation(line: 64, column: 5, scope: !130)
!219 = !DILocation(line: 66, column: 5, scope: !130)
!220 = distinct !DISubprogram(name: "ck_spinlock_clh_init", scope: !11, file: !11, line: 46, type: !83, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !65)
!221 = !DILocalVariable(name: "lock", arg: 1, scope: !220, file: !11, line: 46, type: !85)
!222 = !DILocation(line: 46, column: 47, scope: !220)
!223 = !DILocalVariable(name: "unowned", arg: 2, scope: !220, file: !11, line: 46, type: !17)
!224 = !DILocation(line: 46, column: 77, scope: !220)
!225 = !DILocation(line: 49, column: 2, scope: !220)
!226 = !DILocation(line: 49, column: 11, scope: !220)
!227 = !DILocation(line: 49, column: 20, scope: !220)
!228 = !DILocation(line: 50, column: 2, scope: !220)
!229 = !DILocation(line: 50, column: 11, scope: !220)
!230 = !DILocation(line: 50, column: 16, scope: !220)
!231 = !DILocation(line: 51, column: 10, scope: !220)
!232 = !DILocation(line: 51, column: 3, scope: !220)
!233 = !DILocation(line: 51, column: 8, scope: !220)
!234 = !DILocation(line: 52, column: 2, scope: !220)
!235 = !DILocation(line: 53, column: 2, scope: !220)
!236 = distinct !DISubprogram(name: "ck_pr_fence_store_atomic", scope: !237, file: !237, line: 152, type: !238, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!237 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!238 = !DISubroutineType(types: !239)
!239 = !{null}
!240 = !DILocation(line: 152, column: 1, scope: !236)
!241 = distinct !DISubprogram(name: "ck_pr_fas_ptr", scope: !242, file: !242, line: 152, type: !243, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !65)
!242 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!243 = !DISubroutineType(types: !244)
!244 = !{!8, !8, !8}
!245 = !DILocalVariable(name: "target", arg: 1, scope: !241, file: !242, line: 152, type: !8)
!246 = !DILocation(line: 152, column: 1, scope: !241)
!247 = !DILocalVariable(name: "v", arg: 2, scope: !241, file: !242, line: 152, type: !8)
!248 = !{i64 2147748251}
!249 = distinct !DISubprogram(name: "ck_pr_fence_load", scope: !237, file: !237, line: 156, type: !238, scopeLine: 156, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!250 = !DILocation(line: 156, column: 1, scope: !249)
!251 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !242, file: !242, line: 190, type: !252, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !65)
!252 = !DISubroutineType(types: !253)
!253 = !{!15, !26}
!254 = !DILocalVariable(name: "target", arg: 1, scope: !251, file: !242, line: 190, type: !26)
!255 = !DILocation(line: 190, column: 1, scope: !251)
!256 = !DILocalVariable(name: "r", scope: !251, file: !242, line: 190, type: !15)
!257 = !{i64 2147752360}
!258 = distinct !DISubprogram(name: "ck_pr_stall", scope: !242, file: !242, line: 65, type: !238, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!259 = !DILocation(line: 67, column: 2, scope: !258)
!260 = !{i64 240503}
!261 = !DILocation(line: 68, column: 2, scope: !258)
!262 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !237, file: !237, line: 162, type: !238, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!263 = !DILocation(line: 162, column: 1, scope: !262)
!264 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !265, file: !265, line: 37, type: !238, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!265 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!266 = !DILocation(line: 40, column: 2, scope: !264)
!267 = !{i64 359848}
!268 = !DILocation(line: 41, column: 2, scope: !264)
!269 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !237, file: !237, line: 163, type: !238, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!270 = !DILocation(line: 163, column: 1, scope: !269)
!271 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !242, file: !242, line: 276, type: !272, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !65)
!272 = !DISubroutineType(types: !273)
!273 = !{null, !28, !15}
!274 = !DILocalVariable(name: "target", arg: 1, scope: !271, file: !242, line: 276, type: !28)
!275 = !DILocation(line: 276, column: 1, scope: !271)
!276 = !DILocalVariable(name: "v", arg: 2, scope: !271, file: !242, line: 276, type: !15)
!277 = !{i64 2147758354}
