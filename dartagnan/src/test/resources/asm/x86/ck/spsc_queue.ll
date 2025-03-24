; ModuleID = 'tests/spsc_queue.c'
source_filename = "tests/spsc_queue.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_fifo_spsc = type { %struct.ck_spinlock_fas, ptr, [52 x i8], %struct.ck_spinlock_fas, ptr, ptr, ptr }
%struct.ck_spinlock_fas = type { i32 }
%struct.point_s = type { i32, i32 }
%struct.ck_fifo_spsc_entry = type { ptr, ptr }

@queue = dso_local global %struct.ck_fifo_spsc zeroinitializer, align 8, !dbg !0
@.str = private unnamed_addr constant [20 x i8] c"NULL point received\00", align 1, !dbg !22
@.str.1 = private unnamed_addr constant [39 x i8] c"point != NULL && \22NULL point received\22\00", align 1, !dbg !28
@.str.2 = private unnamed_addr constant [19 x i8] c"tests/spsc_queue.c\00", align 1, !dbg !33
@__PRETTY_FUNCTION__.consumer = private unnamed_addr constant [23 x i8] c"void *consumer(void *)\00", align 1, !dbg !38
@.str.3 = private unnamed_addr constant [21 x i8] c"point->x == point->y\00", align 1, !dbg !44
@.str.4 = private unnamed_addr constant [14 x i8] c"point->y == 1\00", align 1, !dbg !49

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @producer(ptr noundef %0) #0 !dbg !81 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !85, metadata !DIExpression()), !dbg !86
  call void @llvm.dbg.declare(metadata ptr %3, metadata !87, metadata !DIExpression()), !dbg !90
  store i32 0, ptr %3, align 4, !dbg !90
  br label %7, !dbg !91

7:                                                ; preds = %28, %1
  %8 = load i32, ptr %3, align 4, !dbg !92
  %9 = icmp slt i32 %8, 3, !dbg !94
  br i1 %9, label %10, label %31, !dbg !95

10:                                               ; preds = %7
  call void @llvm.dbg.declare(metadata ptr %4, metadata !96, metadata !DIExpression()), !dbg !104
  %11 = call noalias ptr @malloc(i64 noundef 8) #6, !dbg !105
  store ptr %11, ptr %4, align 8, !dbg !104
  %12 = load ptr, ptr %4, align 8, !dbg !106
  %13 = icmp eq ptr %12, null, !dbg !108
  br i1 %13, label %14, label %15, !dbg !109

14:                                               ; preds = %10
  call void @exit(i32 noundef 1) #7, !dbg !110
  unreachable, !dbg !110

15:                                               ; preds = %10
  %16 = load ptr, ptr %4, align 8, !dbg !112
  %17 = getelementptr inbounds %struct.point_s, ptr %16, i32 0, i32 0, !dbg !113
  store i32 1, ptr %17, align 4, !dbg !114
  %18 = load ptr, ptr %4, align 8, !dbg !115
  %19 = getelementptr inbounds %struct.point_s, ptr %18, i32 0, i32 1, !dbg !116
  store i32 1, ptr %19, align 4, !dbg !117
  call void @llvm.dbg.declare(metadata ptr %5, metadata !118, metadata !DIExpression()), !dbg !121
  %20 = call noalias ptr @malloc(i64 noundef 16) #6, !dbg !122
  store ptr %20, ptr %5, align 8, !dbg !121
  %21 = load ptr, ptr %5, align 8, !dbg !123
  %22 = icmp eq ptr %21, null, !dbg !125
  br i1 %22, label %23, label %25, !dbg !126

23:                                               ; preds = %15
  %24 = load ptr, ptr %4, align 8, !dbg !127
  call void @free(ptr noundef %24) #8, !dbg !129
  call void @exit(i32 noundef 1) #7, !dbg !130
  unreachable, !dbg !130

25:                                               ; preds = %15
  %26 = load ptr, ptr %5, align 8, !dbg !131
  %27 = load ptr, ptr %4, align 8, !dbg !132
  call void @ck_fifo_spsc_enqueue(ptr noundef @queue, ptr noundef %26, ptr noundef %27), !dbg !133
  br label %28, !dbg !134

28:                                               ; preds = %25
  %29 = load i32, ptr %3, align 4, !dbg !135
  %30 = add nsw i32 %29, 1, !dbg !135
  store i32 %30, ptr %3, align 4, !dbg !135
  br label %7, !dbg !136, !llvm.loop !137

31:                                               ; preds = %7
  call void @llvm.dbg.declare(metadata ptr %6, metadata !140, metadata !DIExpression()), !dbg !141
  %32 = call noalias ptr @malloc(i64 noundef 16) #6, !dbg !142
  store ptr %32, ptr %6, align 8, !dbg !141
  %33 = load ptr, ptr %6, align 8, !dbg !143
  %34 = icmp eq ptr %33, null, !dbg !145
  br i1 %34, label %35, label %36, !dbg !146

35:                                               ; preds = %31
  call void @exit(i32 noundef 1) #7, !dbg !147
  unreachable, !dbg !147

36:                                               ; preds = %31
  %37 = load ptr, ptr %6, align 8, !dbg !149
  call void @ck_fifo_spsc_enqueue(ptr noundef @queue, ptr noundef %37, ptr noundef null), !dbg !150
  ret ptr null, !dbg !151
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #3

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_fifo_spsc_enqueue(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !152 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !156, metadata !DIExpression()), !dbg !157
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !158, metadata !DIExpression()), !dbg !159
  store ptr %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !160, metadata !DIExpression()), !dbg !161
  %7 = load ptr, ptr %6, align 8, !dbg !162
  %8 = load ptr, ptr %5, align 8, !dbg !163
  %9 = getelementptr inbounds %struct.ck_fifo_spsc_entry, ptr %8, i32 0, i32 0, !dbg !164
  store ptr %7, ptr %9, align 8, !dbg !165
  %10 = load ptr, ptr %5, align 8, !dbg !166
  %11 = getelementptr inbounds %struct.ck_fifo_spsc_entry, ptr %10, i32 0, i32 1, !dbg !167
  store ptr null, ptr %11, align 8, !dbg !168
  call void @ck_pr_fence_store(), !dbg !169
  %12 = load ptr, ptr %4, align 8, !dbg !170
  %13 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %12, i32 0, i32 4, !dbg !170
  %14 = load ptr, ptr %13, align 8, !dbg !170
  %15 = getelementptr inbounds %struct.ck_fifo_spsc_entry, ptr %14, i32 0, i32 1, !dbg !170
  %16 = load ptr, ptr %5, align 8, !dbg !170
  call void @ck_pr_md_store_ptr(ptr noundef %15, ptr noundef %16), !dbg !170
  %17 = load ptr, ptr %5, align 8, !dbg !171
  %18 = load ptr, ptr %4, align 8, !dbg !172
  %19 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %18, i32 0, i32 4, !dbg !173
  store ptr %17, ptr %19, align 8, !dbg !174
  ret void, !dbg !175
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @consumer(ptr noundef %0) #0 !dbg !176 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i8, align 1
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !177, metadata !DIExpression()), !dbg !178
  call void @llvm.dbg.declare(metadata ptr %3, metadata !179, metadata !DIExpression()), !dbg !180
  call void @llvm.dbg.declare(metadata ptr %4, metadata !181, metadata !DIExpression()), !dbg !183
  store i32 0, ptr %4, align 4, !dbg !183
  br label %6, !dbg !184

6:                                                ; preds = %39, %1
  %7 = load i32, ptr %4, align 4, !dbg !185
  %8 = icmp slt i32 %7, 3, !dbg !187
  br i1 %8, label %9, label %42, !dbg !188

9:                                                ; preds = %6
  call void @llvm.dbg.declare(metadata ptr %5, metadata !189, metadata !DIExpression()), !dbg !192
  %10 = call zeroext i1 @ck_fifo_spsc_dequeue(ptr noundef @queue, ptr noundef %3), !dbg !193
  %11 = zext i1 %10 to i8, !dbg !192
  store i8 %11, ptr %5, align 1, !dbg !192
  %12 = load i8, ptr %5, align 1, !dbg !194
  %13 = trunc i8 %12 to i1, !dbg !194
  %14 = zext i1 %13 to i32, !dbg !194
  call void @__VERIFIER_assume(i32 noundef %14), !dbg !195
  %15 = load ptr, ptr %3, align 8, !dbg !196
  %16 = icmp ne ptr %15, null, !dbg !196
  br i1 %16, label %17, label %19, !dbg !196

17:                                               ; preds = %9
  br i1 true, label %18, label %19, !dbg !199

18:                                               ; preds = %17
  br label %20, !dbg !199

19:                                               ; preds = %17, %9
  call void @__assert_fail(ptr noundef @.str.1, ptr noundef @.str.2, i32 noundef 63, ptr noundef @__PRETTY_FUNCTION__.consumer) #7, !dbg !196
  unreachable, !dbg !196

20:                                               ; preds = %18
  %21 = load ptr, ptr %3, align 8, !dbg !200
  %22 = getelementptr inbounds %struct.point_s, ptr %21, i32 0, i32 0, !dbg !200
  %23 = load i32, ptr %22, align 4, !dbg !200
  %24 = load ptr, ptr %3, align 8, !dbg !200
  %25 = getelementptr inbounds %struct.point_s, ptr %24, i32 0, i32 1, !dbg !200
  %26 = load i32, ptr %25, align 4, !dbg !200
  %27 = icmp eq i32 %23, %26, !dbg !200
  br i1 %27, label %28, label %29, !dbg !203

28:                                               ; preds = %20
  br label %30, !dbg !203

29:                                               ; preds = %20
  call void @__assert_fail(ptr noundef @.str.3, ptr noundef @.str.2, i32 noundef 64, ptr noundef @__PRETTY_FUNCTION__.consumer) #7, !dbg !200
  unreachable, !dbg !200

30:                                               ; preds = %28
  %31 = load ptr, ptr %3, align 8, !dbg !204
  %32 = getelementptr inbounds %struct.point_s, ptr %31, i32 0, i32 1, !dbg !204
  %33 = load i32, ptr %32, align 4, !dbg !204
  %34 = icmp eq i32 %33, 1, !dbg !204
  br i1 %34, label %35, label %36, !dbg !207

35:                                               ; preds = %30
  br label %37, !dbg !207

36:                                               ; preds = %30
  call void @__assert_fail(ptr noundef @.str.4, ptr noundef @.str.2, i32 noundef 65, ptr noundef @__PRETTY_FUNCTION__.consumer) #7, !dbg !204
  unreachable, !dbg !204

37:                                               ; preds = %35
  %38 = load ptr, ptr %3, align 8, !dbg !208
  call void @free(ptr noundef %38) #8, !dbg !209
  br label %39, !dbg !210

39:                                               ; preds = %37
  %40 = load i32, ptr %4, align 4, !dbg !211
  %41 = add nsw i32 %40, 1, !dbg !211
  store i32 %41, ptr %4, align 4, !dbg !211
  br label %6, !dbg !212, !llvm.loop !213

42:                                               ; preds = %6
  ret ptr null, !dbg !215
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_fifo_spsc_dequeue(ptr noundef %0, ptr noundef %1) #0 !dbg !216 {
  %3 = alloca i1, align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !219, metadata !DIExpression()), !dbg !220
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !221, metadata !DIExpression()), !dbg !222
  call void @llvm.dbg.declare(metadata ptr %6, metadata !223, metadata !DIExpression()), !dbg !224
  %7 = load ptr, ptr %4, align 8, !dbg !225
  %8 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %7, i32 0, i32 1, !dbg !225
  %9 = load ptr, ptr %8, align 8, !dbg !225
  %10 = getelementptr inbounds %struct.ck_fifo_spsc_entry, ptr %9, i32 0, i32 1, !dbg !225
  %11 = call ptr @ck_pr_md_load_ptr(ptr noundef %10), !dbg !225
  store ptr %11, ptr %6, align 8, !dbg !226
  %12 = load ptr, ptr %6, align 8, !dbg !227
  %13 = icmp eq ptr %12, null, !dbg !229
  br i1 %13, label %14, label %15, !dbg !230

14:                                               ; preds = %2
  store i1 false, ptr %3, align 1, !dbg !231
  br label %23, !dbg !231

15:                                               ; preds = %2
  %16 = load ptr, ptr %5, align 8, !dbg !232
  %17 = load ptr, ptr %6, align 8, !dbg !232
  %18 = getelementptr inbounds %struct.ck_fifo_spsc_entry, ptr %17, i32 0, i32 0, !dbg !232
  %19 = load ptr, ptr %18, align 8, !dbg !232
  call void @ck_pr_md_store_ptr(ptr noundef %16, ptr noundef %19), !dbg !232
  call void @ck_pr_fence_store(), !dbg !233
  %20 = load ptr, ptr %4, align 8, !dbg !234
  %21 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %20, i32 0, i32 1, !dbg !234
  %22 = load ptr, ptr %6, align 8, !dbg !234
  call void @ck_pr_md_store_ptr(ptr noundef %21, ptr noundef %22), !dbg !234
  store i1 true, ptr %3, align 1, !dbg !235
  br label %23, !dbg !235

23:                                               ; preds = %15, %14
  %24 = load i1, ptr %3, align 1, !dbg !236
  ret i1 %24, !dbg !236
}

declare void @__VERIFIER_assume(i32 noundef) #5

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !237 {
  %1 = alloca i32, align 4
  %2 = alloca [2 x i64], align 16
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !240, metadata !DIExpression()), !dbg !246
  call void @llvm.dbg.declare(metadata ptr %3, metadata !247, metadata !DIExpression()), !dbg !248
  %6 = call noalias ptr @malloc(i64 noundef 16) #6, !dbg !249
  store ptr %6, ptr %3, align 8, !dbg !248
  %7 = load ptr, ptr %3, align 8, !dbg !250
  %8 = icmp eq ptr %7, null, !dbg !252
  br i1 %8, label %9, label %10, !dbg !253

9:                                                ; preds = %0
  call void @exit(i32 noundef 1) #7, !dbg !254
  unreachable, !dbg !254

10:                                               ; preds = %0
  %11 = load ptr, ptr %3, align 8, !dbg !256
  call void @ck_fifo_spsc_init(ptr noundef @queue, ptr noundef %11), !dbg !257
  %12 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 0, !dbg !258
  %13 = call i32 @pthread_create(ptr noundef %12, ptr noundef null, ptr noundef @producer, ptr noundef null) #8, !dbg !260
  %14 = icmp ne i32 %13, 0, !dbg !261
  br i1 %14, label %19, label %15, !dbg !262

15:                                               ; preds = %10
  %16 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 1, !dbg !263
  %17 = call i32 @pthread_create(ptr noundef %16, ptr noundef null, ptr noundef @consumer, ptr noundef null) #8, !dbg !264
  %18 = icmp ne i32 %17, 0, !dbg !265
  br i1 %18, label %19, label %20, !dbg !266

19:                                               ; preds = %15, %10
  call void @exit(i32 noundef 1) #7, !dbg !267
  unreachable, !dbg !267

20:                                               ; preds = %15
  call void @llvm.dbg.declare(metadata ptr %4, metadata !269, metadata !DIExpression()), !dbg !271
  store i32 0, ptr %4, align 4, !dbg !271
  br label %21, !dbg !272

21:                                               ; preds = %30, %20
  %22 = load i32, ptr %4, align 4, !dbg !273
  %23 = icmp slt i32 %22, 2, !dbg !275
  br i1 %23, label %24, label %33, !dbg !276

24:                                               ; preds = %21
  %25 = load i32, ptr %4, align 4, !dbg !277
  %26 = sext i32 %25 to i64, !dbg !279
  %27 = getelementptr inbounds [2 x i64], ptr %2, i64 0, i64 %26, !dbg !279
  %28 = load i64, ptr %27, align 8, !dbg !279
  %29 = call i32 @pthread_join(i64 noundef %28, ptr noundef null), !dbg !280
  br label %30, !dbg !281

30:                                               ; preds = %24
  %31 = load i32, ptr %4, align 4, !dbg !282
  %32 = add nsw i32 %31, 1, !dbg !282
  store i32 %32, ptr %4, align 4, !dbg !282
  br label %21, !dbg !283, !llvm.loop !284

33:                                               ; preds = %21
  call void @llvm.dbg.declare(metadata ptr %5, metadata !286, metadata !DIExpression()), !dbg !287
  call void @ck_fifo_spsc_deinit(ptr noundef @queue, ptr noundef %5), !dbg !288
  %34 = load ptr, ptr %5, align 8, !dbg !289
  call void @free(ptr noundef %34) #8, !dbg !290
  ret i32 0, !dbg !291
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_fifo_spsc_init(ptr noundef %0, ptr noundef %1) #0 !dbg !292 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !295, metadata !DIExpression()), !dbg !296
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !297, metadata !DIExpression()), !dbg !298
  %5 = load ptr, ptr %3, align 8, !dbg !299
  %6 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %5, i32 0, i32 0, !dbg !299
  call void @ck_spinlock_fas_init(ptr noundef %6), !dbg !299
  %7 = load ptr, ptr %3, align 8, !dbg !300
  %8 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %7, i32 0, i32 3, !dbg !300
  call void @ck_spinlock_fas_init(ptr noundef %8), !dbg !300
  %9 = load ptr, ptr %4, align 8, !dbg !301
  %10 = getelementptr inbounds %struct.ck_fifo_spsc_entry, ptr %9, i32 0, i32 1, !dbg !302
  store ptr null, ptr %10, align 8, !dbg !303
  %11 = load ptr, ptr %4, align 8, !dbg !304
  %12 = load ptr, ptr %3, align 8, !dbg !305
  %13 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %12, i32 0, i32 6, !dbg !306
  store ptr %11, ptr %13, align 8, !dbg !307
  %14 = load ptr, ptr %3, align 8, !dbg !308
  %15 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %14, i32 0, i32 5, !dbg !309
  store ptr %11, ptr %15, align 8, !dbg !310
  %16 = load ptr, ptr %3, align 8, !dbg !311
  %17 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %16, i32 0, i32 4, !dbg !312
  store ptr %11, ptr %17, align 8, !dbg !313
  %18 = load ptr, ptr %3, align 8, !dbg !314
  %19 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %18, i32 0, i32 1, !dbg !315
  store ptr %11, ptr %19, align 8, !dbg !316
  ret void, !dbg !317
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_fifo_spsc_deinit(ptr noundef %0, ptr noundef %1) #0 !dbg !318 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !322, metadata !DIExpression()), !dbg !323
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !324, metadata !DIExpression()), !dbg !325
  %5 = load ptr, ptr %3, align 8, !dbg !326
  %6 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %5, i32 0, i32 6, !dbg !327
  %7 = load ptr, ptr %6, align 8, !dbg !327
  %8 = load ptr, ptr %4, align 8, !dbg !328
  store ptr %7, ptr %8, align 8, !dbg !329
  %9 = load ptr, ptr %3, align 8, !dbg !330
  %10 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %9, i32 0, i32 4, !dbg !331
  store ptr null, ptr %10, align 8, !dbg !332
  %11 = load ptr, ptr %3, align 8, !dbg !333
  %12 = getelementptr inbounds %struct.ck_fifo_spsc, ptr %11, i32 0, i32 1, !dbg !334
  store ptr null, ptr %12, align 8, !dbg !335
  ret void, !dbg !336
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_store() #0 !dbg !337 {
  call void @ck_pr_barrier(), !dbg !341
  ret void, !dbg !341
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_ptr(ptr noundef %0, ptr noundef %1) #0 !dbg !342 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !348, metadata !DIExpression()), !dbg !349
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !350, metadata !DIExpression()), !dbg !349
  %5 = load ptr, ptr %3, align 8, !dbg !349
  %6 = load ptr, ptr %4, align 8, !dbg !349
  call void asm sideeffect "movq $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %5, ptr %6) #8, !dbg !349, !srcloc !351
  ret void, !dbg !349
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !352 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #8, !dbg !354, !srcloc !355
  ret void, !dbg !356
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_md_load_ptr(ptr noundef %0) #0 !dbg !357 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !360, metadata !DIExpression()), !dbg !361
  call void @llvm.dbg.declare(metadata ptr %3, metadata !362, metadata !DIExpression()), !dbg !361
  %4 = load ptr, ptr %2, align 8, !dbg !361
  %5 = call ptr asm sideeffect "movq $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %4) #8, !dbg !361, !srcloc !363
  store ptr %5, ptr %3, align 8, !dbg !361
  %6 = load ptr, ptr %3, align 8, !dbg !361
  ret ptr %6, !dbg !361
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_spinlock_fas_init(ptr noundef %0) #0 !dbg !364 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !368, metadata !DIExpression()), !dbg !369
  %3 = load ptr, ptr %2, align 8, !dbg !370
  %4 = getelementptr inbounds %struct.ck_spinlock_fas, ptr %3, i32 0, i32 0, !dbg !371
  store i32 0, ptr %4, align 4, !dbg !372
  call void @ck_pr_barrier(), !dbg !373
  ret void, !dbg !374
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind allocsize(0) }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!73, !74, !75, !76, !77, !78, !79}
!llvm.ident = !{!80}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "queue", scope: !2, file: !3, line: 21, type: !54, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !21, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/spsc_queue.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "7bec67ad4368bbed4d80bc0489a6ba84")
!4 = !{!5, !6, !7, !13, !19}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !9, line: 27, baseType: !10)
!9 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !11, line: 45, baseType: !12)
!11 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!12 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_fifo_spsc_entry", file: !15, line: 39, size: 128, elements: !16)
!15 = !DIFile(filename: "include/ck_fifo.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "252298fd696ccc816ddf53f92a49d2df")
!16 = !{!17, !18}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !14, file: !15, line: 40, baseType: !5, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !15, line: 41, baseType: !13, size: 64, offset: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !8)
!21 = !{!22, !28, !33, !38, !44, !49, !0}
!22 = !DIGlobalVariableExpression(var: !23, expr: !DIExpression())
!23 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !24, isLocal: true, isDefinition: true)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 160, elements: !26)
!25 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!26 = !{!27}
!27 = !DISubrange(count: 20)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !30, isLocal: true, isDefinition: true)
!30 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 312, elements: !31)
!31 = !{!32}
!32 = !DISubrange(count: 39)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !35, isLocal: true, isDefinition: true)
!35 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 152, elements: !36)
!36 = !{!37}
!37 = !DISubrange(count: 19)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(scope: null, file: !3, line: 63, type: !40, isLocal: true, isDefinition: true)
!40 = !DICompositeType(tag: DW_TAG_array_type, baseType: !41, size: 184, elements: !42)
!41 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !25)
!42 = !{!43}
!43 = !DISubrange(count: 23)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(scope: null, file: !3, line: 64, type: !46, isLocal: true, isDefinition: true)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 168, elements: !47)
!47 = !{!48}
!48 = !DISubrange(count: 21)
!49 = !DIGlobalVariableExpression(var: !50, expr: !DIExpression())
!50 = distinct !DIGlobalVariable(scope: null, file: !3, line: 65, type: !51, isLocal: true, isDefinition: true)
!51 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 112, elements: !52)
!52 = !{!53}
!53 = !DISubrange(count: 14)
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_fifo_spsc_t", file: !15, line: 54, baseType: !55)
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_fifo_spsc", file: !15, line: 45, size: 768, elements: !56)
!56 = !{!57, !64, !65, !69, !70, !71, !72}
!57 = !DIDerivedType(tag: DW_TAG_member, name: "m_head", scope: !55, file: !15, line: 46, baseType: !58, size: 32)
!58 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_spinlock_fas_t", file: !59, line: 42, baseType: !60)
!59 = !DIFile(filename: "include/spinlock/fas.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "999805093e3ea65ae15690fa7c76e04b")
!60 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_spinlock_fas", file: !59, line: 39, size: 32, elements: !61)
!61 = !{!62}
!62 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !60, file: !59, line: 40, baseType: !63, size: 32)
!63 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !55, file: !15, line: 47, baseType: !13, size: 64, offset: 64)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "pad", scope: !55, file: !15, line: 48, baseType: !66, size: 416, offset: 128)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 416, elements: !67)
!67 = !{!68}
!68 = !DISubrange(count: 52)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "m_tail", scope: !55, file: !15, line: 49, baseType: !58, size: 32, offset: 544)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "tail", scope: !55, file: !15, line: 50, baseType: !13, size: 64, offset: 576)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "head_snapshot", scope: !55, file: !15, line: 51, baseType: !13, size: 64, offset: 640)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "garbage", scope: !55, file: !15, line: 52, baseType: !13, size: 64, offset: 704)
!73 = !{i32 7, !"Dwarf Version", i32 5}
!74 = !{i32 2, !"Debug Info Version", i32 3}
!75 = !{i32 1, !"wchar_size", i32 4}
!76 = !{i32 8, !"PIC Level", i32 2}
!77 = !{i32 7, !"PIE Level", i32 2}
!78 = !{i32 7, !"uwtable", i32 2}
!79 = !{i32 7, !"frame-pointer", i32 2}
!80 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!81 = distinct !DISubprogram(name: "producer", scope: !3, file: !3, line: 23, type: !82, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !84)
!82 = !DISubroutineType(types: !83)
!83 = !{!5, !5}
!84 = !{}
!85 = !DILocalVariable(name: "arg", arg: 1, scope: !81, file: !3, line: 23, type: !5)
!86 = !DILocation(line: 23, column: 22, scope: !81)
!87 = !DILocalVariable(name: "i", scope: !88, file: !3, line: 25, type: !89)
!88 = distinct !DILexicalBlock(scope: !81, file: !3, line: 25, column: 5)
!89 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!90 = !DILocation(line: 25, column: 14, scope: !88)
!91 = !DILocation(line: 25, column: 10, scope: !88)
!92 = !DILocation(line: 25, column: 21, scope: !93)
!93 = distinct !DILexicalBlock(scope: !88, file: !3, line: 25, column: 5)
!94 = !DILocation(line: 25, column: 23, scope: !93)
!95 = !DILocation(line: 25, column: 5, scope: !88)
!96 = !DILocalVariable(name: "point", scope: !97, file: !3, line: 27, type: !98)
!97 = distinct !DILexicalBlock(scope: !93, file: !3, line: 26, column: 5)
!98 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "point_t", file: !3, line: 19, baseType: !100)
!100 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "point_s", file: !3, line: 15, size: 64, elements: !101)
!101 = !{!102, !103}
!102 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !100, file: !3, line: 17, baseType: !63, size: 32)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "y", scope: !100, file: !3, line: 18, baseType: !63, size: 32, offset: 32)
!104 = !DILocation(line: 27, column: 18, scope: !97)
!105 = !DILocation(line: 27, column: 26, scope: !97)
!106 = !DILocation(line: 28, column: 13, scope: !107)
!107 = distinct !DILexicalBlock(scope: !97, file: !3, line: 28, column: 13)
!108 = !DILocation(line: 28, column: 19, scope: !107)
!109 = !DILocation(line: 28, column: 13, scope: !97)
!110 = !DILocation(line: 30, column: 13, scope: !111)
!111 = distinct !DILexicalBlock(scope: !107, file: !3, line: 29, column: 9)
!112 = !DILocation(line: 33, column: 9, scope: !97)
!113 = !DILocation(line: 33, column: 16, scope: !97)
!114 = !DILocation(line: 33, column: 18, scope: !97)
!115 = !DILocation(line: 34, column: 9, scope: !97)
!116 = !DILocation(line: 34, column: 16, scope: !97)
!117 = !DILocation(line: 34, column: 18, scope: !97)
!118 = !DILocalVariable(name: "entry", scope: !97, file: !3, line: 36, type: !119)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_fifo_spsc_entry_t", file: !15, line: 43, baseType: !14)
!121 = !DILocation(line: 36, column: 31, scope: !97)
!122 = !DILocation(line: 36, column: 39, scope: !97)
!123 = !DILocation(line: 37, column: 13, scope: !124)
!124 = distinct !DILexicalBlock(scope: !97, file: !3, line: 37, column: 13)
!125 = !DILocation(line: 37, column: 19, scope: !124)
!126 = !DILocation(line: 37, column: 13, scope: !97)
!127 = !DILocation(line: 39, column: 18, scope: !128)
!128 = distinct !DILexicalBlock(scope: !124, file: !3, line: 38, column: 9)
!129 = !DILocation(line: 39, column: 13, scope: !128)
!130 = !DILocation(line: 40, column: 13, scope: !128)
!131 = !DILocation(line: 43, column: 38, scope: !97)
!132 = !DILocation(line: 43, column: 45, scope: !97)
!133 = !DILocation(line: 43, column: 9, scope: !97)
!134 = !DILocation(line: 44, column: 5, scope: !97)
!135 = !DILocation(line: 25, column: 45, scope: !93)
!136 = !DILocation(line: 25, column: 5, scope: !93)
!137 = distinct !{!137, !95, !138, !139}
!138 = !DILocation(line: 44, column: 5, scope: !88)
!139 = !{!"llvm.loop.mustprogress"}
!140 = !DILocalVariable(name: "entry", scope: !81, file: !3, line: 46, type: !119)
!141 = !DILocation(line: 46, column: 27, scope: !81)
!142 = !DILocation(line: 46, column: 35, scope: !81)
!143 = !DILocation(line: 47, column: 9, scope: !144)
!144 = distinct !DILexicalBlock(scope: !81, file: !3, line: 47, column: 9)
!145 = !DILocation(line: 47, column: 15, scope: !144)
!146 = !DILocation(line: 47, column: 9, scope: !81)
!147 = !DILocation(line: 49, column: 9, scope: !148)
!148 = distinct !DILexicalBlock(scope: !144, file: !3, line: 48, column: 5)
!149 = !DILocation(line: 51, column: 34, scope: !81)
!150 = !DILocation(line: 51, column: 5, scope: !81)
!151 = !DILocation(line: 53, column: 5, scope: !81)
!152 = distinct !DISubprogram(name: "ck_fifo_spsc_enqueue", scope: !15, file: !15, line: 124, type: !153, scopeLine: 127, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!153 = !DISubroutineType(types: !154)
!154 = !{null, !155, !13, !5}
!155 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!156 = !DILocalVariable(name: "fifo", arg: 1, scope: !152, file: !15, line: 124, type: !155)
!157 = !DILocation(line: 124, column: 43, scope: !152)
!158 = !DILocalVariable(name: "entry", arg: 2, scope: !152, file: !15, line: 125, type: !13)
!159 = !DILocation(line: 125, column: 35, scope: !152)
!160 = !DILocalVariable(name: "value", arg: 3, scope: !152, file: !15, line: 126, type: !5)
!161 = !DILocation(line: 126, column: 14, scope: !152)
!162 = !DILocation(line: 129, column: 17, scope: !152)
!163 = !DILocation(line: 129, column: 2, scope: !152)
!164 = !DILocation(line: 129, column: 9, scope: !152)
!165 = !DILocation(line: 129, column: 15, scope: !152)
!166 = !DILocation(line: 130, column: 2, scope: !152)
!167 = !DILocation(line: 130, column: 9, scope: !152)
!168 = !DILocation(line: 130, column: 14, scope: !152)
!169 = !DILocation(line: 133, column: 2, scope: !152)
!170 = !DILocation(line: 134, column: 2, scope: !152)
!171 = !DILocation(line: 135, column: 15, scope: !152)
!172 = !DILocation(line: 135, column: 2, scope: !152)
!173 = !DILocation(line: 135, column: 8, scope: !152)
!174 = !DILocation(line: 135, column: 13, scope: !152)
!175 = !DILocation(line: 136, column: 2, scope: !152)
!176 = distinct !DISubprogram(name: "consumer", scope: !3, file: !3, line: 55, type: !82, scopeLine: 56, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !84)
!177 = !DILocalVariable(name: "arg", arg: 1, scope: !176, file: !3, line: 55, type: !5)
!178 = !DILocation(line: 55, column: 22, scope: !176)
!179 = !DILocalVariable(name: "point", scope: !176, file: !3, line: 57, type: !98)
!180 = !DILocation(line: 57, column: 14, scope: !176)
!181 = !DILocalVariable(name: "i", scope: !182, file: !3, line: 59, type: !89)
!182 = distinct !DILexicalBlock(scope: !176, file: !3, line: 59, column: 5)
!183 = !DILocation(line: 59, column: 14, scope: !182)
!184 = !DILocation(line: 59, column: 10, scope: !182)
!185 = !DILocation(line: 59, column: 21, scope: !186)
!186 = distinct !DILexicalBlock(scope: !182, file: !3, line: 59, column: 5)
!187 = !DILocation(line: 59, column: 23, scope: !186)
!188 = !DILocation(line: 59, column: 5, scope: !182)
!189 = !DILocalVariable(name: "res", scope: !190, file: !3, line: 61, type: !191)
!190 = distinct !DILexicalBlock(scope: !186, file: !3, line: 60, column: 5)
!191 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!192 = !DILocation(line: 61, column: 14, scope: !190)
!193 = !DILocation(line: 61, column: 20, scope: !190)
!194 = !DILocation(line: 62, column: 27, scope: !190)
!195 = !DILocation(line: 62, column: 9, scope: !190)
!196 = !DILocation(line: 63, column: 9, scope: !197)
!197 = distinct !DILexicalBlock(scope: !198, file: !3, line: 63, column: 9)
!198 = distinct !DILexicalBlock(scope: !190, file: !3, line: 63, column: 9)
!199 = !DILocation(line: 63, column: 9, scope: !198)
!200 = !DILocation(line: 64, column: 9, scope: !201)
!201 = distinct !DILexicalBlock(scope: !202, file: !3, line: 64, column: 9)
!202 = distinct !DILexicalBlock(scope: !190, file: !3, line: 64, column: 9)
!203 = !DILocation(line: 64, column: 9, scope: !202)
!204 = !DILocation(line: 65, column: 9, scope: !205)
!205 = distinct !DILexicalBlock(scope: !206, file: !3, line: 65, column: 9)
!206 = distinct !DILexicalBlock(scope: !190, file: !3, line: 65, column: 9)
!207 = !DILocation(line: 65, column: 9, scope: !206)
!208 = !DILocation(line: 67, column: 14, scope: !190)
!209 = !DILocation(line: 67, column: 9, scope: !190)
!210 = !DILocation(line: 68, column: 5, scope: !190)
!211 = !DILocation(line: 59, column: 45, scope: !186)
!212 = !DILocation(line: 59, column: 5, scope: !186)
!213 = distinct !{!213, !188, !214, !139}
!214 = !DILocation(line: 68, column: 5, scope: !182)
!215 = !DILocation(line: 70, column: 5, scope: !176)
!216 = distinct !DISubprogram(name: "ck_fifo_spsc_dequeue", scope: !15, file: !15, line: 140, type: !217, scopeLine: 141, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!217 = !DISubroutineType(types: !218)
!218 = !{!191, !155, !5}
!219 = !DILocalVariable(name: "fifo", arg: 1, scope: !216, file: !15, line: 140, type: !155)
!220 = !DILocation(line: 140, column: 43, scope: !216)
!221 = !DILocalVariable(name: "value", arg: 2, scope: !216, file: !15, line: 140, type: !5)
!222 = !DILocation(line: 140, column: 55, scope: !216)
!223 = !DILocalVariable(name: "entry", scope: !216, file: !15, line: 142, type: !13)
!224 = !DILocation(line: 142, column: 29, scope: !216)
!225 = !DILocation(line: 149, column: 10, scope: !216)
!226 = !DILocation(line: 149, column: 8, scope: !216)
!227 = !DILocation(line: 150, column: 6, scope: !228)
!228 = distinct !DILexicalBlock(scope: !216, file: !15, line: 150, column: 6)
!229 = !DILocation(line: 150, column: 12, scope: !228)
!230 = !DILocation(line: 150, column: 6, scope: !216)
!231 = !DILocation(line: 151, column: 3, scope: !228)
!232 = !DILocation(line: 154, column: 2, scope: !216)
!233 = !DILocation(line: 155, column: 2, scope: !216)
!234 = !DILocation(line: 156, column: 2, scope: !216)
!235 = !DILocation(line: 157, column: 2, scope: !216)
!236 = !DILocation(line: 158, column: 1, scope: !216)
!237 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 73, type: !238, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !84)
!238 = !DISubroutineType(types: !239)
!239 = !{!89}
!240 = !DILocalVariable(name: "threads", scope: !237, file: !3, line: 75, type: !241)
!241 = !DICompositeType(tag: DW_TAG_array_type, baseType: !242, size: 128, elements: !244)
!242 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !243, line: 27, baseType: !12)
!243 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!244 = !{!245}
!245 = !DISubrange(count: 2)
!246 = !DILocation(line: 75, column: 15, scope: !237)
!247 = !DILocalVariable(name: "initial_entry", scope: !237, file: !3, line: 77, type: !119)
!248 = !DILocation(line: 77, column: 27, scope: !237)
!249 = !DILocation(line: 77, column: 43, scope: !237)
!250 = !DILocation(line: 78, column: 9, scope: !251)
!251 = distinct !DILexicalBlock(scope: !237, file: !3, line: 78, column: 9)
!252 = !DILocation(line: 78, column: 23, scope: !251)
!253 = !DILocation(line: 78, column: 9, scope: !237)
!254 = !DILocation(line: 80, column: 9, scope: !255)
!255 = distinct !DILexicalBlock(scope: !251, file: !3, line: 79, column: 5)
!256 = !DILocation(line: 82, column: 31, scope: !237)
!257 = !DILocation(line: 82, column: 5, scope: !237)
!258 = !DILocation(line: 84, column: 25, scope: !259)
!259 = distinct !DILexicalBlock(scope: !237, file: !3, line: 84, column: 9)
!260 = !DILocation(line: 84, column: 9, scope: !259)
!261 = !DILocation(line: 84, column: 59, scope: !259)
!262 = !DILocation(line: 84, column: 64, scope: !259)
!263 = !DILocation(line: 85, column: 25, scope: !259)
!264 = !DILocation(line: 85, column: 9, scope: !259)
!265 = !DILocation(line: 85, column: 59, scope: !259)
!266 = !DILocation(line: 84, column: 9, scope: !237)
!267 = !DILocation(line: 87, column: 9, scope: !268)
!268 = distinct !DILexicalBlock(scope: !259, file: !3, line: 86, column: 5)
!269 = !DILocalVariable(name: "i", scope: !270, file: !3, line: 90, type: !89)
!270 = distinct !DILexicalBlock(scope: !237, file: !3, line: 90, column: 5)
!271 = !DILocation(line: 90, column: 14, scope: !270)
!272 = !DILocation(line: 90, column: 10, scope: !270)
!273 = !DILocation(line: 90, column: 21, scope: !274)
!274 = distinct !DILexicalBlock(scope: !270, file: !3, line: 90, column: 5)
!275 = !DILocation(line: 90, column: 23, scope: !274)
!276 = !DILocation(line: 90, column: 5, scope: !270)
!277 = !DILocation(line: 92, column: 30, scope: !278)
!278 = distinct !DILexicalBlock(scope: !274, file: !3, line: 91, column: 5)
!279 = !DILocation(line: 92, column: 22, scope: !278)
!280 = !DILocation(line: 92, column: 9, scope: !278)
!281 = !DILocation(line: 93, column: 5, scope: !278)
!282 = !DILocation(line: 90, column: 36, scope: !274)
!283 = !DILocation(line: 90, column: 5, scope: !274)
!284 = distinct !{!284, !276, !285, !139}
!285 = !DILocation(line: 93, column: 5, scope: !270)
!286 = !DILocalVariable(name: "garbage", scope: !237, file: !3, line: 95, type: !119)
!287 = !DILocation(line: 95, column: 27, scope: !237)
!288 = !DILocation(line: 96, column: 5, scope: !237)
!289 = !DILocation(line: 97, column: 10, scope: !237)
!290 = !DILocation(line: 97, column: 5, scope: !237)
!291 = !DILocation(line: 99, column: 5, scope: !237)
!292 = distinct !DISubprogram(name: "ck_fifo_spsc_init", scope: !15, file: !15, line: 103, type: !293, scopeLine: 104, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!293 = !DISubroutineType(types: !294)
!294 = !{null, !155, !13}
!295 = !DILocalVariable(name: "fifo", arg: 1, scope: !292, file: !15, line: 103, type: !155)
!296 = !DILocation(line: 103, column: 40, scope: !292)
!297 = !DILocalVariable(name: "stub", arg: 2, scope: !292, file: !15, line: 103, type: !13)
!298 = !DILocation(line: 103, column: 73, scope: !292)
!299 = !DILocation(line: 106, column: 2, scope: !292)
!300 = !DILocation(line: 107, column: 2, scope: !292)
!301 = !DILocation(line: 109, column: 2, scope: !292)
!302 = !DILocation(line: 109, column: 8, scope: !292)
!303 = !DILocation(line: 109, column: 13, scope: !292)
!304 = !DILocation(line: 110, column: 66, scope: !292)
!305 = !DILocation(line: 110, column: 50, scope: !292)
!306 = !DILocation(line: 110, column: 56, scope: !292)
!307 = !DILocation(line: 110, column: 64, scope: !292)
!308 = !DILocation(line: 110, column: 28, scope: !292)
!309 = !DILocation(line: 110, column: 34, scope: !292)
!310 = !DILocation(line: 110, column: 48, scope: !292)
!311 = !DILocation(line: 110, column: 15, scope: !292)
!312 = !DILocation(line: 110, column: 21, scope: !292)
!313 = !DILocation(line: 110, column: 26, scope: !292)
!314 = !DILocation(line: 110, column: 2, scope: !292)
!315 = !DILocation(line: 110, column: 8, scope: !292)
!316 = !DILocation(line: 110, column: 13, scope: !292)
!317 = !DILocation(line: 111, column: 2, scope: !292)
!318 = distinct !DISubprogram(name: "ck_fifo_spsc_deinit", scope: !15, file: !15, line: 115, type: !319, scopeLine: 116, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!319 = !DISubroutineType(types: !320)
!320 = !{null, !155, !321}
!321 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!322 = !DILocalVariable(name: "fifo", arg: 1, scope: !318, file: !15, line: 115, type: !155)
!323 = !DILocation(line: 115, column: 42, scope: !318)
!324 = !DILocalVariable(name: "garbage", arg: 2, scope: !318, file: !15, line: 115, type: !321)
!325 = !DILocation(line: 115, column: 76, scope: !318)
!326 = !DILocation(line: 118, column: 13, scope: !318)
!327 = !DILocation(line: 118, column: 19, scope: !318)
!328 = !DILocation(line: 118, column: 3, scope: !318)
!329 = !DILocation(line: 118, column: 11, scope: !318)
!330 = !DILocation(line: 119, column: 15, scope: !318)
!331 = !DILocation(line: 119, column: 21, scope: !318)
!332 = !DILocation(line: 119, column: 26, scope: !318)
!333 = !DILocation(line: 119, column: 2, scope: !318)
!334 = !DILocation(line: 119, column: 8, scope: !318)
!335 = !DILocation(line: 119, column: 13, scope: !318)
!336 = !DILocation(line: 120, column: 2, scope: !318)
!337 = distinct !DISubprogram(name: "ck_pr_fence_store", scope: !338, file: !338, line: 157, type: !339, scopeLine: 157, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!338 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!339 = !DISubroutineType(types: !340)
!340 = !{null}
!341 = !DILocation(line: 157, column: 1, scope: !337)
!342 = distinct !DISubprogram(name: "ck_pr_md_store_ptr", scope: !343, file: !343, line: 267, type: !344, scopeLine: 267, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!343 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!344 = !DISubroutineType(types: !345)
!345 = !{null, !5, !346}
!346 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !347, size: 64)
!347 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!348 = !DILocalVariable(name: "target", arg: 1, scope: !342, file: !343, line: 267, type: !5)
!349 = !DILocation(line: 267, column: 1, scope: !342)
!350 = !DILocalVariable(name: "v", arg: 2, scope: !342, file: !343, line: 267, type: !346)
!351 = !{i64 2148009299}
!352 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !353, file: !353, line: 37, type: !339, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!353 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!354 = !DILocation(line: 40, column: 2, scope: !352)
!355 = !{i64 612254}
!356 = !DILocation(line: 41, column: 2, scope: !352)
!357 = distinct !DISubprogram(name: "ck_pr_md_load_ptr", scope: !343, file: !343, line: 185, type: !358, scopeLine: 185, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!358 = !DISubroutineType(types: !359)
!359 = !{!5, !346}
!360 = !DILocalVariable(name: "target", arg: 1, scope: !357, file: !343, line: 185, type: !346)
!361 = !DILocation(line: 185, column: 1, scope: !357)
!362 = !DILocalVariable(name: "r", scope: !357, file: !343, line: 185, type: !5)
!363 = !{i64 2148003955}
!364 = distinct !DISubprogram(name: "ck_spinlock_fas_init", scope: !59, file: !59, line: 47, type: !365, scopeLine: 48, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !84)
!365 = !DISubroutineType(types: !366)
!366 = !{null, !367}
!367 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!368 = !DILocalVariable(name: "lock", arg: 1, scope: !364, file: !59, line: 47, type: !367)
!369 = !DILocation(line: 47, column: 46, scope: !364)
!370 = !DILocation(line: 50, column: 2, scope: !364)
!371 = !DILocation(line: 50, column: 8, scope: !364)
!372 = !DILocation(line: 50, column: 14, scope: !364)
!373 = !DILocation(line: 51, column: 2, scope: !364)
!374 = !DILocation(line: 52, column: 2, scope: !364)
