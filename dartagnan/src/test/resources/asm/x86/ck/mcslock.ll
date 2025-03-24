; ModuleID = 'tests/mcslock.c'
source_filename = "tests/mcslock.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_mcs = type { i32, ptr }

@lock = dso_local global ptr null, align 8, !dbg !0
@x = dso_local global i32 0, align 4, !dbg !31
@y = dso_local global i32 0, align 4, !dbg !34
@nodes = dso_local global ptr null, align 8, !dbg !53
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !36
@.str.1 = private unnamed_addr constant [16 x i8] c"tests/mcslock.c\00", align 1, !dbg !42
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1, !dbg !47

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @run(ptr noundef %0) #0 !dbg !63 {
  %2 = alloca ptr, align 8
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !67, metadata !DIExpression()), !dbg !68
  call void @llvm.dbg.declare(metadata ptr %3, metadata !69, metadata !DIExpression()), !dbg !70
  %5 = load ptr, ptr %2, align 8, !dbg !71
  %6 = ptrtoint ptr %5 to i64, !dbg !72
  store i64 %6, ptr %3, align 8, !dbg !70
  call void @llvm.dbg.declare(metadata ptr %4, metadata !73, metadata !DIExpression()), !dbg !74
  %7 = load ptr, ptr @nodes, align 8, !dbg !75
  %8 = load i64, ptr %3, align 8, !dbg !76
  %9 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %7, i64 %8, !dbg !75
  store ptr %9, ptr %4, align 8, !dbg !74
  %10 = load ptr, ptr %4, align 8, !dbg !77
  call void @ck_spinlock_mcs_lock(ptr noundef @lock, ptr noundef %10), !dbg !78
  %11 = load i32, ptr @x, align 4, !dbg !79
  %12 = add nsw i32 %11, 1, !dbg !79
  store i32 %12, ptr @x, align 4, !dbg !79
  %13 = load i32, ptr @y, align 4, !dbg !80
  %14 = add nsw i32 %13, 1, !dbg !80
  store i32 %14, ptr @y, align 4, !dbg !80
  %15 = load ptr, ptr %4, align 8, !dbg !81
  call void @ck_spinlock_mcs_unlock(ptr noundef @lock, ptr noundef %15), !dbg !82
  ret ptr null, !dbg !83
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_mcs_lock(ptr noundef %0, ptr noundef %1) #0 !dbg !84 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !88, metadata !DIExpression()), !dbg !89
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !90, metadata !DIExpression()), !dbg !91
  call void @llvm.dbg.declare(metadata ptr %5, metadata !92, metadata !DIExpression()), !dbg !93
  %6 = load ptr, ptr %4, align 8, !dbg !94
  %7 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %6, i32 0, i32 0, !dbg !95
  store i32 1, ptr %7, align 8, !dbg !96
  %8 = load ptr, ptr %4, align 8, !dbg !97
  %9 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %8, i32 0, i32 1, !dbg !98
  store ptr null, ptr %9, align 8, !dbg !99
  call void @ck_pr_fence_store_atomic(), !dbg !100
  %10 = load ptr, ptr %3, align 8, !dbg !101
  %11 = load ptr, ptr %4, align 8, !dbg !102
  %12 = call ptr @ck_pr_fas_ptr(ptr noundef %10, ptr noundef %11), !dbg !103
  store ptr %12, ptr %5, align 8, !dbg !104
  %13 = load ptr, ptr %5, align 8, !dbg !105
  %14 = icmp ne ptr %13, null, !dbg !107
  br i1 %14, label %15, label %26, !dbg !108

15:                                               ; preds = %2
  %16 = load ptr, ptr %5, align 8, !dbg !109
  %17 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %16, i32 0, i32 1, !dbg !109
  %18 = load ptr, ptr %4, align 8, !dbg !109
  call void @ck_pr_md_store_ptr(ptr noundef %17, ptr noundef %18), !dbg !109
  br label %19, !dbg !111

19:                                               ; preds = %24, %15
  %20 = load ptr, ptr %4, align 8, !dbg !112
  %21 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %20, i32 0, i32 0, !dbg !112
  %22 = call i32 @ck_pr_md_load_uint(ptr noundef %21), !dbg !112
  %23 = icmp eq i32 %22, 1, !dbg !113
  br i1 %23, label %24, label %25, !dbg !111

24:                                               ; preds = %19
  call void @ck_pr_stall(), !dbg !114
  br label %19, !dbg !111, !llvm.loop !115

25:                                               ; preds = %19
  br label %26, !dbg !118

26:                                               ; preds = %25, %2
  call void @ck_pr_fence_lock(), !dbg !119
  ret void, !dbg !120
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_mcs_unlock(ptr noundef %0, ptr noundef %1) #0 !dbg !121 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !122, metadata !DIExpression()), !dbg !123
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !124, metadata !DIExpression()), !dbg !125
  call void @llvm.dbg.declare(metadata ptr %5, metadata !126, metadata !DIExpression()), !dbg !127
  call void @ck_pr_fence_unlock(), !dbg !128
  %6 = load ptr, ptr %4, align 8, !dbg !129
  %7 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %6, i32 0, i32 1, !dbg !129
  %8 = call ptr @ck_pr_md_load_ptr(ptr noundef %7), !dbg !129
  store ptr %8, ptr %5, align 8, !dbg !130
  %9 = load ptr, ptr %5, align 8, !dbg !131
  %10 = icmp eq ptr %9, null, !dbg !133
  br i1 %10, label %11, label %33, !dbg !134

11:                                               ; preds = %2
  %12 = load ptr, ptr %3, align 8, !dbg !135
  %13 = call ptr @ck_pr_md_load_ptr(ptr noundef %12), !dbg !135
  %14 = load ptr, ptr %4, align 8, !dbg !138
  %15 = icmp eq ptr %13, %14, !dbg !139
  br i1 %15, label %16, label %23, !dbg !140

16:                                               ; preds = %11
  %17 = load ptr, ptr %3, align 8, !dbg !141
  %18 = load ptr, ptr %4, align 8, !dbg !142
  %19 = call zeroext i1 @ck_pr_cas_ptr(ptr noundef %17, ptr noundef %18, ptr noundef null), !dbg !143
  %20 = zext i1 %19 to i32, !dbg !143
  %21 = icmp eq i32 %20, 1, !dbg !144
  br i1 %21, label %22, label %23, !dbg !145

22:                                               ; preds = %16
  br label %36, !dbg !146

23:                                               ; preds = %16, %11
  br label %24, !dbg !148

24:                                               ; preds = %31, %23
  %25 = load ptr, ptr %4, align 8, !dbg !149
  %26 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %25, i32 0, i32 1, !dbg !149
  %27 = call ptr @ck_pr_md_load_ptr(ptr noundef %26), !dbg !149
  store ptr %27, ptr %5, align 8, !dbg !153
  %28 = load ptr, ptr %5, align 8, !dbg !154
  %29 = icmp ne ptr %28, null, !dbg !156
  br i1 %29, label %30, label %31, !dbg !157

30:                                               ; preds = %24
  br label %32, !dbg !158

31:                                               ; preds = %24
  call void @ck_pr_stall(), !dbg !159
  br label %24, !dbg !160, !llvm.loop !161

32:                                               ; preds = %30
  br label %33, !dbg !164

33:                                               ; preds = %32, %2
  %34 = load ptr, ptr %5, align 8, !dbg !165
  %35 = getelementptr inbounds %struct.ck_spinlock_mcs, ptr %34, i32 0, i32 0, !dbg !165
  call void @ck_pr_md_store_uint(ptr noundef %35, i32 noundef 0), !dbg !165
  br label %36, !dbg !166

36:                                               ; preds = %33, %22
  ret void, !dbg !167
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !168 {
  %1 = alloca i32, align 4
  %2 = alloca [2 x i64], align 16
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !171, metadata !DIExpression()), !dbg !177
  call void @llvm.dbg.declare(metadata ptr %3, metadata !178, metadata !DIExpression()), !dbg !179
  %4 = call noalias ptr @malloc(i64 noundef 16) #7, !dbg !180
  store ptr %4, ptr @nodes, align 8, !dbg !181
  %5 = load ptr, ptr @nodes, align 8, !dbg !182
  %6 = icmp eq ptr %5, null, !dbg !184
  br i1 %6, label %7, label %8, !dbg !185

7:                                                ; preds = %0
  call void @exit(i32 noundef 1) #8, !dbg !186
  unreachable, !dbg !186

8:                                                ; preds = %0
  store ptr null, ptr @lock, align 8, !dbg !188
  store i32 0, ptr %3, align 4, !dbg !189
  br label %9, !dbg !191

9:                                                ; preds = %24, %8
  %10 = load i32, ptr %3, align 4, !dbg !192
  %11 = icmp slt i32 %10, 2, !dbg !194
  br i1 %11, label %12, label %27, !dbg !195

12:                                               ; preds = %9
  %13 = load i32, ptr %3, align 4, !dbg !196
  %14 = sext i32 %13 to i64, !dbg !199
  %15 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 %14, !dbg !199
  %16 = load i32, ptr %3, align 4, !dbg !200
  %17 = sext i32 %16 to i64, !dbg !201
  %18 = inttoptr i64 %17 to ptr, !dbg !202
  %19 = call i32 @pthread_create(ptr noundef %15, ptr noundef null, ptr noundef @run, ptr noundef %18) #9, !dbg !203
  %20 = icmp ne i32 %19, 0, !dbg !204
  br i1 %20, label %21, label %23, !dbg !205

21:                                               ; preds = %12
  %22 = load ptr, ptr @nodes, align 8, !dbg !206
  call void @free(ptr noundef %22) #9, !dbg !208
  call void @exit(i32 noundef 1) #8, !dbg !209
  unreachable, !dbg !209

23:                                               ; preds = %12
  br label %24, !dbg !210

24:                                               ; preds = %23
  %25 = load i32, ptr %3, align 4, !dbg !211
  %26 = add nsw i32 %25, 1, !dbg !211
  store i32 %26, ptr %3, align 4, !dbg !211
  br label %9, !dbg !212, !llvm.loop !213

27:                                               ; preds = %9
  store i32 0, ptr %3, align 4, !dbg !215
  br label %28, !dbg !217

28:                                               ; preds = %41, %27
  %29 = load i32, ptr %3, align 4, !dbg !218
  %30 = icmp slt i32 %29, 2, !dbg !220
  br i1 %30, label %31, label %44, !dbg !221

31:                                               ; preds = %28
  %32 = load i32, ptr %3, align 4, !dbg !222
  %33 = sext i32 %32 to i64, !dbg !225
  %34 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 %33, !dbg !225
  %35 = load i64, ptr %34, align 8, !dbg !225
  %36 = call i32 @pthread_join(i64 noundef %35, ptr noundef null), !dbg !226
  %37 = icmp ne i32 %36, 0, !dbg !227
  br i1 %37, label %38, label %40, !dbg !228

38:                                               ; preds = %31
  %39 = load ptr, ptr @nodes, align 8, !dbg !229
  call void @free(ptr noundef %39) #9, !dbg !231
  call void @exit(i32 noundef 1) #8, !dbg !232
  unreachable, !dbg !232

40:                                               ; preds = %31
  br label %41, !dbg !233

41:                                               ; preds = %40
  %42 = load i32, ptr %3, align 4, !dbg !234
  %43 = add nsw i32 %42, 1, !dbg !234
  store i32 %43, ptr %3, align 4, !dbg !234
  br label %28, !dbg !235, !llvm.loop !236

44:                                               ; preds = %28
  %45 = load i32, ptr @x, align 4, !dbg !238
  %46 = icmp eq i32 %45, 2, !dbg !238
  br i1 %46, label %47, label %51, !dbg !238

47:                                               ; preds = %44
  %48 = load i32, ptr @y, align 4, !dbg !238
  %49 = icmp eq i32 %48, 2, !dbg !238
  br i1 %49, label %50, label %51, !dbg !241

50:                                               ; preds = %47
  br label %52, !dbg !241

51:                                               ; preds = %47, %44
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 63, ptr noundef @__PRETTY_FUNCTION__.main) #8, !dbg !238
  unreachable, !dbg !238

52:                                               ; preds = %50
  %53 = load ptr, ptr @nodes, align 8, !dbg !242
  call void @free(ptr noundef %53) #9, !dbg !243
  ret i32 0, !dbg !244
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #3

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #4

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #5

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_store_atomic() #0 !dbg !245 {
  call void @ck_pr_barrier(), !dbg !249
  ret void, !dbg !249
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_fas_ptr(ptr noundef %0, ptr noundef %1) #0 !dbg !250 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !254, metadata !DIExpression()), !dbg !255
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !256, metadata !DIExpression()), !dbg !255
  %5 = load ptr, ptr %3, align 8, !dbg !255
  %6 = load ptr, ptr %4, align 8, !dbg !255
  %7 = call ptr asm sideeffect "xchgq $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %5, ptr elementtype(i64) %5, ptr %6) #9, !dbg !255, !srcloc !257
  store ptr %7, ptr %4, align 8, !dbg !255
  %8 = load ptr, ptr %4, align 8, !dbg !255
  ret ptr %8, !dbg !255
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_ptr(ptr noundef %0, ptr noundef %1) #0 !dbg !258 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !263, metadata !DIExpression()), !dbg !264
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !265, metadata !DIExpression()), !dbg !264
  %5 = load ptr, ptr %3, align 8, !dbg !264
  %6 = load ptr, ptr %4, align 8, !dbg !264
  call void asm sideeffect "movq $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %5, ptr %6) #9, !dbg !264, !srcloc !266
  ret void, !dbg !264
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !267 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !270, metadata !DIExpression()), !dbg !271
  call void @llvm.dbg.declare(metadata ptr %3, metadata !272, metadata !DIExpression()), !dbg !271
  %4 = load ptr, ptr %2, align 8, !dbg !271
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #9, !dbg !271, !srcloc !273
  store i32 %5, ptr %3, align 4, !dbg !271
  %6 = load i32, ptr %3, align 4, !dbg !271
  ret i32 %6, !dbg !271
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !274 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #9, !dbg !275, !srcloc !276
  ret void, !dbg !277
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !278 {
  call void @ck_pr_barrier(), !dbg !279
  ret void, !dbg !279
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !280 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #9, !dbg !282, !srcloc !283
  ret void, !dbg !284
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !285 {
  call void @ck_pr_barrier(), !dbg !286
  ret void, !dbg !286
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_md_load_ptr(ptr noundef %0) #0 !dbg !287 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !290, metadata !DIExpression()), !dbg !291
  call void @llvm.dbg.declare(metadata ptr %3, metadata !292, metadata !DIExpression()), !dbg !291
  %4 = load ptr, ptr %2, align 8, !dbg !291
  %5 = call ptr asm sideeffect "movq $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %4) #9, !dbg !291, !srcloc !293
  store ptr %5, ptr %3, align 8, !dbg !291
  %6 = load ptr, ptr %3, align 8, !dbg !291
  ret ptr %6, !dbg !291
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_ptr(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !294 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !298, metadata !DIExpression()), !dbg !299
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !300, metadata !DIExpression()), !dbg !299
  store ptr %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !301, metadata !DIExpression()), !dbg !299
  call void @llvm.dbg.declare(metadata ptr %7, metadata !302, metadata !DIExpression()), !dbg !299
  %8 = load ptr, ptr %4, align 8, !dbg !299
  %9 = load ptr, ptr %5, align 8, !dbg !299
  %10 = load ptr, ptr %6, align 8, !dbg !299
  %11 = call { i8, ptr } asm sideeffect "lock cmpxchgq $3, $0", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %8, ptr %10, ptr elementtype(i64) %8, ptr %9) #9, !dbg !299, !srcloc !303
  %12 = extractvalue { i8, ptr } %11, 0, !dbg !299
  %13 = extractvalue { i8, ptr } %11, 1, !dbg !299
  %14 = icmp ult i8 %12, 2, !dbg !299
  call void @llvm.assume(i1 %14), !dbg !299
  store i8 %12, ptr %7, align 1, !dbg !299
  store ptr %13, ptr %5, align 8, !dbg !299
  %15 = load i8, ptr %7, align 1, !dbg !299
  %16 = trunc i8 %15 to i1, !dbg !299
  ret i1 %16, !dbg !299
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !304 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !307, metadata !DIExpression()), !dbg !308
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !309, metadata !DIExpression()), !dbg !308
  %5 = load ptr, ptr %3, align 8, !dbg !308
  %6 = load i32, ptr %4, align 4, !dbg !308
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #9, !dbg !308, !srcloc !310
  ret void, !dbg !308
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #6

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #7 = { nounwind allocsize(0) }
attributes #8 = { noreturn nounwind }
attributes #9 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!55, !56, !57, !58, !59, !60, !61}
!llvm.ident = !{!62}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "lock", scope: !2, file: !3, line: 10, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !30, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/mcslock.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "4d52312d3fd6710159db4cbd2182b2bc")
!4 = !{!5, !6, !9, !17, !20, !25, !11, !27, !29}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !7, line: 76, baseType: !8)
!7 = !DIFile(filename: "/usr/include/stdint.h", directory: "", checksumkind: CSK_MD5, checksum: "bfb03fa9c46a839e35c32b929fbdbb8e")
!8 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_mcs_t", file: !10, line: 42, baseType: !11)
!10 = !DIFile(filename: "include/spinlock/mcs.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "027f57d568cbbfbb353298638ea153e7")
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_mcs", file: !10, line: 38, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "locked", scope: !12, file: !10, line: 39, baseType: !15, size: 32)
!15 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !12, file: !10, line: 40, baseType: !11, size: 64, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !18, line: 18, baseType: !19)
!18 = !DIFile(filename: "/usr/lib/llvm-18/lib/clang/18/include/__stddef_size_t.h", directory: "", checksumkind: CSK_MD5, checksum: "2c44e821a2b1951cde2eb0fb2e656867")
!19 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !22, line: 27, baseType: !23)
!22 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !24, line: 45, baseType: !19)
!24 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !15)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !21)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!30 = !{!0, !31, !34, !36, !42, !47, !53}
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 13, type: !33, isLocal: false, isDefinition: true)
!33 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 13, type: !33, isLocal: false, isDefinition: true)
!36 = !DIGlobalVariableExpression(var: !37, expr: !DIExpression())
!37 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !38, isLocal: true, isDefinition: true)
!38 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 248, elements: !40)
!39 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!40 = !{!41}
!41 = !DISubrange(count: 31)
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !44, isLocal: true, isDefinition: true)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !39, size: 128, elements: !45)
!45 = !{!46}
!46 = !DISubrange(count: 16)
!47 = !DIGlobalVariableExpression(var: !48, expr: !DIExpression())
!48 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !49, isLocal: true, isDefinition: true)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 88, elements: !51)
!50 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !39)
!51 = !{!52}
!52 = !DISubrange(count: 11)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(name: "nodes", scope: !2, file: !3, line: 11, type: !9, isLocal: false, isDefinition: true)
!55 = !{i32 7, !"Dwarf Version", i32 5}
!56 = !{i32 2, !"Debug Info Version", i32 3}
!57 = !{i32 1, !"wchar_size", i32 4}
!58 = !{i32 8, !"PIC Level", i32 2}
!59 = !{i32 7, !"PIE Level", i32 2}
!60 = !{i32 7, !"uwtable", i32 2}
!61 = !{i32 7, !"frame-pointer", i32 2}
!62 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!63 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 15, type: !64, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !66)
!64 = !DISubroutineType(types: !65)
!65 = !{!5, !5}
!66 = !{}
!67 = !DILocalVariable(name: "arg", arg: 1, scope: !63, file: !3, line: 15, type: !5)
!68 = !DILocation(line: 15, column: 17, scope: !63)
!69 = !DILocalVariable(name: "tid", scope: !63, file: !3, line: 18, type: !6)
!70 = !DILocation(line: 18, column: 14, scope: !63)
!71 = !DILocation(line: 18, column: 31, scope: !63)
!72 = !DILocation(line: 18, column: 21, scope: !63)
!73 = !DILocalVariable(name: "thread_node", scope: !63, file: !3, line: 20, type: !9)
!74 = !DILocation(line: 20, column: 23, scope: !63)
!75 = !DILocation(line: 20, column: 38, scope: !63)
!76 = !DILocation(line: 20, column: 44, scope: !63)
!77 = !DILocation(line: 22, column: 33, scope: !63)
!78 = !DILocation(line: 22, column: 5, scope: !63)
!79 = !DILocation(line: 24, column: 6, scope: !63)
!80 = !DILocation(line: 25, column: 6, scope: !63)
!81 = !DILocation(line: 27, column: 35, scope: !63)
!82 = !DILocation(line: 27, column: 5, scope: !63)
!83 = !DILocation(line: 29, column: 5, scope: !63)
!84 = distinct !DISubprogram(name: "ck_spinlock_mcs_lock", scope: !10, file: !10, line: 82, type: !85, scopeLine: 84, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!85 = !DISubroutineType(types: !86)
!86 = !{null, !87, !11}
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!88 = !DILocalVariable(name: "queue", arg: 1, scope: !84, file: !10, line: 82, type: !87)
!89 = !DILocation(line: 82, column: 47, scope: !84)
!90 = !DILocalVariable(name: "node", arg: 2, scope: !84, file: !10, line: 83, type: !11)
!91 = !DILocation(line: 83, column: 29, scope: !84)
!92 = !DILocalVariable(name: "previous", scope: !84, file: !10, line: 85, type: !11)
!93 = !DILocation(line: 85, column: 26, scope: !84)
!94 = !DILocation(line: 91, column: 2, scope: !84)
!95 = !DILocation(line: 91, column: 8, scope: !84)
!96 = !DILocation(line: 91, column: 15, scope: !84)
!97 = !DILocation(line: 92, column: 2, scope: !84)
!98 = !DILocation(line: 92, column: 8, scope: !84)
!99 = !DILocation(line: 92, column: 13, scope: !84)
!100 = !DILocation(line: 93, column: 2, scope: !84)
!101 = !DILocation(line: 100, column: 27, scope: !84)
!102 = !DILocation(line: 100, column: 34, scope: !84)
!103 = !DILocation(line: 100, column: 13, scope: !84)
!104 = !DILocation(line: 100, column: 11, scope: !84)
!105 = !DILocation(line: 101, column: 6, scope: !106)
!106 = distinct !DILexicalBlock(scope: !84, file: !10, line: 101, column: 6)
!107 = !DILocation(line: 101, column: 15, scope: !106)
!108 = !DILocation(line: 101, column: 6, scope: !84)
!109 = !DILocation(line: 106, column: 3, scope: !110)
!110 = distinct !DILexicalBlock(scope: !106, file: !10, line: 101, column: 24)
!111 = !DILocation(line: 107, column: 3, scope: !110)
!112 = !DILocation(line: 107, column: 10, scope: !110)
!113 = !DILocation(line: 107, column: 41, scope: !110)
!114 = !DILocation(line: 108, column: 4, scope: !110)
!115 = distinct !{!115, !111, !116, !117}
!116 = !DILocation(line: 108, column: 16, scope: !110)
!117 = !{!"llvm.loop.mustprogress"}
!118 = !DILocation(line: 109, column: 2, scope: !110)
!119 = !DILocation(line: 111, column: 2, scope: !84)
!120 = !DILocation(line: 112, column: 2, scope: !84)
!121 = distinct !DISubprogram(name: "ck_spinlock_mcs_unlock", scope: !10, file: !10, line: 116, type: !85, scopeLine: 118, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!122 = !DILocalVariable(name: "queue", arg: 1, scope: !121, file: !10, line: 116, type: !87)
!123 = !DILocation(line: 116, column: 49, scope: !121)
!124 = !DILocalVariable(name: "node", arg: 2, scope: !121, file: !10, line: 117, type: !11)
!125 = !DILocation(line: 117, column: 29, scope: !121)
!126 = !DILocalVariable(name: "next", scope: !121, file: !10, line: 119, type: !11)
!127 = !DILocation(line: 119, column: 26, scope: !121)
!128 = !DILocation(line: 121, column: 2, scope: !121)
!129 = !DILocation(line: 123, column: 9, scope: !121)
!130 = !DILocation(line: 123, column: 7, scope: !121)
!131 = !DILocation(line: 124, column: 6, scope: !132)
!132 = distinct !DILexicalBlock(scope: !121, file: !10, line: 124, column: 6)
!133 = !DILocation(line: 124, column: 11, scope: !132)
!134 = !DILocation(line: 124, column: 6, scope: !121)
!135 = !DILocation(line: 130, column: 7, scope: !136)
!136 = distinct !DILexicalBlock(scope: !137, file: !10, line: 130, column: 7)
!137 = distinct !DILexicalBlock(scope: !132, file: !10, line: 124, column: 20)
!138 = !DILocation(line: 130, column: 32, scope: !136)
!139 = !DILocation(line: 130, column: 29, scope: !136)
!140 = !DILocation(line: 130, column: 37, scope: !136)
!141 = !DILocation(line: 131, column: 21, scope: !136)
!142 = !DILocation(line: 131, column: 28, scope: !136)
!143 = !DILocation(line: 131, column: 7, scope: !136)
!144 = !DILocation(line: 131, column: 40, scope: !136)
!145 = !DILocation(line: 130, column: 7, scope: !137)
!146 = !DILocation(line: 132, column: 4, scope: !147)
!147 = distinct !DILexicalBlock(scope: !136, file: !10, line: 131, column: 49)
!148 = !DILocation(line: 141, column: 3, scope: !137)
!149 = !DILocation(line: 142, column: 11, scope: !150)
!150 = distinct !DILexicalBlock(scope: !151, file: !10, line: 141, column: 12)
!151 = distinct !DILexicalBlock(scope: !152, file: !10, line: 141, column: 3)
!152 = distinct !DILexicalBlock(scope: !137, file: !10, line: 141, column: 3)
!153 = !DILocation(line: 142, column: 9, scope: !150)
!154 = !DILocation(line: 143, column: 8, scope: !155)
!155 = distinct !DILexicalBlock(scope: !150, file: !10, line: 143, column: 8)
!156 = !DILocation(line: 143, column: 13, scope: !155)
!157 = !DILocation(line: 143, column: 8, scope: !150)
!158 = !DILocation(line: 144, column: 5, scope: !155)
!159 = !DILocation(line: 146, column: 4, scope: !150)
!160 = !DILocation(line: 141, column: 3, scope: !151)
!161 = distinct !{!161, !162, !163}
!162 = !DILocation(line: 141, column: 3, scope: !152)
!163 = !DILocation(line: 147, column: 3, scope: !152)
!164 = !DILocation(line: 148, column: 2, scope: !137)
!165 = !DILocation(line: 151, column: 2, scope: !121)
!166 = !DILocation(line: 152, column: 2, scope: !121)
!167 = !DILocation(line: 153, column: 1, scope: !121)
!168 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 32, type: !169, scopeLine: 33, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !66)
!169 = !DISubroutineType(types: !170)
!170 = !{!33}
!171 = !DILocalVariable(name: "threads", scope: !168, file: !3, line: 34, type: !172)
!172 = !DICompositeType(tag: DW_TAG_array_type, baseType: !173, size: 128, elements: !175)
!173 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !174, line: 27, baseType: !19)
!174 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!175 = !{!176}
!176 = !DISubrange(count: 2)
!177 = !DILocation(line: 34, column: 15, scope: !168)
!178 = !DILocalVariable(name: "i", scope: !168, file: !3, line: 35, type: !33)
!179 = !DILocation(line: 35, column: 9, scope: !168)
!180 = !DILocation(line: 37, column: 32, scope: !168)
!181 = !DILocation(line: 37, column: 11, scope: !168)
!182 = !DILocation(line: 38, column: 9, scope: !183)
!183 = distinct !DILexicalBlock(scope: !168, file: !3, line: 38, column: 9)
!184 = !DILocation(line: 38, column: 15, scope: !183)
!185 = !DILocation(line: 38, column: 9, scope: !168)
!186 = !DILocation(line: 40, column: 9, scope: !187)
!187 = distinct !DILexicalBlock(scope: !183, file: !3, line: 39, column: 5)
!188 = !DILocation(line: 43, column: 10, scope: !168)
!189 = !DILocation(line: 45, column: 12, scope: !190)
!190 = distinct !DILexicalBlock(scope: !168, file: !3, line: 45, column: 5)
!191 = !DILocation(line: 45, column: 10, scope: !190)
!192 = !DILocation(line: 45, column: 17, scope: !193)
!193 = distinct !DILexicalBlock(scope: !190, file: !3, line: 45, column: 5)
!194 = !DILocation(line: 45, column: 19, scope: !193)
!195 = !DILocation(line: 45, column: 5, scope: !190)
!196 = !DILocation(line: 47, column: 37, scope: !197)
!197 = distinct !DILexicalBlock(scope: !198, file: !3, line: 47, column: 13)
!198 = distinct !DILexicalBlock(scope: !193, file: !3, line: 46, column: 5)
!199 = !DILocation(line: 47, column: 29, scope: !197)
!200 = !DILocation(line: 47, column: 68, scope: !197)
!201 = !DILocation(line: 47, column: 60, scope: !197)
!202 = !DILocation(line: 47, column: 52, scope: !197)
!203 = !DILocation(line: 47, column: 13, scope: !197)
!204 = !DILocation(line: 47, column: 71, scope: !197)
!205 = !DILocation(line: 47, column: 13, scope: !198)
!206 = !DILocation(line: 49, column: 18, scope: !207)
!207 = distinct !DILexicalBlock(scope: !197, file: !3, line: 48, column: 9)
!208 = !DILocation(line: 49, column: 13, scope: !207)
!209 = !DILocation(line: 50, column: 13, scope: !207)
!210 = !DILocation(line: 52, column: 5, scope: !198)
!211 = !DILocation(line: 45, column: 32, scope: !193)
!212 = !DILocation(line: 45, column: 5, scope: !193)
!213 = distinct !{!213, !195, !214, !117}
!214 = !DILocation(line: 52, column: 5, scope: !190)
!215 = !DILocation(line: 54, column: 12, scope: !216)
!216 = distinct !DILexicalBlock(scope: !168, file: !3, line: 54, column: 5)
!217 = !DILocation(line: 54, column: 10, scope: !216)
!218 = !DILocation(line: 54, column: 17, scope: !219)
!219 = distinct !DILexicalBlock(scope: !216, file: !3, line: 54, column: 5)
!220 = !DILocation(line: 54, column: 19, scope: !219)
!221 = !DILocation(line: 54, column: 5, scope: !216)
!222 = !DILocation(line: 56, column: 34, scope: !223)
!223 = distinct !DILexicalBlock(scope: !224, file: !3, line: 56, column: 13)
!224 = distinct !DILexicalBlock(scope: !219, file: !3, line: 55, column: 5)
!225 = !DILocation(line: 56, column: 26, scope: !223)
!226 = !DILocation(line: 56, column: 13, scope: !223)
!227 = !DILocation(line: 56, column: 44, scope: !223)
!228 = !DILocation(line: 56, column: 13, scope: !224)
!229 = !DILocation(line: 58, column: 18, scope: !230)
!230 = distinct !DILexicalBlock(scope: !223, file: !3, line: 57, column: 9)
!231 = !DILocation(line: 58, column: 13, scope: !230)
!232 = !DILocation(line: 59, column: 13, scope: !230)
!233 = !DILocation(line: 61, column: 5, scope: !224)
!234 = !DILocation(line: 54, column: 32, scope: !219)
!235 = !DILocation(line: 54, column: 5, scope: !219)
!236 = distinct !{!236, !221, !237, !117}
!237 = !DILocation(line: 61, column: 5, scope: !216)
!238 = !DILocation(line: 63, column: 5, scope: !239)
!239 = distinct !DILexicalBlock(scope: !240, file: !3, line: 63, column: 5)
!240 = distinct !DILexicalBlock(scope: !168, file: !3, line: 63, column: 5)
!241 = !DILocation(line: 63, column: 5, scope: !240)
!242 = !DILocation(line: 65, column: 10, scope: !168)
!243 = !DILocation(line: 65, column: 5, scope: !168)
!244 = !DILocation(line: 67, column: 5, scope: !168)
!245 = distinct !DISubprogram(name: "ck_pr_fence_store_atomic", scope: !246, file: !246, line: 152, type: !247, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!246 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!247 = !DISubroutineType(types: !248)
!248 = !{null}
!249 = !DILocation(line: 152, column: 1, scope: !245)
!250 = distinct !DISubprogram(name: "ck_pr_fas_ptr", scope: !251, file: !251, line: 152, type: !252, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!251 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!252 = !DISubroutineType(types: !253)
!253 = !{!5, !5, !5}
!254 = !DILocalVariable(name: "target", arg: 1, scope: !250, file: !251, line: 152, type: !5)
!255 = !DILocation(line: 152, column: 1, scope: !250)
!256 = !DILocalVariable(name: "v", arg: 2, scope: !250, file: !251, line: 152, type: !5)
!257 = !{i64 2147748148}
!258 = distinct !DISubprogram(name: "ck_pr_md_store_ptr", scope: !251, file: !251, line: 267, type: !259, scopeLine: 267, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!259 = !DISubroutineType(types: !260)
!260 = !{null, !5, !261}
!261 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !262, size: 64)
!262 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!263 = !DILocalVariable(name: "target", arg: 1, scope: !258, file: !251, line: 267, type: !5)
!264 = !DILocation(line: 267, column: 1, scope: !258)
!265 = !DILocalVariable(name: "v", arg: 2, scope: !258, file: !251, line: 267, type: !261)
!266 = !{i64 2147756790}
!267 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !251, file: !251, line: 190, type: !268, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!268 = !DISubroutineType(types: !269)
!269 = !{!15, !25}
!270 = !DILocalVariable(name: "target", arg: 1, scope: !267, file: !251, line: 190, type: !25)
!271 = !DILocation(line: 190, column: 1, scope: !267)
!272 = !DILocalVariable(name: "r", scope: !267, file: !251, line: 190, type: !15)
!273 = !{i64 2147752257}
!274 = distinct !DISubprogram(name: "ck_pr_stall", scope: !251, file: !251, line: 65, type: !247, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!275 = !DILocation(line: 67, column: 2, scope: !274)
!276 = !{i64 240400}
!277 = !DILocation(line: 68, column: 2, scope: !274)
!278 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !246, file: !246, line: 162, type: !247, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!279 = !DILocation(line: 162, column: 1, scope: !278)
!280 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !281, file: !281, line: 37, type: !247, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!281 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!282 = !DILocation(line: 40, column: 2, scope: !280)
!283 = !{i64 359745}
!284 = !DILocation(line: 41, column: 2, scope: !280)
!285 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !246, file: !246, line: 163, type: !247, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!286 = !DILocation(line: 163, column: 1, scope: !285)
!287 = distinct !DISubprogram(name: "ck_pr_md_load_ptr", scope: !251, file: !251, line: 185, type: !288, scopeLine: 185, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!288 = !DISubroutineType(types: !289)
!289 = !{!5, !261}
!290 = !DILocalVariable(name: "target", arg: 1, scope: !287, file: !251, line: 185, type: !261)
!291 = !DILocation(line: 185, column: 1, scope: !287)
!292 = !DILocalVariable(name: "r", scope: !287, file: !251, line: 185, type: !5)
!293 = !{i64 2147751446}
!294 = distinct !DISubprogram(name: "ck_pr_cas_ptr", scope: !251, file: !251, line: 473, type: !295, scopeLine: 473, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!295 = !DISubroutineType(types: !296)
!296 = !{!297, !5, !5, !5}
!297 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!298 = !DILocalVariable(name: "target", arg: 1, scope: !294, file: !251, line: 473, type: !5)
!299 = !DILocation(line: 473, column: 1, scope: !294)
!300 = !DILocalVariable(name: "compare", arg: 2, scope: !294, file: !251, line: 473, type: !5)
!301 = !DILocalVariable(name: "set", arg: 3, scope: !294, file: !251, line: 473, type: !5)
!302 = !DILocalVariable(name: "z", scope: !294, file: !251, line: 473, type: !297)
!303 = !{i64 2147814235}
!304 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !251, file: !251, line: 276, type: !305, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!305 = !DISubroutineType(types: !306)
!306 = !{null, !29, !15}
!307 = !DILocalVariable(name: "target", arg: 1, scope: !304, file: !251, line: 276, type: !29)
!308 = !DILocation(line: 276, column: 1, scope: !304)
!309 = !DILocalVariable(name: "v", arg: 2, scope: !304, file: !251, line: 276, type: !15)
!310 = !{i64 2147758251}
