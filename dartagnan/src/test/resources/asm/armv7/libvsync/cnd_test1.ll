; ModuleID = 'test/thread/cnd_test1.c'
source_filename = "test/thread/cnd_test1.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%struct._opaque_pthread_mutex_t = type { i64, [56 x i8] }
%struct.vcond_s = type { %struct.vatomic32_s }
%struct.vatomic32_s = type { i32 }
%struct.run_info_t = type { ptr, i64, i8, ptr }

@g_mutex = global %struct._opaque_pthread_mutex_t zeroinitializer, align 8
@g_cs_x = global i32 0, align 4
@g_cond = global %struct.vcond_s zeroinitializer, align 4
@g_cs_y = global i32 0, align 4
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str = private unnamed_addr constant [12 x i8] c"cnd_test1.c\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"g_cs_x == 2\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"g_cs_y == -1\00", align 1
@sig = internal global %struct.vatomic32_s zeroinitializer, align 4

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define ptr @run(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @vmutex_acquire(ptr noundef @g_mutex)
  %3 = load i32, ptr @g_cs_x, align 4
  %4 = add nsw i32 %3, 1
  store i32 %4, ptr @g_cs_x, align 4
  %5 = icmp slt i32 %3, 1
  br i1 %5, label %6, label %14

6:                                                ; preds = %1
  br label %7

7:                                                ; preds = %10, %6
  %8 = load i32, ptr @g_cs_x, align 4
  %9 = icmp ne i32 %8, 2
  br i1 %9, label %10, label %11

10:                                               ; preds = %7
  call void @vcond_wait(ptr noundef @g_cond, ptr noundef @g_mutex)
  br label %7, !llvm.loop !6

11:                                               ; preds = %7
  %12 = load i32, ptr @g_cs_y, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr @g_cs_y, align 4
  br label %17

14:                                               ; preds = %1
  %15 = load i32, ptr @g_cs_y, align 4
  %16 = sub nsw i32 %15, 2
  store i32 %16, ptr @g_cs_y, align 4
  br label %17

17:                                               ; preds = %14, %11
  call void @vmutex_release(ptr noundef @g_mutex)
  call void @vcond_signal(ptr noundef @g_cond)
  br label %18

18:                                               ; preds = %17
  br label %19

19:                                               ; preds = %18
  %20 = load ptr, ptr %2, align 8
  br label %21

21:                                               ; preds = %19
  br label %22

22:                                               ; preds = %21
  br label %23

23:                                               ; preds = %22
  br label %24

24:                                               ; preds = %23
  ret ptr null
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vmutex_acquire(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @pthread_mutex_lock(ptr noundef %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vcond_wait(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = getelementptr inbounds %struct.vcond_s, ptr %6, i32 0, i32 0
  %8 = call i32 @vatomic32_read_rlx(ptr noundef %7)
  store i32 %8, ptr %5, align 4
  %9 = load ptr, ptr %4, align 8
  call void @vmutex_release(ptr noundef %9)
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.vcond_s, ptr %10, i32 0, i32 0
  %12 = load i32, ptr %5, align 4
  call void @vfutex_wait(ptr noundef %11, i32 noundef %12)
  %13 = load ptr, ptr %4, align 8
  call void @vmutex_acquire(ptr noundef %13)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vmutex_release(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @pthread_mutex_unlock(ptr noundef %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vcond_signal(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.vcond_s, ptr %3, i32 0, i32 0
  call void @vatomic32_inc_rlx(ptr noundef %4)
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.vcond_s, ptr %5, i32 0, i32 0
  call void @vfutex_wake(ptr noundef %6, i32 noundef 1)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @launch_threads(i64 noundef 2, ptr noundef @run)
  %2 = load i32, ptr @g_cs_x, align 4
  %3 = icmp eq i32 %2, 2
  %4 = xor i1 %3, true
  %5 = zext i1 %4 to i32
  %6 = sext i32 %5 to i64
  %7 = icmp ne i64 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %0
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 31, ptr noundef @.str.1) #4
  unreachable

9:                                                ; No predecessors!
  br label %11

10:                                               ; preds = %0
  br label %11

11:                                               ; preds = %10, %9
  %12 = load i32, ptr @g_cs_y, align 4
  %13 = icmp eq i32 %12, -1
  %14 = xor i1 %13, true
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %20

18:                                               ; preds = %11
  call void @__assert_rtn(ptr noundef @__func__.main, ptr noundef @.str, i32 noundef 32, ptr noundef @.str.2) #4
  unreachable

19:                                               ; No predecessors!
  br label %21

20:                                               ; preds = %11
  br label %21

21:                                               ; preds = %20, %19
  ret i32 0
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @launch_threads(i64 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store i64 %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load i64, ptr %3, align 8
  %7 = mul i64 32, %6
  %8 = call ptr @malloc(i64 noundef %7) #5
  store ptr %8, ptr %5, align 8
  %9 = load ptr, ptr %5, align 8
  %10 = load i64, ptr %3, align 8
  %11 = load ptr, ptr %4, align 8
  call void @create_threads(ptr noundef %9, i64 noundef %10, ptr noundef %11, i1 noundef zeroext true)
  %12 = load ptr, ptr %5, align 8
  %13 = load i64, ptr %3, align 8
  call void @await_threads(ptr noundef %12, i64 noundef %13)
  %14 = load ptr, ptr %5, align 8
  call void @free(ptr noundef %14)
  ret void
}

; Function Attrs: cold noreturn
declare void @__assert_rtn(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #1

declare i32 @pthread_mutex_lock(ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_read_rlx(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.vatomic32_s, ptr %4, i32 0, i32 0
  %6 = call i32 asm sideeffect "ldr $0, $1 \0A\0A", "=&r,*Q,~{memory}"(ptr elementtype(i32) %5) #6, !srcloc !8
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  ret i32 %7
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vfutex_wait(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %6 = call i32 @vatomic32_read_acq(ptr noundef @sig)
  store i32 %6, ptr %5, align 4
  %7 = load ptr, ptr %3, align 8
  %8 = call i32 @vatomic32_read_rlx(ptr noundef %7)
  %9 = load i32, ptr %4, align 4
  %10 = icmp ne i32 %8, %9
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  br label %15

12:                                               ; preds = %2
  %13 = load i32, ptr %5, align 4
  %14 = call i32 @vatomic32_await_neq_rlx(ptr noundef @sig, i32 noundef %13)
  br label %15

15:                                               ; preds = %12, %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_read_acq(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.vatomic32_s, ptr %4, i32 0, i32 0
  %6 = call i32 asm sideeffect "ldr $0, $1 \0Admb ish\0A", "=&r,*Q,~{memory}"(ptr elementtype(i32) %5) #6, !srcloc !9
  store i32 %6, ptr %3, align 4
  %7 = load i32, ptr %3, align 4
  ret i32 %7
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
  br label %6, !llvm.loop !10

21:                                               ; preds = %14
  %22 = load i32, ptr %5, align 4
  ret i32 %22
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

declare i32 @pthread_mutex_unlock(ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vatomic32_inc_rlx(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @vatomic32_get_inc_rlx(ptr noundef %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vfutex_wake(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  call void @vatomic32_inc_rel(ptr noundef @sig)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_get_inc_rlx(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @vatomic32_get_add_rlx(ptr noundef %3, i32 noundef 1)
  ret i32 %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_get_add_rlx(ptr noundef %0, i32 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i32 %1, ptr %4, align 4
  %8 = load i32, ptr %4, align 4
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.vatomic32_s, ptr %9, i32 0, i32 0
  %11 = call { i32, i32, i32 } asm sideeffect " \0A1:\0Aldrex $0, $4\0Aadd $1, $0, $3\0Astrex $2, $1, $4\0Acmp $2, #0\0Abne 1b\0A \0A", "=&r,=&r,=&r,r,*Q,~{memory},~{cc}"(i32 %8, ptr elementtype(i32) %10) #6, !srcloc !11
  %12 = extractvalue { i32, i32, i32 } %11, 0
  %13 = extractvalue { i32, i32, i32 } %11, 1
  %14 = extractvalue { i32, i32, i32 } %11, 2
  store i32 %12, ptr %5, align 4
  store i32 %13, ptr %6, align 4
  store i32 %14, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  ret i32 %15
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @vatomic32_inc_rel(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @vatomic32_get_inc_rel(ptr noundef %3)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal i32 @vatomic32_get_inc_rel(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 @vatomic32_get_add_rel(ptr noundef %3, i32 noundef 1)
  ret i32 %4
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
  %8 = load i32, ptr %4, align 4
  %9 = load ptr, ptr %3, align 8
  %10 = getelementptr inbounds %struct.vatomic32_s, ptr %9, i32 0, i32 0
  %11 = call { i32, i32, i32 } asm sideeffect "dmb ish \0A1:\0Aldrex $0, $4\0Aadd $1, $0, $3\0Astrex $2, $1, $4\0Acmp $2, #0\0Abne 1b\0A \0A", "=&r,=&r,=&r,r,*Q,~{memory},~{cc}"(i32 %8, ptr elementtype(i32) %10) #6, !srcloc !12
  %12 = extractvalue { i32, i32, i32 } %11, 0
  %13 = extractvalue { i32, i32, i32 } %11, 1
  %14 = extractvalue { i32, i32, i32 } %11, 2
  store i32 %12, ptr %5, align 4
  store i32 %13, ptr %6, align 4
  store i32 %14, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  ret i32 %15
}

; Function Attrs: allocsize(0)
declare ptr @malloc(i64 noundef) #3

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @create_threads(ptr noundef %0, i64 noundef %1, ptr noundef %2, i1 noundef zeroext %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i64, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i8, align 1
  %9 = alloca i64, align 8
  store ptr %0, ptr %5, align 8
  store i64 %1, ptr %6, align 8
  store ptr %2, ptr %7, align 8
  %10 = zext i1 %3 to i8
  store i8 %10, ptr %8, align 1
  store i64 0, ptr %9, align 8
  store i64 0, ptr %9, align 8
  br label %11

11:                                               ; preds = %41, %4
  %12 = load i64, ptr %9, align 8
  %13 = load i64, ptr %6, align 8
  %14 = icmp ult i64 %12, %13
  br i1 %14, label %15, label %44

15:                                               ; preds = %11
  %16 = load i64, ptr %9, align 8
  %17 = load ptr, ptr %5, align 8
  %18 = load i64, ptr %9, align 8
  %19 = getelementptr inbounds %struct.run_info_t, ptr %17, i64 %18
  %20 = getelementptr inbounds %struct.run_info_t, ptr %19, i32 0, i32 1
  store i64 %16, ptr %20, align 8
  %21 = load ptr, ptr %7, align 8
  %22 = load ptr, ptr %5, align 8
  %23 = load i64, ptr %9, align 8
  %24 = getelementptr inbounds %struct.run_info_t, ptr %22, i64 %23
  %25 = getelementptr inbounds %struct.run_info_t, ptr %24, i32 0, i32 3
  store ptr %21, ptr %25, align 8
  %26 = load i8, ptr %8, align 1
  %27 = trunc i8 %26 to i1
  %28 = load ptr, ptr %5, align 8
  %29 = load i64, ptr %9, align 8
  %30 = getelementptr inbounds %struct.run_info_t, ptr %28, i64 %29
  %31 = getelementptr inbounds %struct.run_info_t, ptr %30, i32 0, i32 2
  %32 = zext i1 %27 to i8
  store i8 %32, ptr %31, align 8
  %33 = load ptr, ptr %5, align 8
  %34 = load i64, ptr %9, align 8
  %35 = getelementptr inbounds %struct.run_info_t, ptr %33, i64 %34
  %36 = getelementptr inbounds %struct.run_info_t, ptr %35, i32 0, i32 0
  %37 = load ptr, ptr %5, align 8
  %38 = load i64, ptr %9, align 8
  %39 = getelementptr inbounds %struct.run_info_t, ptr %37, i64 %38
  %40 = call i32 @pthread_create(ptr noundef %36, ptr noundef null, ptr noundef @common_run, ptr noundef %39)
  br label %41

41:                                               ; preds = %15
  %42 = load i64, ptr %9, align 8
  %43 = add i64 %42, 1
  store i64 %43, ptr %9, align 8
  br label %11, !llvm.loop !13

44:                                               ; preds = %11
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @await_threads(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  store i64 0, ptr %5, align 8
  store i64 0, ptr %5, align 8
  br label %6

6:                                                ; preds = %17, %2
  %7 = load i64, ptr %5, align 8
  %8 = load i64, ptr %4, align 8
  %9 = icmp ult i64 %7, %8
  br i1 %9, label %10, label %20

10:                                               ; preds = %6
  %11 = load ptr, ptr %3, align 8
  %12 = load i64, ptr %5, align 8
  %13 = getelementptr inbounds %struct.run_info_t, ptr %11, i64 %12
  %14 = getelementptr inbounds %struct.run_info_t, ptr %13, i32 0, i32 0
  %15 = load ptr, ptr %14, align 8
  %16 = call i32 @"\01_pthread_join"(ptr noundef %15, ptr noundef null)
  br label %17

17:                                               ; preds = %10
  %18 = load i64, ptr %5, align 8
  %19 = add i64 %18, 1
  store i64 %19, ptr %5, align 8
  br label %6, !llvm.loop !14

20:                                               ; preds = %6
  ret void
}

declare void @free(ptr noundef) #2

declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal ptr @common_run(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  store ptr %4, ptr %3, align 8
  %5 = load ptr, ptr %3, align 8
  %6 = getelementptr inbounds %struct.run_info_t, ptr %5, i32 0, i32 2
  %7 = load i8, ptr %6, align 8
  %8 = trunc i8 %7 to i1
  br i1 %8, label %9, label %13

9:                                                ; preds = %1
  %10 = load ptr, ptr %3, align 8
  %11 = getelementptr inbounds %struct.run_info_t, ptr %10, i32 0, i32 1
  %12 = load i64, ptr %11, align 8
  call void @set_cpu_affinity(i64 noundef %12)
  br label %13

13:                                               ; preds = %9, %1
  %14 = load ptr, ptr %3, align 8
  %15 = getelementptr inbounds %struct.run_info_t, ptr %14, i32 0, i32 3
  %16 = load ptr, ptr %15, align 8
  %17 = load ptr, ptr %3, align 8
  %18 = getelementptr inbounds %struct.run_info_t, ptr %17, i32 0, i32 1
  %19 = load i64, ptr %18, align 8
  %20 = inttoptr i64 %19 to ptr
  %21 = call ptr %16(ptr noundef %20)
  ret ptr %21
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal void @set_cpu_affinity(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, ptr %2, align 8
  br label %3

3:                                                ; preds = %1
  br label %4

4:                                                ; preds = %3
  %5 = load i64, ptr %2, align 8
  br label %6

6:                                                ; preds = %4
  br label %7

7:                                                ; preds = %6
  br label %8

8:                                                ; preds = %7
  br label %9

9:                                                ; preds = %8
  ret void
}

declare i32 @"\01_pthread_join"(ptr noundef, ptr noundef) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #1 = { cold noreturn "disable-tail-calls"="true" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #3 = { allocsize(0) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a,+zcm,+zcz" }
attributes #4 = { cold noreturn }
attributes #5 = { allocsize(0) }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 0]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 19.1.7"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = !{i64 1182519, i64 1182548}
!9 = !{i64 1182026, i64 1182055}
!10 = distinct !{!10, !7}
!11 = !{i64 1222490, i64 1222505, i64 1222520, i64 1222552, i64 1222591, i64 1222631, i64 1222658, i64 1222677}
!12 = !{i64 1218650, i64 1218672, i64 1218687, i64 1218719, i64 1218758, i64 1218798, i64 1218825, i64 1218844}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
