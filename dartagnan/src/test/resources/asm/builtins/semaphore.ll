; ModuleID = './test/spinlock/semaphore.c'
source_filename = "./test/spinlock/semaphore.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%struct.semaphore_s = type { %struct.vatomic32_s }
%struct.vatomic32_s = type { i32 }

@g_cs_x = internal global i32 0, align 4
@g_cs_y = internal global i32 0, align 4
@.str = private unnamed_addr constant [25 x i8] c"g_cs_x and g_cs_y differ\00", align 1
@__func__.reader_cs = private unnamed_addr constant [10 x i8] c"reader_cs\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"reader_writer.h\00", align 1
@.str.2 = private unnamed_addr constant [32 x i8] c"a && \22g_cs_x and g_cs_y differ\22\00", align 1
@__func__.check = private unnamed_addr constant [6 x i8] c"check\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"g_cs_x == g_cs_y\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"g_cs_x == 2\00", align 1
@g_semaphore = global %struct.semaphore_s zeroinitializer, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @post() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @fini() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @writer_cs(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  br label %3

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %3
  %5 = load i32, ptr %2, align 4
  br label %6

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  %10 = load i32, ptr @g_cs_x, align 4
  %11 = add i32 %10, 1
  store i32 %11, ptr @g_cs_x, align 4
  %12 = load i32, ptr @g_cs_y, align 4
  %13 = add i32 %12, 1
  store i32 %13, ptr @g_cs_y, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @reader_cs(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  br label %4

4:                                                ; preds = %1
  br label %5

5:                                                ; preds = %4
  %6 = load i32, ptr %2, align 4
  br label %7

7:                                                ; preds = %5
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  br label %10

10:                                               ; preds = %9
  %11 = load i32, ptr @g_cs_x, align 4
  %12 = load i32, ptr @g_cs_y, align 4
  %13 = icmp eq i32 %11, %12
  %14 = zext i1 %13 to i32
  store i32 %14, ptr %3, align 4
  %15 = load i32, ptr %3, align 4
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %18

17:                                               ; preds = %10
  br label %18

18:                                               ; preds = %17, %10
  %19 = phi i1 [ false, %10 ], [ true, %17 ]
  %20 = xor i1 %19, true
  %21 = zext i1 %20 to i32
  %22 = sext i32 %21 to i64
  %23 = icmp ne i64 %22, 0
  br i1 %23, label %24, label %26

24:                                               ; preds = %18
  call void @__assert_rtn(ptr noundef @__func__.reader_cs, ptr noundef @.str.1, i32 noundef 130, ptr noundef @.str.2) #3
  unreachable

25:                                               ; No predecessors!
  br label %27

26:                                               ; preds = %18
  br label %27

27:                                               ; preds = %26, %25
  ret void
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @check() #0 {
  %1 = load i32, ptr @g_cs_x, align 4
  %2 = load i32, ptr @g_cs_y, align 4
  %3 = icmp eq i32 %1, %2
  %4 = xor i1 %3, true
  %5 = zext i1 %4 to i32
  %6 = sext i32 %5 to i64
  %7 = icmp ne i64 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.check, ptr noundef @.str.1, i32 noundef 135, ptr noundef @.str.3) #3
  unreachable

9:                                                ; No predecessors!
  br label %11

10:                                               ; preds = %0
  br label %11

11:                                               ; preds = %10, %9
  %12 = load i32, ptr @g_cs_x, align 4
  %13 = icmp eq i32 %12, 2
  %14 = xor i1 %13, true
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %20

18:                                               ; preds = %11
  call void @__assert_rtn(ptr noundef @__func__.check, ptr noundef @.str.1, i32 noundef 136, ptr noundef @.str.4) #3
  unreachable

19:                                               ; No predecessors!
  br label %21

20:                                               ; preds = %11
  br label %21

21:                                               ; preds = %20, %19
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [3 x ptr], align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  call void @init()
  call void @verification_loop_bound(i32 noundef 3)
  store i64 0, ptr %3, align 8
  br label %6

6:                                                ; preds = %15, %0
  %7 = load i64, ptr %3, align 8
  %8 = icmp ult i64 %7, 2
  br i1 %8, label %9, label %18

9:                                                ; preds = %6
  %10 = load i64, ptr %3, align 8
  %11 = getelementptr inbounds [3 x ptr], ptr %2, i64 0, i64 %10
  %12 = load i64, ptr %3, align 8
  %13 = inttoptr i64 %12 to ptr
  %14 = call i32 @pthread_create(ptr noundef %11, ptr noundef null, ptr noundef @writer, ptr noundef %13)
  br label %15

15:                                               ; preds = %9
  %16 = load i64, ptr %3, align 8
  %17 = add i64 %16, 1
  store i64 %17, ptr %3, align 8
  br label %6, !llvm.loop !6

18:                                               ; preds = %6
  call void @verification_loop_bound(i32 noundef 4)
  store i64 2, ptr %4, align 8
  br label %19

19:                                               ; preds = %28, %18
  %20 = load i64, ptr %4, align 8
  %21 = icmp ult i64 %20, 3
  br i1 %21, label %22, label %31

22:                                               ; preds = %19
  %23 = load i64, ptr %4, align 8
  %24 = getelementptr inbounds [3 x ptr], ptr %2, i64 0, i64 %23
  %25 = load i64, ptr %4, align 8
  %26 = inttoptr i64 %25 to ptr
  %27 = call i32 @pthread_create(ptr noundef %24, ptr noundef null, ptr noundef @reader, ptr noundef %26)
  br label %28

28:                                               ; preds = %22
  %29 = load i64, ptr %4, align 8
  %30 = add i64 %29, 1
  store i64 %30, ptr %4, align 8
  br label %19, !llvm.loop !8

31:                                               ; preds = %19
  call void @post()
  call void @verification_loop_bound(i32 noundef 4)
  store i64 0, ptr %5, align 8
  br label %32

32:                                               ; preds = %40, %31
  %33 = load i64, ptr %5, align 8
  %34 = icmp ult i64 %33, 3
  br i1 %34, label %35, label %43

35:                                               ; preds = %32
  %36 = load i64, ptr %5, align 8
  %37 = getelementptr inbounds [3 x ptr], ptr %2, i64 0, i64 %36
  %38 = load ptr, ptr %37, align 8
  %39 = call i32 @"\01_pthread_join"(ptr noundef %38, ptr noundef null)
  br label %40

40:                                               ; preds = %35
  %41 = load i64, ptr %5, align 8
  %42 = add i64 %41, 1
  store i64 %42, ptr %5, align 8
  br label %32, !llvm.loop !9

43:                                               ; preds = %32
  call void @check()
  call void @fini()
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @init() #0 {
  call void @semaphore_init(ptr noundef @g_semaphore, i32 noundef 3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @verification_loop_bound(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  ret void
}

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal ptr @writer(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = ptrtoint ptr %4 to i64
  %6 = trunc i64 %5 to i32
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  call void @writer_acquire(i32 noundef %7)
  %8 = load i32, ptr %3, align 4
  call void @writer_cs(i32 noundef %8)
  %9 = load i32, ptr %3, align 4
  call void @writer_release(i32 noundef %9)
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal ptr @reader(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = ptrtoint ptr %4 to i64
  %6 = trunc i64 %5 to i32
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  call void @reader_acquire(i32 noundef %7)
  %8 = load i32, ptr %3, align 4
  call void @reader_cs(i32 noundef %8)
  %9 = load i32, ptr %3, align 4
  call void @reader_release(i32 noundef %9)
  ret ptr null
}

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @semaphore_init(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.semaphore_s, ptr %5, i32 0, i32 0
  %7 = load i32, ptr %4, align 4
  call void @vatomic32_write(ptr noundef %6, i32 noundef %7)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @writer_acquire(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  br label %3

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %3
  %5 = load i32, ptr %2, align 4
  br label %6

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  call void @semaphore_acquire(ptr noundef @g_semaphore, i32 noundef 3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @semaphore_acquire(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.semaphore_s, ptr %5, i32 0, i32 0
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  %9 = call i32 @vatomic32_await_ge_sub_acq(ptr noundef %6, i32 noundef %7, i32 noundef %8)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @writer_release(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  br label %3

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %3
  %5 = load i32, ptr %2, align 4
  br label %6

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  call void @semaphore_release(ptr noundef @g_semaphore, i32 noundef 3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @semaphore_release(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.semaphore_s, ptr %5, i32 0, i32 0
  %7 = load i32, ptr %4, align 4
  call void @vatomic32_add_rel(ptr noundef %6, i32 noundef %7)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @reader_acquire(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  br label %3

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %3
  %5 = load i32, ptr %2, align 4
  br label %6

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  call void @semaphore_acquire(ptr noundef @g_semaphore, i32 noundef 1)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @reader_release(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  br label %3

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %3
  %5 = load i32, ptr %2, align 4
  br label %6

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  call void @semaphore_release(ptr noundef @g_semaphore, i32 noundef 1)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vatomic32_write(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !10
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.vatomic32_s, ptr %6, i32 0, i32 0
  %8 = load i32, ptr %4, align 4
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  store atomic i32 %9, ptr %7 seq_cst, align 4
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_await_ge_sub_acq(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  %9 = load ptr, ptr %4, align 8
  %10 = call i32 @vatomic32_read_rlx(ptr noundef %9)
  store i32 %10, ptr %8, align 4
  br label %11

11:                                               ; preds = %23, %3
  %12 = load i32, ptr %8, align 4
  store i32 %12, ptr %7, align 4
  br label %13

13:                                               ; preds = %18, %11
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  %16 = icmp uge i32 %14, %15
  %17 = xor i1 %16, true
  br i1 %17, label %18, label %22

18:                                               ; preds = %13
  %19 = load ptr, ptr %4, align 8
  %20 = load i32, ptr %7, align 4
  %21 = call i32 @vatomic32_await_neq_rlx(ptr noundef %19, i32 noundef %20)
  store i32 %21, ptr %7, align 4
  br label %13, !llvm.loop !12

22:                                               ; preds = %13
  br label %23

23:                                               ; preds = %22
  %24 = load ptr, ptr %4, align 8
  %25 = load i32, ptr %7, align 4
  %26 = load i32, ptr %7, align 4
  %27 = load i32, ptr %6, align 4
  %28 = sub i32 %26, %27
  %29 = call i32 @vatomic32_cmpxchg_acq(ptr noundef %24, i32 noundef %25, i32 noundef %28)
  store i32 %29, ptr %8, align 4
  %30 = load i32, ptr %7, align 4
  %31 = icmp ne i32 %29, %30
  br i1 %31, label %11, label %32, !llvm.loop !13

32:                                               ; preds = %23
  %33 = load i32, ptr %8, align 4
  ret i32 %33
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_read_rlx(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !14
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.vatomic32_s, ptr %5, i32 0, i32 0
  %7 = load atomic i32, ptr %6 monotonic, align 4
  store i32 %7, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  store i32 %8, ptr %3, align 4
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !15
  %9 = load i32, ptr %3, align 4
  ret i32 %9
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_await_neq_rlx(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  call void @verification_loop_begin()
  br label %6

6:                                                ; preds = %20, %2
  call void @verification_spin_start()
  %7 = load ptr, ptr %3, align 8
  %8 = call i32 @vatomic32_read_rlx(ptr noundef %7)
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %4, align 4
  %11 = icmp eq i32 %9, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %6
  br label %14

13:                                               ; preds = %6
  call void @verification_spin_end(i32 noundef 1)
  br label %14

14:                                               ; preds = %13, %12
  %15 = phi i32 [ 1, %12 ], [ 0, %13 ]
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %17, label %21

17:                                               ; preds = %14
  br label %18

18:                                               ; preds = %17
  br label %19

19:                                               ; preds = %18
  br label %20

20:                                               ; preds = %19
  call void @verification_spin_end(i32 noundef 0)
  br label %6, !llvm.loop !16

21:                                               ; preds = %14
  %22 = load i32, ptr %5, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_cmpxchg_acq(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %10 = load i32, ptr %5, align 4
  store i32 %10, ptr %7, align 4
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !17
  %11 = load ptr, ptr %4, align 8
  %12 = getelementptr inbounds %struct.vatomic32_s, ptr %11, i32 0, i32 0
  %13 = load i32, ptr %6, align 4
  store i32 %13, ptr %8, align 4
  %14 = load i32, ptr %7, align 4
  %15 = load i32, ptr %8, align 4
  %16 = cmpxchg ptr %12, i32 %14, i32 %15 acquire acquire, align 4
  %17 = extractvalue { i32, i1 } %16, 0
  %18 = extractvalue { i32, i1 } %16, 1
  br i1 %18, label %20, label %19

19:                                               ; preds = %3
  store i32 %17, ptr %7, align 4
  br label %20

20:                                               ; preds = %19, %3
  %21 = zext i1 %18 to i8
  store i8 %21, ptr %9, align 1
  %22 = load i8, ptr %9, align 1
  %23 = trunc i8 %22 to i1
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !18
  %24 = load i32, ptr %7, align 4
  ret i32 %24
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @verification_loop_begin() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @verification_spin_start() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @verification_spin_end(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vatomic32_add_rel(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %5 = load ptr, ptr %3, align 8
  %6 = load i32, ptr %4, align 4
  %7 = call i32 @vatomic32_get_add_rel(ptr noundef %5, i32 noundef %6)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_get_add_rel(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !19
  %8 = load ptr, ptr %3, align 8
  %9 = getelementptr inbounds %struct.vatomic32_s, ptr %8, i32 0, i32 0
  %10 = load i32, ptr %4, align 4
  store i32 %10, ptr %6, align 4
  %11 = load i32, ptr %6, align 4
  %12 = atomicrmw add ptr %9, i32 %11 release, align 4
  store i32 %12, ptr %7, align 4
  %13 = load i32, ptr %7, align 4
  store i32 %13, ptr %5, align 4
  call void asm sideeffect "", "~{memory}"() #4, !srcloc !20
  %14 = load i32, ptr %5, align 4
  ret i32 %14
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #3 = { cold noreturn }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 19.1.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = !{i64 2148481037}
!11 = !{i64 2148481077}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = !{i64 2148479789}
!15 = !{i64 2148479829}
!16 = distinct !{!16, !7}
!17 = !{i64 2148484565}
!18 = !{i64 2148484607}
!19 = !{i64 2148491225}
!20 = !{i64 2148491265}
