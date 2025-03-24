; ModuleID = 'tests/anderson.c'
source_filename = "tests/anderson.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_spinlock_anderson = type { ptr, i32, i32, i32, [44 x i8], i32 }
%struct.ck_spinlock_anderson_thread = type { i32, i32 }

@x = dso_local global i32 0, align 4, !dbg !0
@y = dso_local global i32 0, align 4, !dbg !18
@lock = dso_local global %struct.ck_spinlock_anderson zeroinitializer, align 8, !dbg !38
@slots = dso_local global ptr null, align 8, !dbg !53
@.str = private unnamed_addr constant [31 x i8] c"x == NTHREADS && y == NTHREADS\00", align 1, !dbg !21
@.str.1 = private unnamed_addr constant [17 x i8] c"tests/anderson.c\00", align 1, !dbg !27
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1, !dbg !32

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @run(ptr noundef %0) #0 !dbg !63 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !67, metadata !DIExpression()), !dbg !68
  call void @llvm.dbg.declare(metadata ptr %3, metadata !69, metadata !DIExpression()), !dbg !70
  call void @ck_spinlock_anderson_lock(ptr noundef @lock, ptr noundef %3), !dbg !71
  %4 = load i32, ptr @x, align 4, !dbg !72
  %5 = add nsw i32 %4, 1, !dbg !72
  store i32 %5, ptr @x, align 4, !dbg !72
  %6 = load i32, ptr @y, align 4, !dbg !73
  %7 = add nsw i32 %6, 1, !dbg !73
  store i32 %7, ptr @y, align 4, !dbg !73
  %8 = load ptr, ptr %3, align 8, !dbg !74
  call void @ck_spinlock_anderson_unlock(ptr noundef @lock, ptr noundef %8), !dbg !75
  ret ptr null, !dbg !76
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_anderson_lock(ptr noundef %0, ptr noundef %1) #0 !dbg !77 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !82, metadata !DIExpression()), !dbg !83
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !84, metadata !DIExpression()), !dbg !85
  call void @llvm.dbg.declare(metadata ptr %5, metadata !86, metadata !DIExpression()), !dbg !87
  call void @llvm.dbg.declare(metadata ptr %6, metadata !88, metadata !DIExpression()), !dbg !89
  call void @llvm.dbg.declare(metadata ptr %7, metadata !90, metadata !DIExpression()), !dbg !91
  %8 = load ptr, ptr %3, align 8, !dbg !92
  %9 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %8, i32 0, i32 1, !dbg !93
  %10 = load i32, ptr %9, align 8, !dbg !93
  store i32 %10, ptr %7, align 4, !dbg !91
  %11 = load ptr, ptr %3, align 8, !dbg !94
  %12 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %11, i32 0, i32 2, !dbg !96
  %13 = load i32, ptr %12, align 4, !dbg !96
  %14 = icmp ne i32 %13, 0, !dbg !97
  br i1 %14, label %15, label %42, !dbg !98

15:                                               ; preds = %2
  %16 = load ptr, ptr %3, align 8, !dbg !99
  %17 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %16, i32 0, i32 5, !dbg !99
  %18 = call i32 @ck_pr_md_load_uint(ptr noundef %17), !dbg !99
  store i32 %18, ptr %5, align 4, !dbg !101
  br label %19, !dbg !102

19:                                               ; preds = %30, %15
  %20 = load i32, ptr %5, align 4, !dbg !103
  %21 = icmp eq i32 %20, -1, !dbg !106
  br i1 %21, label %22, label %26, !dbg !107

22:                                               ; preds = %19
  %23 = load ptr, ptr %3, align 8, !dbg !108
  %24 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %23, i32 0, i32 2, !dbg !109
  %25 = load i32, ptr %24, align 4, !dbg !109
  store i32 %25, ptr %6, align 4, !dbg !110
  br label %29, !dbg !111

26:                                               ; preds = %19
  %27 = load i32, ptr %5, align 4, !dbg !112
  %28 = add i32 %27, 1, !dbg !113
  store i32 %28, ptr %6, align 4, !dbg !114
  br label %29

29:                                               ; preds = %26, %22
  br label %30, !dbg !115

30:                                               ; preds = %29
  %31 = load ptr, ptr %3, align 8, !dbg !116
  %32 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %31, i32 0, i32 5, !dbg !117
  %33 = load i32, ptr %5, align 4, !dbg !118
  %34 = load i32, ptr %6, align 4, !dbg !119
  %35 = call zeroext i1 @ck_pr_cas_uint_value(ptr noundef %32, i32 noundef %33, i32 noundef %34, ptr noundef %5), !dbg !120
  %36 = zext i1 %35 to i32, !dbg !120
  %37 = icmp eq i32 %36, 0, !dbg !121
  br i1 %37, label %19, label %38, !dbg !115, !llvm.loop !122

38:                                               ; preds = %30
  %39 = load i32, ptr %7, align 4, !dbg !125
  %40 = load i32, ptr %5, align 4, !dbg !126
  %41 = urem i32 %40, %39, !dbg !126
  store i32 %41, ptr %5, align 4, !dbg !126
  br label %51, !dbg !127

42:                                               ; preds = %2
  %43 = load ptr, ptr %3, align 8, !dbg !128
  %44 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %43, i32 0, i32 5, !dbg !130
  %45 = call i32 @ck_pr_faa_uint(ptr noundef %44, i32 noundef 1), !dbg !131
  store i32 %45, ptr %5, align 4, !dbg !132
  %46 = load ptr, ptr %3, align 8, !dbg !133
  %47 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %46, i32 0, i32 3, !dbg !134
  %48 = load i32, ptr %47, align 8, !dbg !134
  %49 = load i32, ptr %5, align 4, !dbg !135
  %50 = and i32 %49, %48, !dbg !135
  store i32 %50, ptr %5, align 4, !dbg !135
  br label %51

51:                                               ; preds = %42, %38
  call void @ck_pr_fence_load(), !dbg !136
  br label %52, !dbg !137

52:                                               ; preds = %62, %51
  %53 = load ptr, ptr %3, align 8, !dbg !138
  %54 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %53, i32 0, i32 0, !dbg !138
  %55 = load ptr, ptr %54, align 8, !dbg !138
  %56 = load i32, ptr %5, align 4, !dbg !138
  %57 = zext i32 %56 to i64, !dbg !138
  %58 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %55, i64 %57, !dbg !138
  %59 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %58, i32 0, i32 0, !dbg !138
  %60 = call i32 @ck_pr_md_load_uint(ptr noundef %59), !dbg !138
  %61 = icmp eq i32 %60, 1, !dbg !139
  br i1 %61, label %62, label %63, !dbg !137

62:                                               ; preds = %52
  call void @ck_pr_stall(), !dbg !140
  br label %52, !dbg !137, !llvm.loop !141

63:                                               ; preds = %52
  %64 = load ptr, ptr %3, align 8, !dbg !143
  %65 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %64, i32 0, i32 0, !dbg !143
  %66 = load ptr, ptr %65, align 8, !dbg !143
  %67 = load i32, ptr %5, align 4, !dbg !143
  %68 = zext i32 %67 to i64, !dbg !143
  %69 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %66, i64 %68, !dbg !143
  %70 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %69, i32 0, i32 0, !dbg !143
  call void @ck_pr_md_store_uint(ptr noundef %70, i32 noundef 1), !dbg !143
  call void @ck_pr_fence_lock(), !dbg !144
  %71 = load ptr, ptr %3, align 8, !dbg !145
  %72 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %71, i32 0, i32 0, !dbg !146
  %73 = load ptr, ptr %72, align 8, !dbg !146
  %74 = load i32, ptr %5, align 4, !dbg !147
  %75 = zext i32 %74 to i64, !dbg !148
  %76 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %73, i64 %75, !dbg !148
  %77 = load ptr, ptr %4, align 8, !dbg !149
  store ptr %76, ptr %77, align 8, !dbg !150
  ret void, !dbg !151
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_anderson_unlock(ptr noundef %0, ptr noundef %1) #0 !dbg !152 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !155, metadata !DIExpression()), !dbg !156
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !157, metadata !DIExpression()), !dbg !158
  call void @llvm.dbg.declare(metadata ptr %5, metadata !159, metadata !DIExpression()), !dbg !160
  call void @ck_pr_fence_unlock(), !dbg !161
  %6 = load ptr, ptr %3, align 8, !dbg !162
  %7 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %6, i32 0, i32 2, !dbg !164
  %8 = load i32, ptr %7, align 4, !dbg !164
  %9 = icmp eq i32 %8, 0, !dbg !165
  br i1 %9, label %10, label %19, !dbg !166

10:                                               ; preds = %2
  %11 = load ptr, ptr %4, align 8, !dbg !167
  %12 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %11, i32 0, i32 1, !dbg !168
  %13 = load i32, ptr %12, align 4, !dbg !168
  %14 = add i32 %13, 1, !dbg !169
  %15 = load ptr, ptr %3, align 8, !dbg !170
  %16 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %15, i32 0, i32 3, !dbg !171
  %17 = load i32, ptr %16, align 8, !dbg !171
  %18 = and i32 %14, %17, !dbg !172
  store i32 %18, ptr %5, align 4, !dbg !173
  br label %28, !dbg !174

19:                                               ; preds = %2
  %20 = load ptr, ptr %4, align 8, !dbg !175
  %21 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %20, i32 0, i32 1, !dbg !176
  %22 = load i32, ptr %21, align 4, !dbg !176
  %23 = add i32 %22, 1, !dbg !177
  %24 = load ptr, ptr %3, align 8, !dbg !178
  %25 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %24, i32 0, i32 1, !dbg !179
  %26 = load i32, ptr %25, align 8, !dbg !179
  %27 = urem i32 %23, %26, !dbg !180
  store i32 %27, ptr %5, align 4, !dbg !181
  br label %28

28:                                               ; preds = %19, %10
  %29 = load ptr, ptr %3, align 8, !dbg !182
  %30 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %29, i32 0, i32 0, !dbg !182
  %31 = load ptr, ptr %30, align 8, !dbg !182
  %32 = load i32, ptr %5, align 4, !dbg !182
  %33 = zext i32 %32 to i64, !dbg !182
  %34 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %31, i64 %33, !dbg !182
  %35 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %34, i32 0, i32 0, !dbg !182
  call void @ck_pr_md_store_uint(ptr noundef %35, i32 noundef 0), !dbg !182
  ret void, !dbg !183
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !184 {
  %1 = alloca i32, align 4
  %2 = alloca [3 x i64], align 16
  %3 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !187, metadata !DIExpression()), !dbg !194
  call void @llvm.dbg.declare(metadata ptr %3, metadata !195, metadata !DIExpression()), !dbg !196
  %4 = call noalias ptr @malloc(i64 noundef 24) #7, !dbg !197
  store ptr %4, ptr @slots, align 8, !dbg !198
  %5 = load ptr, ptr @slots, align 8, !dbg !199
  %6 = icmp eq ptr %5, null, !dbg !201
  br i1 %6, label %7, label %8, !dbg !202

7:                                                ; preds = %0
  call void @exit(i32 noundef 1) #8, !dbg !203
  unreachable, !dbg !203

8:                                                ; preds = %0
  %9 = load ptr, ptr @slots, align 8, !dbg !205
  call void @ck_spinlock_anderson_init(ptr noundef @lock, ptr noundef %9, i32 noundef 3), !dbg !206
  store i32 0, ptr %3, align 4, !dbg !207
  br label %10, !dbg !209

10:                                               ; preds = %21, %8
  %11 = load i32, ptr %3, align 4, !dbg !210
  %12 = icmp slt i32 %11, 3, !dbg !212
  br i1 %12, label %13, label %24, !dbg !213

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4, !dbg !214
  %15 = sext i32 %14 to i64, !dbg !217
  %16 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %15, !dbg !217
  %17 = call i32 @pthread_create(ptr noundef %16, ptr noundef null, ptr noundef @run, ptr noundef null) #9, !dbg !218
  %18 = icmp ne i32 %17, 0, !dbg !219
  br i1 %18, label %19, label %20, !dbg !220

19:                                               ; preds = %13
  call void @exit(i32 noundef 1) #8, !dbg !221
  unreachable, !dbg !221

20:                                               ; preds = %13
  br label %21, !dbg !223

21:                                               ; preds = %20
  %22 = load i32, ptr %3, align 4, !dbg !224
  %23 = add nsw i32 %22, 1, !dbg !224
  store i32 %23, ptr %3, align 4, !dbg !224
  br label %10, !dbg !225, !llvm.loop !226

24:                                               ; preds = %10
  store i32 0, ptr %3, align 4, !dbg !228
  br label %25, !dbg !230

25:                                               ; preds = %37, %24
  %26 = load i32, ptr %3, align 4, !dbg !231
  %27 = icmp slt i32 %26, 3, !dbg !233
  br i1 %27, label %28, label %40, !dbg !234

28:                                               ; preds = %25
  %29 = load i32, ptr %3, align 4, !dbg !235
  %30 = sext i32 %29 to i64, !dbg !238
  %31 = getelementptr inbounds [3 x i64], ptr %2, i64 0, i64 %30, !dbg !238
  %32 = load i64, ptr %31, align 8, !dbg !238
  %33 = call i32 @pthread_join(i64 noundef %32, ptr noundef null), !dbg !239
  %34 = icmp ne i32 %33, 0, !dbg !240
  br i1 %34, label %35, label %36, !dbg !241

35:                                               ; preds = %28
  call void @exit(i32 noundef 1) #8, !dbg !242
  unreachable, !dbg !242

36:                                               ; preds = %28
  br label %37, !dbg !244

37:                                               ; preds = %36
  %38 = load i32, ptr %3, align 4, !dbg !245
  %39 = add nsw i32 %38, 1, !dbg !245
  store i32 %39, ptr %3, align 4, !dbg !245
  br label %25, !dbg !246, !llvm.loop !247

40:                                               ; preds = %25
  %41 = load i32, ptr @x, align 4, !dbg !249
  %42 = icmp eq i32 %41, 3, !dbg !249
  br i1 %42, label %43, label %47, !dbg !249

43:                                               ; preds = %40
  %44 = load i32, ptr @y, align 4, !dbg !249
  %45 = icmp eq i32 %44, 3, !dbg !249
  br i1 %45, label %46, label %47, !dbg !252

46:                                               ; preds = %43
  br label %48, !dbg !252

47:                                               ; preds = %43, %40
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 55, ptr noundef @__PRETTY_FUNCTION__.main) #8, !dbg !249
  unreachable, !dbg !249

48:                                               ; preds = %46
  %49 = load ptr, ptr @slots, align 8, !dbg !253
  call void @free(ptr noundef %49) #9, !dbg !254
  ret i32 0, !dbg !255
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_anderson_init(ptr noundef %0, ptr noundef %1, i32 noundef %2) #0 !dbg !256 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !259, metadata !DIExpression()), !dbg !260
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !261, metadata !DIExpression()), !dbg !262
  store i32 %2, ptr %6, align 4
  call void @llvm.dbg.declare(metadata ptr %6, metadata !263, metadata !DIExpression()), !dbg !264
  call void @llvm.dbg.declare(metadata ptr %7, metadata !265, metadata !DIExpression()), !dbg !266
  %8 = load ptr, ptr %5, align 8, !dbg !267
  %9 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %8, i64 0, !dbg !267
  %10 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %9, i32 0, i32 0, !dbg !268
  store i32 0, ptr %10, align 4, !dbg !269
  %11 = load ptr, ptr %5, align 8, !dbg !270
  %12 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %11, i64 0, !dbg !270
  %13 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %12, i32 0, i32 1, !dbg !271
  store i32 0, ptr %13, align 4, !dbg !272
  store i32 1, ptr %7, align 4, !dbg !273
  br label %14, !dbg !275

14:                                               ; preds = %30, %3
  %15 = load i32, ptr %7, align 4, !dbg !276
  %16 = load i32, ptr %6, align 4, !dbg !278
  %17 = icmp ult i32 %15, %16, !dbg !279
  br i1 %17, label %18, label %33, !dbg !280

18:                                               ; preds = %14
  %19 = load ptr, ptr %5, align 8, !dbg !281
  %20 = load i32, ptr %7, align 4, !dbg !283
  %21 = zext i32 %20 to i64, !dbg !281
  %22 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %19, i64 %21, !dbg !281
  %23 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %22, i32 0, i32 0, !dbg !284
  store i32 1, ptr %23, align 4, !dbg !285
  %24 = load i32, ptr %7, align 4, !dbg !286
  %25 = load ptr, ptr %5, align 8, !dbg !287
  %26 = load i32, ptr %7, align 4, !dbg !288
  %27 = zext i32 %26 to i64, !dbg !287
  %28 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %25, i64 %27, !dbg !287
  %29 = getelementptr inbounds %struct.ck_spinlock_anderson_thread, ptr %28, i32 0, i32 1, !dbg !289
  store i32 %24, ptr %29, align 4, !dbg !290
  br label %30, !dbg !291

30:                                               ; preds = %18
  %31 = load i32, ptr %7, align 4, !dbg !292
  %32 = add i32 %31, 1, !dbg !292
  store i32 %32, ptr %7, align 4, !dbg !292
  br label %14, !dbg !293, !llvm.loop !294

33:                                               ; preds = %14
  %34 = load ptr, ptr %5, align 8, !dbg !296
  %35 = load ptr, ptr %4, align 8, !dbg !297
  %36 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %35, i32 0, i32 0, !dbg !298
  store ptr %34, ptr %36, align 8, !dbg !299
  %37 = load i32, ptr %6, align 4, !dbg !300
  %38 = load ptr, ptr %4, align 8, !dbg !301
  %39 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %38, i32 0, i32 1, !dbg !302
  store i32 %37, ptr %39, align 8, !dbg !303
  %40 = load i32, ptr %6, align 4, !dbg !304
  %41 = sub i32 %40, 1, !dbg !305
  %42 = load ptr, ptr %4, align 8, !dbg !306
  %43 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %42, i32 0, i32 3, !dbg !307
  store i32 %41, ptr %43, align 8, !dbg !308
  %44 = load ptr, ptr %4, align 8, !dbg !309
  %45 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %44, i32 0, i32 5, !dbg !310
  store i32 0, ptr %45, align 8, !dbg !311
  %46 = load i32, ptr %6, align 4, !dbg !312
  %47 = load i32, ptr %6, align 4, !dbg !314
  %48 = sub i32 %47, 1, !dbg !315
  %49 = and i32 %46, %48, !dbg !316
  %50 = icmp ne i32 %49, 0, !dbg !316
  br i1 %50, label %51, label %57, !dbg !317

51:                                               ; preds = %33
  %52 = load i32, ptr %6, align 4, !dbg !318
  %53 = urem i32 -1, %52, !dbg !319
  %54 = add i32 %53, 1, !dbg !320
  %55 = load ptr, ptr %4, align 8, !dbg !321
  %56 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %55, i32 0, i32 2, !dbg !322
  store i32 %54, ptr %56, align 4, !dbg !323
  br label %60, !dbg !321

57:                                               ; preds = %33
  %58 = load ptr, ptr %4, align 8, !dbg !324
  %59 = getelementptr inbounds %struct.ck_spinlock_anderson, ptr %58, i32 0, i32 2, !dbg !325
  store i32 0, ptr %59, align 4, !dbg !326
  br label %60

60:                                               ; preds = %57, %51
  call void @ck_pr_barrier(), !dbg !327
  ret void, !dbg !328
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #5

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #3

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !329 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !333, metadata !DIExpression()), !dbg !334
  call void @llvm.dbg.declare(metadata ptr %3, metadata !335, metadata !DIExpression()), !dbg !334
  %4 = load ptr, ptr %2, align 8, !dbg !334
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #9, !dbg !334, !srcloc !336
  store i32 %5, ptr %3, align 4, !dbg !334
  %6 = load i32, ptr %3, align 4, !dbg !334
  ret i32 %6, !dbg !334
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_uint_value(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 !dbg !337 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i8, align 1
  store ptr %0, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !341, metadata !DIExpression()), !dbg !342
  store i32 %1, ptr %6, align 4
  call void @llvm.dbg.declare(metadata ptr %6, metadata !343, metadata !DIExpression()), !dbg !342
  store i32 %2, ptr %7, align 4
  call void @llvm.dbg.declare(metadata ptr %7, metadata !344, metadata !DIExpression()), !dbg !342
  store ptr %3, ptr %8, align 8
  call void @llvm.dbg.declare(metadata ptr %8, metadata !345, metadata !DIExpression()), !dbg !342
  call void @llvm.dbg.declare(metadata ptr %9, metadata !346, metadata !DIExpression()), !dbg !342
  %10 = load ptr, ptr %5, align 8, !dbg !342
  %11 = load i32, ptr %6, align 4, !dbg !342
  %12 = load i32, ptr %7, align 4, !dbg !342
  %13 = call { i8, i32 } asm sideeffect "lock cmpxchgl $3, $0;", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %10, i32 %12, ptr elementtype(i32) %10, i32 %11) #9, !dbg !342, !srcloc !347
  %14 = extractvalue { i8, i32 } %13, 0, !dbg !342
  %15 = extractvalue { i8, i32 } %13, 1, !dbg !342
  %16 = icmp ult i8 %14, 2, !dbg !342
  call void @llvm.assume(i1 %16), !dbg !342
  store i8 %14, ptr %9, align 1, !dbg !342
  store i32 %15, ptr %6, align 4, !dbg !342
  %17 = load i32, ptr %6, align 4, !dbg !342
  %18 = load ptr, ptr %8, align 8, !dbg !342
  store i32 %17, ptr %18, align 4, !dbg !342
  %19 = load i8, ptr %9, align 1, !dbg !342
  %20 = trunc i8 %19 to i1, !dbg !342
  ret i1 %20, !dbg !342
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_faa_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !348 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !351, metadata !DIExpression()), !dbg !352
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !353, metadata !DIExpression()), !dbg !352
  %5 = load ptr, ptr %3, align 8, !dbg !352
  %6 = load i32, ptr %4, align 4, !dbg !352
  %7 = call i32 asm sideeffect "lock xaddl $1, $0", "=*m,=q,*m,1,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, ptr elementtype(i32) %5, i32 %6) #9, !dbg !352, !srcloc !354
  store i32 %7, ptr %4, align 4, !dbg !352
  %8 = load i32, ptr %4, align 4, !dbg !352
  ret i32 %8, !dbg !352
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_load() #0 !dbg !355 {
  call void @ck_pr_barrier(), !dbg !359
  ret void, !dbg !359
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !360 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #9, !dbg !361, !srcloc !362
  ret void, !dbg !363
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !364 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !367, metadata !DIExpression()), !dbg !368
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !369, metadata !DIExpression()), !dbg !368
  %5 = load ptr, ptr %3, align 8, !dbg !368
  %6 = load i32, ptr %4, align 4, !dbg !368
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #9, !dbg !368, !srcloc !370
  ret void, !dbg !368
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_lock() #0 !dbg !371 {
  call void @ck_pr_barrier(), !dbg !372
  ret void, !dbg !372
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #6

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !373 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #9, !dbg !375, !srcloc !376
  ret void, !dbg !377
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_unlock() #0 !dbg !378 {
  call void @ck_pr_barrier(), !dbg !379
  ret void, !dbg !379
}

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
!1 = distinct !DIGlobalVariable(name: "x", scope: !2, file: !3, line: 10, type: !20, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !17, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/anderson.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "3e8b6a5b525882d6b2763da0001a63b2")
!4 = !{!5, !6, !14, !16}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_anderson_thread_t", file: !8, line: 45, baseType: !9)
!8 = !DIFile(filename: "include/spinlock/anderson.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6be228a7ecae2c5a8091cfc6ea102208")
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_anderson_thread", file: !8, line: 41, size: 64, elements: !10)
!10 = !{!11, !13}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "locked", scope: !9, file: !8, line: 42, baseType: !12, size: 32)
!12 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "position", scope: !9, file: !8, line: 43, baseType: !12, size: 32, offset: 32)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !12)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!17 = !{!0, !18, !21, !27, !32, !38, !53}
!18 = !DIGlobalVariableExpression(var: !19, expr: !DIExpression())
!19 = distinct !DIGlobalVariable(name: "y", scope: !2, file: !3, line: 10, type: !20, isLocal: false, isDefinition: true)
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(scope: null, file: !3, line: 55, type: !23, isLocal: true, isDefinition: true)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 248, elements: !25)
!24 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!25 = !{!26}
!26 = !DISubrange(count: 31)
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(scope: null, file: !3, line: 55, type: !29, isLocal: true, isDefinition: true)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 136, elements: !30)
!30 = !{!31}
!31 = !DISubrange(count: 17)
!32 = !DIGlobalVariableExpression(var: !33, expr: !DIExpression())
!33 = distinct !DIGlobalVariable(scope: null, file: !3, line: 55, type: !34, isLocal: true, isDefinition: true)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !35, size: 88, elements: !36)
!35 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !24)
!36 = !{!37}
!37 = !DISubrange(count: 11)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(name: "lock", scope: !2, file: !3, line: 11, type: !40, isLocal: false, isDefinition: true)
!40 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_anderson_t", file: !8, line: 55, baseType: !41)
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_anderson", file: !8, line: 47, size: 576, elements: !42)
!42 = !{!43, !45, !46, !47, !48, !52}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "slots", scope: !41, file: !8, line: 48, baseType: !44, size: 64)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "count", scope: !41, file: !8, line: 49, baseType: !12, size: 32, offset: 64)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "wrap", scope: !41, file: !8, line: 50, baseType: !12, size: 32, offset: 96)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "mask", scope: !41, file: !8, line: 51, baseType: !12, size: 32, offset: 128)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "pad", scope: !41, file: !8, line: 52, baseType: !49, size: 352, offset: 160)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 352, elements: !50)
!50 = !{!51}
!51 = !DISubrange(count: 44)
!52 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !41, file: !8, line: 53, baseType: !12, size: 32, offset: 512)
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(name: "slots", scope: !2, file: !3, line: 12, type: !6, isLocal: false, isDefinition: true)
!55 = !{i32 7, !"Dwarf Version", i32 5}
!56 = !{i32 2, !"Debug Info Version", i32 3}
!57 = !{i32 1, !"wchar_size", i32 4}
!58 = !{i32 8, !"PIC Level", i32 2}
!59 = !{i32 7, !"PIE Level", i32 2}
!60 = !{i32 7, !"uwtable", i32 2}
!61 = !{i32 7, !"frame-pointer", i32 2}
!62 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!63 = distinct !DISubprogram(name: "run", scope: !3, file: !3, line: 14, type: !64, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !66)
!64 = !DISubroutineType(types: !65)
!65 = !{!5, !5}
!66 = !{}
!67 = !DILocalVariable(name: "arg", arg: 1, scope: !63, file: !3, line: 14, type: !5)
!68 = !DILocation(line: 14, column: 17, scope: !63)
!69 = !DILocalVariable(name: "my_slot", scope: !63, file: !3, line: 16, type: !6)
!70 = !DILocation(line: 16, column: 36, scope: !63)
!71 = !DILocation(line: 17, column: 5, scope: !63)
!72 = !DILocation(line: 19, column: 6, scope: !63)
!73 = !DILocation(line: 20, column: 6, scope: !63)
!74 = !DILocation(line: 22, column: 40, scope: !63)
!75 = !DILocation(line: 22, column: 5, scope: !63)
!76 = !DILocation(line: 23, column: 5, scope: !63)
!77 = distinct !DISubprogram(name: "ck_spinlock_anderson_lock", scope: !8, file: !8, line: 103, type: !78, scopeLine: 105, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!78 = !DISubroutineType(types: !79)
!79 = !{null, !80, !81}
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!82 = !DILocalVariable(name: "lock", arg: 1, scope: !77, file: !8, line: 103, type: !80)
!83 = !DILocation(line: 103, column: 56, scope: !77)
!84 = !DILocalVariable(name: "slot", arg: 2, scope: !77, file: !8, line: 104, type: !81)
!85 = !DILocation(line: 104, column: 42, scope: !77)
!86 = !DILocalVariable(name: "position", scope: !77, file: !8, line: 106, type: !12)
!87 = !DILocation(line: 106, column: 15, scope: !77)
!88 = !DILocalVariable(name: "next", scope: !77, file: !8, line: 106, type: !12)
!89 = !DILocation(line: 106, column: 25, scope: !77)
!90 = !DILocalVariable(name: "count", scope: !77, file: !8, line: 107, type: !12)
!91 = !DILocation(line: 107, column: 15, scope: !77)
!92 = !DILocation(line: 107, column: 23, scope: !77)
!93 = !DILocation(line: 107, column: 29, scope: !77)
!94 = !DILocation(line: 114, column: 6, scope: !95)
!95 = distinct !DILexicalBlock(scope: !77, file: !8, line: 114, column: 6)
!96 = !DILocation(line: 114, column: 12, scope: !95)
!97 = !DILocation(line: 114, column: 17, scope: !95)
!98 = !DILocation(line: 114, column: 6, scope: !77)
!99 = !DILocation(line: 115, column: 14, scope: !100)
!100 = distinct !DILexicalBlock(scope: !95, file: !8, line: 114, column: 23)
!101 = !DILocation(line: 115, column: 12, scope: !100)
!102 = !DILocation(line: 117, column: 3, scope: !100)
!103 = !DILocation(line: 118, column: 8, scope: !104)
!104 = distinct !DILexicalBlock(scope: !105, file: !8, line: 118, column: 8)
!105 = distinct !DILexicalBlock(scope: !100, file: !8, line: 117, column: 6)
!106 = !DILocation(line: 118, column: 17, scope: !104)
!107 = !DILocation(line: 118, column: 8, scope: !105)
!108 = !DILocation(line: 119, column: 12, scope: !104)
!109 = !DILocation(line: 119, column: 18, scope: !104)
!110 = !DILocation(line: 119, column: 10, scope: !104)
!111 = !DILocation(line: 119, column: 5, scope: !104)
!112 = !DILocation(line: 121, column: 12, scope: !104)
!113 = !DILocation(line: 121, column: 21, scope: !104)
!114 = !DILocation(line: 121, column: 10, scope: !104)
!115 = !DILocation(line: 122, column: 3, scope: !105)
!116 = !DILocation(line: 122, column: 34, scope: !100)
!117 = !DILocation(line: 122, column: 40, scope: !100)
!118 = !DILocation(line: 122, column: 46, scope: !100)
!119 = !DILocation(line: 123, column: 12, scope: !100)
!120 = !DILocation(line: 122, column: 12, scope: !100)
!121 = !DILocation(line: 123, column: 29, scope: !100)
!122 = distinct !{!122, !102, !123, !124}
!123 = !DILocation(line: 123, column: 37, scope: !100)
!124 = !{!"llvm.loop.mustprogress"}
!125 = !DILocation(line: 125, column: 15, scope: !100)
!126 = !DILocation(line: 125, column: 12, scope: !100)
!127 = !DILocation(line: 126, column: 2, scope: !100)
!128 = !DILocation(line: 127, column: 30, scope: !129)
!129 = distinct !DILexicalBlock(scope: !95, file: !8, line: 126, column: 9)
!130 = !DILocation(line: 127, column: 36, scope: !129)
!131 = !DILocation(line: 127, column: 14, scope: !129)
!132 = !DILocation(line: 127, column: 12, scope: !129)
!133 = !DILocation(line: 128, column: 15, scope: !129)
!134 = !DILocation(line: 128, column: 21, scope: !129)
!135 = !DILocation(line: 128, column: 12, scope: !129)
!136 = !DILocation(line: 132, column: 2, scope: !77)
!137 = !DILocation(line: 138, column: 2, scope: !77)
!138 = !DILocation(line: 138, column: 9, scope: !77)
!139 = !DILocation(line: 138, column: 56, scope: !77)
!140 = !DILocation(line: 139, column: 3, scope: !77)
!141 = distinct !{!141, !137, !142, !124}
!142 = !DILocation(line: 139, column: 15, scope: !77)
!143 = !DILocation(line: 142, column: 2, scope: !77)
!144 = !DILocation(line: 143, column: 2, scope: !77)
!145 = !DILocation(line: 145, column: 10, scope: !77)
!146 = !DILocation(line: 145, column: 16, scope: !77)
!147 = !DILocation(line: 145, column: 24, scope: !77)
!148 = !DILocation(line: 145, column: 22, scope: !77)
!149 = !DILocation(line: 145, column: 3, scope: !77)
!150 = !DILocation(line: 145, column: 8, scope: !77)
!151 = !DILocation(line: 146, column: 2, scope: !77)
!152 = distinct !DISubprogram(name: "ck_spinlock_anderson_unlock", scope: !8, file: !8, line: 150, type: !153, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!153 = !DISubroutineType(types: !154)
!154 = !{null, !80, !44}
!155 = !DILocalVariable(name: "lock", arg: 1, scope: !152, file: !8, line: 150, type: !80)
!156 = !DILocation(line: 150, column: 58, scope: !152)
!157 = !DILocalVariable(name: "slot", arg: 2, scope: !152, file: !8, line: 151, type: !44)
!158 = !DILocation(line: 151, column: 41, scope: !152)
!159 = !DILocalVariable(name: "position", scope: !152, file: !8, line: 153, type: !12)
!160 = !DILocation(line: 153, column: 15, scope: !152)
!161 = !DILocation(line: 155, column: 2, scope: !152)
!162 = !DILocation(line: 158, column: 6, scope: !163)
!163 = distinct !DILexicalBlock(scope: !152, file: !8, line: 158, column: 6)
!164 = !DILocation(line: 158, column: 12, scope: !163)
!165 = !DILocation(line: 158, column: 17, scope: !163)
!166 = !DILocation(line: 158, column: 6, scope: !152)
!167 = !DILocation(line: 159, column: 15, scope: !163)
!168 = !DILocation(line: 159, column: 21, scope: !163)
!169 = !DILocation(line: 159, column: 30, scope: !163)
!170 = !DILocation(line: 159, column: 37, scope: !163)
!171 = !DILocation(line: 159, column: 43, scope: !163)
!172 = !DILocation(line: 159, column: 35, scope: !163)
!173 = !DILocation(line: 159, column: 12, scope: !163)
!174 = !DILocation(line: 159, column: 3, scope: !163)
!175 = !DILocation(line: 161, column: 15, scope: !163)
!176 = !DILocation(line: 161, column: 21, scope: !163)
!177 = !DILocation(line: 161, column: 30, scope: !163)
!178 = !DILocation(line: 161, column: 37, scope: !163)
!179 = !DILocation(line: 161, column: 43, scope: !163)
!180 = !DILocation(line: 161, column: 35, scope: !163)
!181 = !DILocation(line: 161, column: 12, scope: !163)
!182 = !DILocation(line: 163, column: 2, scope: !152)
!183 = !DILocation(line: 164, column: 2, scope: !152)
!184 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !185, scopeLine: 27, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !66)
!185 = !DISubroutineType(types: !186)
!186 = !{!20}
!187 = !DILocalVariable(name: "threads", scope: !184, file: !3, line: 28, type: !188)
!188 = !DICompositeType(tag: DW_TAG_array_type, baseType: !189, size: 192, elements: !192)
!189 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !190, line: 27, baseType: !191)
!190 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!191 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!192 = !{!193}
!193 = !DISubrange(count: 3)
!194 = !DILocation(line: 28, column: 15, scope: !184)
!195 = !DILocalVariable(name: "i", scope: !184, file: !3, line: 29, type: !20)
!196 = !DILocation(line: 29, column: 9, scope: !184)
!197 = !DILocation(line: 31, column: 46, scope: !184)
!198 = !DILocation(line: 31, column: 11, scope: !184)
!199 = !DILocation(line: 32, column: 9, scope: !200)
!200 = distinct !DILexicalBlock(scope: !184, file: !3, line: 32, column: 9)
!201 = !DILocation(line: 32, column: 15, scope: !200)
!202 = !DILocation(line: 32, column: 9, scope: !184)
!203 = !DILocation(line: 34, column: 9, scope: !204)
!204 = distinct !DILexicalBlock(scope: !200, file: !3, line: 33, column: 5)
!205 = !DILocation(line: 37, column: 38, scope: !184)
!206 = !DILocation(line: 37, column: 5, scope: !184)
!207 = !DILocation(line: 39, column: 12, scope: !208)
!208 = distinct !DILexicalBlock(scope: !184, file: !3, line: 39, column: 5)
!209 = !DILocation(line: 39, column: 10, scope: !208)
!210 = !DILocation(line: 39, column: 17, scope: !211)
!211 = distinct !DILexicalBlock(scope: !208, file: !3, line: 39, column: 5)
!212 = !DILocation(line: 39, column: 19, scope: !211)
!213 = !DILocation(line: 39, column: 5, scope: !208)
!214 = !DILocation(line: 41, column: 37, scope: !215)
!215 = distinct !DILexicalBlock(scope: !216, file: !3, line: 41, column: 13)
!216 = distinct !DILexicalBlock(scope: !211, file: !3, line: 40, column: 5)
!217 = !DILocation(line: 41, column: 29, scope: !215)
!218 = !DILocation(line: 41, column: 13, scope: !215)
!219 = !DILocation(line: 41, column: 58, scope: !215)
!220 = !DILocation(line: 41, column: 13, scope: !216)
!221 = !DILocation(line: 43, column: 13, scope: !222)
!222 = distinct !DILexicalBlock(scope: !215, file: !3, line: 42, column: 9)
!223 = !DILocation(line: 45, column: 5, scope: !216)
!224 = !DILocation(line: 39, column: 32, scope: !211)
!225 = !DILocation(line: 39, column: 5, scope: !211)
!226 = distinct !{!226, !213, !227, !124}
!227 = !DILocation(line: 45, column: 5, scope: !208)
!228 = !DILocation(line: 47, column: 12, scope: !229)
!229 = distinct !DILexicalBlock(scope: !184, file: !3, line: 47, column: 5)
!230 = !DILocation(line: 47, column: 10, scope: !229)
!231 = !DILocation(line: 47, column: 17, scope: !232)
!232 = distinct !DILexicalBlock(scope: !229, file: !3, line: 47, column: 5)
!233 = !DILocation(line: 47, column: 19, scope: !232)
!234 = !DILocation(line: 47, column: 5, scope: !229)
!235 = !DILocation(line: 49, column: 34, scope: !236)
!236 = distinct !DILexicalBlock(scope: !237, file: !3, line: 49, column: 13)
!237 = distinct !DILexicalBlock(scope: !232, file: !3, line: 48, column: 5)
!238 = !DILocation(line: 49, column: 26, scope: !236)
!239 = !DILocation(line: 49, column: 13, scope: !236)
!240 = !DILocation(line: 49, column: 44, scope: !236)
!241 = !DILocation(line: 49, column: 13, scope: !237)
!242 = !DILocation(line: 51, column: 13, scope: !243)
!243 = distinct !DILexicalBlock(scope: !236, file: !3, line: 50, column: 9)
!244 = !DILocation(line: 53, column: 5, scope: !237)
!245 = !DILocation(line: 47, column: 32, scope: !232)
!246 = !DILocation(line: 47, column: 5, scope: !232)
!247 = distinct !{!247, !234, !248, !124}
!248 = !DILocation(line: 53, column: 5, scope: !229)
!249 = !DILocation(line: 55, column: 5, scope: !250)
!250 = distinct !DILexicalBlock(scope: !251, file: !3, line: 55, column: 5)
!251 = distinct !DILexicalBlock(scope: !184, file: !3, line: 55, column: 5)
!252 = !DILocation(line: 55, column: 5, scope: !251)
!253 = !DILocation(line: 57, column: 10, scope: !184)
!254 = !DILocation(line: 57, column: 5, scope: !184)
!255 = !DILocation(line: 59, column: 5, scope: !184)
!256 = distinct !DISubprogram(name: "ck_spinlock_anderson_init", scope: !8, file: !8, line: 58, type: !257, scopeLine: 61, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!257 = !DISubroutineType(types: !258)
!258 = !{null, !80, !44, !12}
!259 = !DILocalVariable(name: "lock", arg: 1, scope: !256, file: !8, line: 58, type: !80)
!260 = !DILocation(line: 58, column: 56, scope: !256)
!261 = !DILocalVariable(name: "slots", arg: 2, scope: !256, file: !8, line: 59, type: !44)
!262 = !DILocation(line: 59, column: 41, scope: !256)
!263 = !DILocalVariable(name: "count", arg: 3, scope: !256, file: !8, line: 60, type: !12)
!264 = !DILocation(line: 60, column: 18, scope: !256)
!265 = !DILocalVariable(name: "i", scope: !256, file: !8, line: 62, type: !12)
!266 = !DILocation(line: 62, column: 15, scope: !256)
!267 = !DILocation(line: 64, column: 2, scope: !256)
!268 = !DILocation(line: 64, column: 11, scope: !256)
!269 = !DILocation(line: 64, column: 18, scope: !256)
!270 = !DILocation(line: 65, column: 2, scope: !256)
!271 = !DILocation(line: 65, column: 11, scope: !256)
!272 = !DILocation(line: 65, column: 20, scope: !256)
!273 = !DILocation(line: 66, column: 9, scope: !274)
!274 = distinct !DILexicalBlock(scope: !256, file: !8, line: 66, column: 2)
!275 = !DILocation(line: 66, column: 7, scope: !274)
!276 = !DILocation(line: 66, column: 14, scope: !277)
!277 = distinct !DILexicalBlock(scope: !274, file: !8, line: 66, column: 2)
!278 = !DILocation(line: 66, column: 18, scope: !277)
!279 = !DILocation(line: 66, column: 16, scope: !277)
!280 = !DILocation(line: 66, column: 2, scope: !274)
!281 = !DILocation(line: 67, column: 3, scope: !282)
!282 = distinct !DILexicalBlock(scope: !277, file: !8, line: 66, column: 30)
!283 = !DILocation(line: 67, column: 9, scope: !282)
!284 = !DILocation(line: 67, column: 12, scope: !282)
!285 = !DILocation(line: 67, column: 19, scope: !282)
!286 = !DILocation(line: 68, column: 23, scope: !282)
!287 = !DILocation(line: 68, column: 3, scope: !282)
!288 = !DILocation(line: 68, column: 9, scope: !282)
!289 = !DILocation(line: 68, column: 12, scope: !282)
!290 = !DILocation(line: 68, column: 21, scope: !282)
!291 = !DILocation(line: 69, column: 2, scope: !282)
!292 = !DILocation(line: 66, column: 26, scope: !277)
!293 = !DILocation(line: 66, column: 2, scope: !277)
!294 = distinct !{!294, !280, !295, !124}
!295 = !DILocation(line: 69, column: 2, scope: !274)
!296 = !DILocation(line: 71, column: 16, scope: !256)
!297 = !DILocation(line: 71, column: 2, scope: !256)
!298 = !DILocation(line: 71, column: 8, scope: !256)
!299 = !DILocation(line: 71, column: 14, scope: !256)
!300 = !DILocation(line: 72, column: 16, scope: !256)
!301 = !DILocation(line: 72, column: 2, scope: !256)
!302 = !DILocation(line: 72, column: 8, scope: !256)
!303 = !DILocation(line: 72, column: 14, scope: !256)
!304 = !DILocation(line: 73, column: 15, scope: !256)
!305 = !DILocation(line: 73, column: 21, scope: !256)
!306 = !DILocation(line: 73, column: 2, scope: !256)
!307 = !DILocation(line: 73, column: 8, scope: !256)
!308 = !DILocation(line: 73, column: 13, scope: !256)
!309 = !DILocation(line: 74, column: 2, scope: !256)
!310 = !DILocation(line: 74, column: 8, scope: !256)
!311 = !DILocation(line: 74, column: 13, scope: !256)
!312 = !DILocation(line: 81, column: 6, scope: !313)
!313 = distinct !DILexicalBlock(scope: !256, file: !8, line: 81, column: 6)
!314 = !DILocation(line: 81, column: 15, scope: !313)
!315 = !DILocation(line: 81, column: 21, scope: !313)
!316 = !DILocation(line: 81, column: 12, scope: !313)
!317 = !DILocation(line: 81, column: 6, scope: !256)
!318 = !DILocation(line: 82, column: 28, scope: !313)
!319 = !DILocation(line: 82, column: 26, scope: !313)
!320 = !DILocation(line: 82, column: 35, scope: !313)
!321 = !DILocation(line: 82, column: 3, scope: !313)
!322 = !DILocation(line: 82, column: 9, scope: !313)
!323 = !DILocation(line: 82, column: 14, scope: !313)
!324 = !DILocation(line: 84, column: 3, scope: !313)
!325 = !DILocation(line: 84, column: 9, scope: !313)
!326 = !DILocation(line: 84, column: 14, scope: !313)
!327 = !DILocation(line: 86, column: 2, scope: !256)
!328 = !DILocation(line: 87, column: 2, scope: !256)
!329 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !330, file: !330, line: 190, type: !331, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!330 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!331 = !DISubroutineType(types: !332)
!332 = !{!12, !14}
!333 = !DILocalVariable(name: "target", arg: 1, scope: !329, file: !330, line: 190, type: !14)
!334 = !DILocation(line: 190, column: 1, scope: !329)
!335 = !DILocalVariable(name: "r", scope: !329, file: !330, line: 190, type: !12)
!336 = !{i64 2147752226}
!337 = distinct !DISubprogram(name: "ck_pr_cas_uint_value", scope: !330, file: !330, line: 479, type: !338, scopeLine: 479, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!338 = !DISubroutineType(types: !339)
!339 = !{!340, !16, !12, !12, !16}
!340 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!341 = !DILocalVariable(name: "target", arg: 1, scope: !337, file: !330, line: 479, type: !16)
!342 = !DILocation(line: 479, column: 1, scope: !337)
!343 = !DILocalVariable(name: "compare", arg: 2, scope: !337, file: !330, line: 479, type: !12)
!344 = !DILocalVariable(name: "set", arg: 3, scope: !337, file: !330, line: 479, type: !12)
!345 = !DILocalVariable(name: "v", arg: 4, scope: !337, file: !330, line: 479, type: !16)
!346 = !DILocalVariable(name: "z", scope: !337, file: !330, line: 479, type: !340)
!347 = !{i64 2147817559}
!348 = distinct !DISubprogram(name: "ck_pr_faa_uint", scope: !330, file: !330, line: 306, type: !349, scopeLine: 306, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!349 = !DISubroutineType(types: !350)
!350 = !{!12, !16, !12}
!351 = !DILocalVariable(name: "target", arg: 1, scope: !348, file: !330, line: 306, type: !16)
!352 = !DILocation(line: 306, column: 1, scope: !348)
!353 = !DILocalVariable(name: "d", arg: 2, scope: !348, file: !330, line: 306, type: !12)
!354 = !{i64 2147761046}
!355 = distinct !DISubprogram(name: "ck_pr_fence_load", scope: !356, file: !356, line: 156, type: !357, scopeLine: 156, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!356 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!357 = !DISubroutineType(types: !358)
!358 = !{null}
!359 = !DILocation(line: 156, column: 1, scope: !355)
!360 = distinct !DISubprogram(name: "ck_pr_stall", scope: !330, file: !330, line: 65, type: !357, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!361 = !DILocation(line: 67, column: 2, scope: !360)
!362 = !{i64 240369}
!363 = !DILocation(line: 68, column: 2, scope: !360)
!364 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !330, file: !330, line: 276, type: !365, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !66)
!365 = !DISubroutineType(types: !366)
!366 = !{null, !16, !12}
!367 = !DILocalVariable(name: "target", arg: 1, scope: !364, file: !330, line: 276, type: !16)
!368 = !DILocation(line: 276, column: 1, scope: !364)
!369 = !DILocalVariable(name: "v", arg: 2, scope: !364, file: !330, line: 276, type: !12)
!370 = !{i64 2147758220}
!371 = distinct !DISubprogram(name: "ck_pr_fence_lock", scope: !356, file: !356, line: 162, type: !357, scopeLine: 162, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!372 = !DILocation(line: 162, column: 1, scope: !371)
!373 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !374, file: !374, line: 37, type: !357, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!374 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!375 = !DILocation(line: 40, column: 2, scope: !373)
!376 = !{i64 359714}
!377 = !DILocation(line: 41, column: 2, scope: !373)
!378 = distinct !DISubprogram(name: "ck_pr_fence_unlock", scope: !356, file: !356, line: 163, type: !357, scopeLine: 163, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!379 = !DILocation(line: 163, column: 1, scope: !378)
