; ModuleID = 'tests/stack_empty.c'
source_filename = "tests/stack_empty.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_stack = type { ptr, ptr }
%struct.ck_stack_entry = type { ptr }

@stack = dso_local global %struct.ck_stack zeroinitializer, align 8, !dbg !0
@.str = private unnamed_addr constant [25 x i8] c"CK_STACK_ISEMPTY(&stack)\00", align 1, !dbg !21
@.str.1 = private unnamed_addr constant [20 x i8] c"tests/stack_empty.c\00", align 1, !dbg !27
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [15 x i8] c"int main(void)\00", align 1, !dbg !32

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @pusher_fn(ptr noundef %0) #0 !dbg !52 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !56, metadata !DIExpression()), !dbg !57
  call void @llvm.dbg.declare(metadata ptr %3, metadata !58, metadata !DIExpression()), !dbg !61
  store i32 0, ptr %3, align 4, !dbg !61
  br label %5, !dbg !62

5:                                                ; preds = %15, %1
  %6 = load i32, ptr %3, align 4, !dbg !63
  %7 = icmp slt i32 %6, 2, !dbg !65
  br i1 %7, label %8, label %18, !dbg !66

8:                                                ; preds = %5
  call void @llvm.dbg.declare(metadata ptr %4, metadata !67, metadata !DIExpression()), !dbg !71
  %9 = call noalias ptr @malloc(i64 noundef 8) #7, !dbg !72
  store ptr %9, ptr %4, align 8, !dbg !71
  %10 = load ptr, ptr %4, align 8, !dbg !73
  %11 = icmp ne ptr %10, null, !dbg !73
  br i1 %11, label %13, label %12, !dbg !75

12:                                               ; preds = %8
  call void @exit(i32 noundef 1) #8, !dbg !76
  unreachable, !dbg !76

13:                                               ; preds = %8
  %14 = load ptr, ptr %4, align 8, !dbg !78
  call void @ck_stack_push_upmc(ptr noundef @stack, ptr noundef %14), !dbg !79
  br label %15, !dbg !80

15:                                               ; preds = %13
  %16 = load i32, ptr %3, align 4, !dbg !81
  %17 = add nsw i32 %16, 1, !dbg !81
  store i32 %17, ptr %3, align 4, !dbg !81
  br label %5, !dbg !82, !llvm.loop !83

18:                                               ; preds = %5
  ret ptr null, !dbg !86
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_stack_push_upmc(ptr noundef %0, ptr noundef %1) #0 !dbg !87 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !91, metadata !DIExpression()), !dbg !92
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !93, metadata !DIExpression()), !dbg !94
  call void @llvm.dbg.declare(metadata ptr %5, metadata !95, metadata !DIExpression()), !dbg !96
  %6 = load ptr, ptr %3, align 8, !dbg !97
  %7 = getelementptr inbounds %struct.ck_stack, ptr %6, i32 0, i32 0, !dbg !97
  %8 = call ptr @ck_pr_md_load_ptr(ptr noundef %7), !dbg !97
  store ptr %8, ptr %5, align 8, !dbg !98
  %9 = load ptr, ptr %5, align 8, !dbg !99
  %10 = load ptr, ptr %4, align 8, !dbg !100
  %11 = getelementptr inbounds %struct.ck_stack_entry, ptr %10, i32 0, i32 0, !dbg !101
  store ptr %9, ptr %11, align 8, !dbg !102
  call void @ck_pr_fence_store(), !dbg !103
  br label %12, !dbg !104

12:                                               ; preds = %20, %2
  %13 = load ptr, ptr %3, align 8, !dbg !105
  %14 = getelementptr inbounds %struct.ck_stack, ptr %13, i32 0, i32 0, !dbg !106
  %15 = load ptr, ptr %5, align 8, !dbg !107
  %16 = load ptr, ptr %4, align 8, !dbg !108
  %17 = call zeroext i1 @ck_pr_cas_ptr_value(ptr noundef %14, ptr noundef %15, ptr noundef %16, ptr noundef %5), !dbg !109
  %18 = zext i1 %17 to i32, !dbg !109
  %19 = icmp eq i32 %18, 0, !dbg !110
  br i1 %19, label %20, label %24, !dbg !104

20:                                               ; preds = %12
  %21 = load ptr, ptr %5, align 8, !dbg !111
  %22 = load ptr, ptr %4, align 8, !dbg !113
  %23 = getelementptr inbounds %struct.ck_stack_entry, ptr %22, i32 0, i32 0, !dbg !114
  store ptr %21, ptr %23, align 8, !dbg !115
  call void @ck_pr_fence_store(), !dbg !116
  br label %12, !dbg !104, !llvm.loop !117

24:                                               ; preds = %12
  ret void, !dbg !119
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @popper_fn(ptr noundef %0) #0 !dbg !120 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !121, metadata !DIExpression()), !dbg !122
  call void @llvm.dbg.declare(metadata ptr %3, metadata !123, metadata !DIExpression()), !dbg !124
  br label %4, !dbg !125

4:                                                ; preds = %7, %1
  %5 = call ptr @ck_stack_pop_upmc(ptr noundef @stack), !dbg !126
  store ptr %5, ptr %3, align 8, !dbg !127
  %6 = icmp eq ptr %5, null, !dbg !128
  br i1 %6, label %7, label %8, !dbg !125

7:                                                ; preds = %4
  br label %4, !dbg !125, !llvm.loop !129

8:                                                ; preds = %4
  %9 = load ptr, ptr %3, align 8, !dbg !131
  call void @free(ptr noundef %9) #9, !dbg !132
  ret ptr null, !dbg !133
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_stack_pop_upmc(ptr noundef %0) #0 !dbg !134 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !137, metadata !DIExpression()), !dbg !138
  call void @llvm.dbg.declare(metadata ptr %4, metadata !139, metadata !DIExpression()), !dbg !140
  call void @llvm.dbg.declare(metadata ptr %5, metadata !141, metadata !DIExpression()), !dbg !142
  %6 = load ptr, ptr %3, align 8, !dbg !143
  %7 = getelementptr inbounds %struct.ck_stack, ptr %6, i32 0, i32 0, !dbg !143
  %8 = call ptr @ck_pr_md_load_ptr(ptr noundef %7), !dbg !143
  store ptr %8, ptr %4, align 8, !dbg !144
  %9 = load ptr, ptr %4, align 8, !dbg !145
  %10 = icmp eq ptr %9, null, !dbg !147
  br i1 %10, label %11, label %12, !dbg !148

11:                                               ; preds = %1
  store ptr null, ptr %2, align 8, !dbg !149
  br label %34, !dbg !149

12:                                               ; preds = %1
  call void @ck_pr_fence_load(), !dbg !150
  %13 = load ptr, ptr %4, align 8, !dbg !151
  %14 = getelementptr inbounds %struct.ck_stack_entry, ptr %13, i32 0, i32 0, !dbg !152
  %15 = load ptr, ptr %14, align 8, !dbg !152
  store ptr %15, ptr %5, align 8, !dbg !153
  br label %16, !dbg !154

16:                                               ; preds = %28, %12
  %17 = load ptr, ptr %3, align 8, !dbg !155
  %18 = getelementptr inbounds %struct.ck_stack, ptr %17, i32 0, i32 0, !dbg !156
  %19 = load ptr, ptr %4, align 8, !dbg !157
  %20 = load ptr, ptr %5, align 8, !dbg !158
  %21 = call zeroext i1 @ck_pr_cas_ptr_value(ptr noundef %18, ptr noundef %19, ptr noundef %20, ptr noundef %4), !dbg !159
  %22 = zext i1 %21 to i32, !dbg !159
  %23 = icmp eq i32 %22, 0, !dbg !160
  br i1 %23, label %24, label %32, !dbg !154

24:                                               ; preds = %16
  %25 = load ptr, ptr %4, align 8, !dbg !161
  %26 = icmp eq ptr %25, null, !dbg !164
  br i1 %26, label %27, label %28, !dbg !165

27:                                               ; preds = %24
  br label %32, !dbg !166

28:                                               ; preds = %24
  call void @ck_pr_fence_load(), !dbg !167
  %29 = load ptr, ptr %4, align 8, !dbg !168
  %30 = getelementptr inbounds %struct.ck_stack_entry, ptr %29, i32 0, i32 0, !dbg !169
  %31 = load ptr, ptr %30, align 8, !dbg !169
  store ptr %31, ptr %5, align 8, !dbg !170
  br label %16, !dbg !154, !llvm.loop !171

32:                                               ; preds = %27, %16
  %33 = load ptr, ptr %4, align 8, !dbg !173
  store ptr %33, ptr %2, align 8, !dbg !174
  br label %34, !dbg !174

34:                                               ; preds = %32, %11
  %35 = load ptr, ptr %2, align 8, !dbg !175
  ret ptr %35, !dbg !175
}

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !176 {
  %1 = alloca i32, align 4
  %2 = alloca [1 x i64], align 8
  %3 = alloca [2 x i64], align 16
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  call void @llvm.dbg.declare(metadata ptr %2, metadata !179, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.declare(metadata ptr %3, metadata !186, metadata !DIExpression()), !dbg !190
  call void @llvm.dbg.declare(metadata ptr %4, metadata !191, metadata !DIExpression()), !dbg !193
  store i32 0, ptr %4, align 4, !dbg !193
  br label %8, !dbg !194

8:                                                ; preds = %19, %0
  %9 = load i32, ptr %4, align 4, !dbg !195
  %10 = icmp slt i32 %9, 1, !dbg !197
  br i1 %10, label %11, label %22, !dbg !198

11:                                               ; preds = %8
  %12 = load i32, ptr %4, align 4, !dbg !199
  %13 = sext i32 %12 to i64, !dbg !202
  %14 = getelementptr inbounds [1 x i64], ptr %2, i64 0, i64 %13, !dbg !202
  %15 = call i32 @pthread_create(ptr noundef %14, ptr noundef null, ptr noundef @pusher_fn, ptr noundef null) #9, !dbg !203
  %16 = icmp ne i32 %15, 0, !dbg !204
  br i1 %16, label %17, label %18, !dbg !205

17:                                               ; preds = %11
  store i32 1, ptr %1, align 4, !dbg !206
  br label %69, !dbg !206

18:                                               ; preds = %11
  br label %19, !dbg !208

19:                                               ; preds = %18
  %20 = load i32, ptr %4, align 4, !dbg !209
  %21 = add nsw i32 %20, 1, !dbg !209
  store i32 %21, ptr %4, align 4, !dbg !209
  br label %8, !dbg !210, !llvm.loop !211

22:                                               ; preds = %8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !213, metadata !DIExpression()), !dbg !215
  store i32 0, ptr %5, align 4, !dbg !215
  br label %23, !dbg !216

23:                                               ; preds = %34, %22
  %24 = load i32, ptr %5, align 4, !dbg !217
  %25 = icmp slt i32 %24, 2, !dbg !219
  br i1 %25, label %26, label %37, !dbg !220

26:                                               ; preds = %23
  %27 = load i32, ptr %5, align 4, !dbg !221
  %28 = sext i32 %27 to i64, !dbg !224
  %29 = getelementptr inbounds [2 x i64], ptr %3, i64 0, i64 %28, !dbg !224
  %30 = call i32 @pthread_create(ptr noundef %29, ptr noundef null, ptr noundef @popper_fn, ptr noundef null) #9, !dbg !225
  %31 = icmp ne i32 %30, 0, !dbg !226
  br i1 %31, label %32, label %33, !dbg !227

32:                                               ; preds = %26
  store i32 1, ptr %1, align 4, !dbg !228
  br label %69, !dbg !228

33:                                               ; preds = %26
  br label %34, !dbg !230

34:                                               ; preds = %33
  %35 = load i32, ptr %5, align 4, !dbg !231
  %36 = add nsw i32 %35, 1, !dbg !231
  store i32 %36, ptr %5, align 4, !dbg !231
  br label %23, !dbg !232, !llvm.loop !233

37:                                               ; preds = %23
  call void @llvm.dbg.declare(metadata ptr %6, metadata !235, metadata !DIExpression()), !dbg !237
  store i32 0, ptr %6, align 4, !dbg !237
  br label %38, !dbg !238

38:                                               ; preds = %47, %37
  %39 = load i32, ptr %6, align 4, !dbg !239
  %40 = icmp slt i32 %39, 1, !dbg !241
  br i1 %40, label %41, label %50, !dbg !242

41:                                               ; preds = %38
  %42 = load i32, ptr %6, align 4, !dbg !243
  %43 = sext i32 %42 to i64, !dbg !245
  %44 = getelementptr inbounds [1 x i64], ptr %2, i64 0, i64 %43, !dbg !245
  %45 = load i64, ptr %44, align 8, !dbg !245
  %46 = call i32 @pthread_join(i64 noundef %45, ptr noundef null), !dbg !246
  br label %47, !dbg !247

47:                                               ; preds = %41
  %48 = load i32, ptr %6, align 4, !dbg !248
  %49 = add nsw i32 %48, 1, !dbg !248
  store i32 %49, ptr %6, align 4, !dbg !248
  br label %38, !dbg !249, !llvm.loop !250

50:                                               ; preds = %38
  call void @llvm.dbg.declare(metadata ptr %7, metadata !252, metadata !DIExpression()), !dbg !254
  store i32 0, ptr %7, align 4, !dbg !254
  br label %51, !dbg !255

51:                                               ; preds = %60, %50
  %52 = load i32, ptr %7, align 4, !dbg !256
  %53 = icmp slt i32 %52, 2, !dbg !258
  br i1 %53, label %54, label %63, !dbg !259

54:                                               ; preds = %51
  %55 = load i32, ptr %7, align 4, !dbg !260
  %56 = sext i32 %55 to i64, !dbg !262
  %57 = getelementptr inbounds [2 x i64], ptr %3, i64 0, i64 %56, !dbg !262
  %58 = load i64, ptr %57, align 8, !dbg !262
  %59 = call i32 @pthread_join(i64 noundef %58, ptr noundef null), !dbg !263
  br label %60, !dbg !264

60:                                               ; preds = %54
  %61 = load i32, ptr %7, align 4, !dbg !265
  %62 = add nsw i32 %61, 1, !dbg !265
  store i32 %62, ptr %7, align 4, !dbg !265
  br label %51, !dbg !266, !llvm.loop !267

63:                                               ; preds = %51
  %64 = load ptr, ptr @stack, align 8, !dbg !269
  %65 = icmp eq ptr %64, null, !dbg !269
  br i1 %65, label %66, label %67, !dbg !272

66:                                               ; preds = %63
  br label %68, !dbg !272

67:                                               ; preds = %63
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 59, ptr noundef @__PRETTY_FUNCTION__.main) #8, !dbg !269
  unreachable, !dbg !269

68:                                               ; preds = %66
  store i32 0, ptr %1, align 4, !dbg !273
  br label %69, !dbg !273

69:                                               ; preds = %68, %32, %17
  %70 = load i32, ptr %1, align 4, !dbg !274
  ret i32 %70, !dbg !274
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #4

declare i32 @pthread_join(i64 noundef, ptr noundef) #5

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_md_load_ptr(ptr noundef %0) #0 !dbg !275 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !281, metadata !DIExpression()), !dbg !282
  call void @llvm.dbg.declare(metadata ptr %3, metadata !283, metadata !DIExpression()), !dbg !282
  %4 = load ptr, ptr %2, align 8, !dbg !282
  %5 = call ptr asm sideeffect "movq $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %4) #9, !dbg !282, !srcloc !284
  store ptr %5, ptr %3, align 8, !dbg !282
  %6 = load ptr, ptr %3, align 8, !dbg !282
  ret ptr %6, !dbg !282
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_store() #0 !dbg !285 {
  call void @ck_pr_barrier(), !dbg !289
  ret void, !dbg !289
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_ptr_value(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 !dbg !290 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i8, align 1
  store ptr %0, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !294, metadata !DIExpression()), !dbg !295
  store ptr %1, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !296, metadata !DIExpression()), !dbg !295
  store ptr %2, ptr %7, align 8
  call void @llvm.dbg.declare(metadata ptr %7, metadata !297, metadata !DIExpression()), !dbg !295
  store ptr %3, ptr %8, align 8
  call void @llvm.dbg.declare(metadata ptr %8, metadata !298, metadata !DIExpression()), !dbg !295
  call void @llvm.dbg.declare(metadata ptr %9, metadata !299, metadata !DIExpression()), !dbg !295
  %10 = load ptr, ptr %5, align 8, !dbg !295
  %11 = load ptr, ptr %6, align 8, !dbg !295
  %12 = load ptr, ptr %7, align 8, !dbg !295
  %13 = call { i8, ptr } asm sideeffect "lock cmpxchgq $3, $0;", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %10, ptr %12, ptr elementtype(i64) %10, ptr %11) #9, !dbg !295, !srcloc !300
  %14 = extractvalue { i8, ptr } %13, 0, !dbg !295
  %15 = extractvalue { i8, ptr } %13, 1, !dbg !295
  %16 = icmp ult i8 %14, 2, !dbg !295
  call void @llvm.assume(i1 %16), !dbg !295
  store i8 %14, ptr %9, align 1, !dbg !295
  store ptr %15, ptr %6, align 8, !dbg !295
  %17 = load ptr, ptr %6, align 8, !dbg !295
  %18 = load ptr, ptr %8, align 8, !dbg !295
  store ptr %17, ptr %18, align 8, !dbg !295
  %19 = load i8, ptr %9, align 1, !dbg !295
  %20 = trunc i8 %19 to i1, !dbg !295
  ret i1 %20, !dbg !295
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !301 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #9, !dbg !303, !srcloc !304
  ret void, !dbg !305
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #6

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_load() #0 !dbg !306 {
  call void @ck_pr_barrier(), !dbg !307
  ret void, !dbg !307
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
!llvm.module.flags = !{!44, !45, !46, !47, !48, !49, !50}
!llvm.ident = !{!51}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "stack", scope: !2, file: !3, line: 14, type: !38, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !4, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "tests/stack_empty.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "2fbdd2e50017f6d095e4050f4972b9fc")
!4 = !{!5, !6, !11, !18, !19}
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_stack_entry", file: !8, line: 35, size: 64, elements: !9)
!8 = !DIFile(filename: "include/ck_stack.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "19674f5fb31e41969a7583ca1d1160b2")
!9 = !{!10}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !8, line: 36, baseType: !6, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !14, line: 27, baseType: !15)
!14 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !16, line: 45, baseType: !17)
!16 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!17 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!20 = !{!0, !21, !27, !32}
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(scope: null, file: !3, line: 59, type: !23, isLocal: true, isDefinition: true)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 200, elements: !25)
!24 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!25 = !{!26}
!26 = !DISubrange(count: 25)
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(scope: null, file: !3, line: 59, type: !29, isLocal: true, isDefinition: true)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 160, elements: !30)
!30 = !{!31}
!31 = !DISubrange(count: 20)
!32 = !DIGlobalVariableExpression(var: !33, expr: !DIExpression())
!33 = distinct !DIGlobalVariable(scope: null, file: !3, line: 59, type: !34, isLocal: true, isDefinition: true)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !35, size: 120, elements: !36)
!35 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !24)
!36 = !{!37}
!37 = !DISubrange(count: 15)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_stack_t", file: !8, line: 44, baseType: !39)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_stack", file: !8, line: 40, size: 128, elements: !40)
!40 = !{!41, !42}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !39, file: !8, line: 41, baseType: !6, size: 64)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "generation", scope: !39, file: !8, line: 42, baseType: !43, size: 64, offset: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!44 = !{i32 7, !"Dwarf Version", i32 5}
!45 = !{i32 2, !"Debug Info Version", i32 3}
!46 = !{i32 1, !"wchar_size", i32 4}
!47 = !{i32 8, !"PIC Level", i32 2}
!48 = !{i32 7, !"PIE Level", i32 2}
!49 = !{i32 7, !"uwtable", i32 2}
!50 = !{i32 7, !"frame-pointer", i32 2}
!51 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!52 = distinct !DISubprogram(name: "pusher_fn", scope: !3, file: !3, line: 16, type: !53, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!53 = !DISubroutineType(types: !54)
!54 = !{!5, !5}
!55 = !{}
!56 = !DILocalVariable(name: "arg", arg: 1, scope: !52, file: !3, line: 16, type: !5)
!57 = !DILocation(line: 16, column: 23, scope: !52)
!58 = !DILocalVariable(name: "i", scope: !59, file: !3, line: 17, type: !60)
!59 = distinct !DILexicalBlock(scope: !52, file: !3, line: 17, column: 5)
!60 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!61 = !DILocation(line: 17, column: 14, scope: !59)
!62 = !DILocation(line: 17, column: 10, scope: !59)
!63 = !DILocation(line: 17, column: 21, scope: !64)
!64 = distinct !DILexicalBlock(scope: !59, file: !3, line: 17, column: 5)
!65 = !DILocation(line: 17, column: 23, scope: !64)
!66 = !DILocation(line: 17, column: 5, scope: !59)
!67 = !DILocalVariable(name: "entry", scope: !68, file: !3, line: 18, type: !69)
!68 = distinct !DILexicalBlock(scope: !64, file: !3, line: 17, column: 43)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_stack_entry_t", file: !8, line: 38, baseType: !7)
!71 = !DILocation(line: 18, column: 27, scope: !68)
!72 = !DILocation(line: 18, column: 35, scope: !68)
!73 = !DILocation(line: 19, column: 14, scope: !74)
!74 = distinct !DILexicalBlock(scope: !68, file: !3, line: 19, column: 13)
!75 = !DILocation(line: 19, column: 13, scope: !68)
!76 = !DILocation(line: 20, column: 13, scope: !77)
!77 = distinct !DILexicalBlock(scope: !74, file: !3, line: 19, column: 21)
!78 = !DILocation(line: 22, column: 36, scope: !68)
!79 = !DILocation(line: 22, column: 9, scope: !68)
!80 = !DILocation(line: 23, column: 5, scope: !68)
!81 = !DILocation(line: 17, column: 39, scope: !64)
!82 = !DILocation(line: 17, column: 5, scope: !64)
!83 = distinct !{!83, !66, !84, !85}
!84 = !DILocation(line: 23, column: 5, scope: !59)
!85 = !{!"llvm.loop.mustprogress"}
!86 = !DILocation(line: 24, column: 5, scope: !52)
!87 = distinct !DISubprogram(name: "ck_stack_push_upmc", scope: !8, file: !8, line: 54, type: !88, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !90, !6}
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!91 = !DILocalVariable(name: "target", arg: 1, scope: !87, file: !8, line: 54, type: !90)
!92 = !DILocation(line: 54, column: 37, scope: !87)
!93 = !DILocalVariable(name: "entry", arg: 2, scope: !87, file: !8, line: 54, type: !6)
!94 = !DILocation(line: 54, column: 68, scope: !87)
!95 = !DILocalVariable(name: "stack", scope: !87, file: !8, line: 56, type: !6)
!96 = !DILocation(line: 56, column: 25, scope: !87)
!97 = !DILocation(line: 58, column: 10, scope: !87)
!98 = !DILocation(line: 58, column: 8, scope: !87)
!99 = !DILocation(line: 59, column: 16, scope: !87)
!100 = !DILocation(line: 59, column: 2, scope: !87)
!101 = !DILocation(line: 59, column: 9, scope: !87)
!102 = !DILocation(line: 59, column: 14, scope: !87)
!103 = !DILocation(line: 60, column: 2, scope: !87)
!104 = !DILocation(line: 62, column: 2, scope: !87)
!105 = !DILocation(line: 62, column: 30, scope: !87)
!106 = !DILocation(line: 62, column: 38, scope: !87)
!107 = !DILocation(line: 62, column: 44, scope: !87)
!108 = !DILocation(line: 62, column: 51, scope: !87)
!109 = !DILocation(line: 62, column: 9, scope: !87)
!110 = !DILocation(line: 62, column: 66, scope: !87)
!111 = !DILocation(line: 63, column: 17, scope: !112)
!112 = distinct !DILexicalBlock(scope: !87, file: !8, line: 62, column: 76)
!113 = !DILocation(line: 63, column: 3, scope: !112)
!114 = !DILocation(line: 63, column: 10, scope: !112)
!115 = !DILocation(line: 63, column: 15, scope: !112)
!116 = !DILocation(line: 64, column: 3, scope: !112)
!117 = distinct !{!117, !104, !118, !85}
!118 = !DILocation(line: 65, column: 2, scope: !87)
!119 = !DILocation(line: 67, column: 2, scope: !87)
!120 = distinct !DISubprogram(name: "popper_fn", scope: !3, file: !3, line: 27, type: !53, scopeLine: 27, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!121 = !DILocalVariable(name: "arg", arg: 1, scope: !120, file: !3, line: 27, type: !5)
!122 = !DILocation(line: 27, column: 23, scope: !120)
!123 = !DILocalVariable(name: "entry", scope: !120, file: !3, line: 28, type: !69)
!124 = !DILocation(line: 28, column: 23, scope: !120)
!125 = !DILocation(line: 29, column: 5, scope: !120)
!126 = !DILocation(line: 29, column: 21, scope: !120)
!127 = !DILocation(line: 29, column: 19, scope: !120)
!128 = !DILocation(line: 29, column: 48, scope: !120)
!129 = distinct !{!129, !125, !130, !85}
!130 = !DILocation(line: 30, column: 9, scope: !120)
!131 = !DILocation(line: 31, column: 10, scope: !120)
!132 = !DILocation(line: 31, column: 5, scope: !120)
!133 = !DILocation(line: 32, column: 5, scope: !120)
!134 = distinct !DISubprogram(name: "ck_stack_pop_upmc", scope: !8, file: !8, line: 96, type: !135, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!135 = !DISubroutineType(types: !136)
!136 = !{!6, !90}
!137 = !DILocalVariable(name: "target", arg: 1, scope: !134, file: !8, line: 96, type: !90)
!138 = !DILocation(line: 96, column: 36, scope: !134)
!139 = !DILocalVariable(name: "entry", scope: !134, file: !8, line: 98, type: !6)
!140 = !DILocation(line: 98, column: 25, scope: !134)
!141 = !DILocalVariable(name: "next", scope: !134, file: !8, line: 98, type: !6)
!142 = !DILocation(line: 98, column: 33, scope: !134)
!143 = !DILocation(line: 100, column: 10, scope: !134)
!144 = !DILocation(line: 100, column: 8, scope: !134)
!145 = !DILocation(line: 101, column: 6, scope: !146)
!146 = distinct !DILexicalBlock(scope: !134, file: !8, line: 101, column: 6)
!147 = !DILocation(line: 101, column: 12, scope: !146)
!148 = !DILocation(line: 101, column: 6, scope: !134)
!149 = !DILocation(line: 102, column: 3, scope: !146)
!150 = !DILocation(line: 104, column: 2, scope: !134)
!151 = !DILocation(line: 105, column: 9, scope: !134)
!152 = !DILocation(line: 105, column: 16, scope: !134)
!153 = !DILocation(line: 105, column: 7, scope: !134)
!154 = !DILocation(line: 106, column: 2, scope: !134)
!155 = !DILocation(line: 106, column: 30, scope: !134)
!156 = !DILocation(line: 106, column: 38, scope: !134)
!157 = !DILocation(line: 106, column: 44, scope: !134)
!158 = !DILocation(line: 106, column: 51, scope: !134)
!159 = !DILocation(line: 106, column: 9, scope: !134)
!160 = !DILocation(line: 106, column: 65, scope: !134)
!161 = !DILocation(line: 107, column: 7, scope: !162)
!162 = distinct !DILexicalBlock(scope: !163, file: !8, line: 107, column: 7)
!163 = distinct !DILexicalBlock(scope: !134, file: !8, line: 106, column: 75)
!164 = !DILocation(line: 107, column: 13, scope: !162)
!165 = !DILocation(line: 107, column: 7, scope: !163)
!166 = !DILocation(line: 108, column: 4, scope: !162)
!167 = !DILocation(line: 110, column: 3, scope: !163)
!168 = !DILocation(line: 111, column: 10, scope: !163)
!169 = !DILocation(line: 111, column: 17, scope: !163)
!170 = !DILocation(line: 111, column: 8, scope: !163)
!171 = distinct !{!171, !154, !172, !85}
!172 = !DILocation(line: 112, column: 2, scope: !134)
!173 = !DILocation(line: 114, column: 9, scope: !134)
!174 = !DILocation(line: 114, column: 2, scope: !134)
!175 = !DILocation(line: 115, column: 1, scope: !134)
!176 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 35, type: !177, scopeLine: 35, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !55)
!177 = !DISubroutineType(types: !178)
!178 = !{!60}
!179 = !DILocalVariable(name: "pushers", scope: !176, file: !3, line: 36, type: !180)
!180 = !DICompositeType(tag: DW_TAG_array_type, baseType: !181, size: 64, elements: !183)
!181 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !182, line: 27, baseType: !17)
!182 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!183 = !{!184}
!184 = !DISubrange(count: 1)
!185 = !DILocation(line: 36, column: 15, scope: !176)
!186 = !DILocalVariable(name: "poppers", scope: !176, file: !3, line: 37, type: !187)
!187 = !DICompositeType(tag: DW_TAG_array_type, baseType: !181, size: 128, elements: !188)
!188 = !{!189}
!189 = !DISubrange(count: 2)
!190 = !DILocation(line: 37, column: 15, scope: !176)
!191 = !DILocalVariable(name: "i", scope: !192, file: !3, line: 39, type: !60)
!192 = distinct !DILexicalBlock(scope: !176, file: !3, line: 39, column: 5)
!193 = !DILocation(line: 39, column: 14, scope: !192)
!194 = !DILocation(line: 39, column: 10, scope: !192)
!195 = !DILocation(line: 39, column: 21, scope: !196)
!196 = distinct !DILexicalBlock(scope: !192, file: !3, line: 39, column: 5)
!197 = !DILocation(line: 39, column: 23, scope: !196)
!198 = !DILocation(line: 39, column: 5, scope: !192)
!199 = !DILocation(line: 40, column: 37, scope: !200)
!200 = distinct !DILexicalBlock(scope: !201, file: !3, line: 40, column: 13)
!201 = distinct !DILexicalBlock(scope: !196, file: !3, line: 39, column: 43)
!202 = !DILocation(line: 40, column: 29, scope: !200)
!203 = !DILocation(line: 40, column: 13, scope: !200)
!204 = !DILocation(line: 40, column: 64, scope: !200)
!205 = !DILocation(line: 40, column: 13, scope: !201)
!206 = !DILocation(line: 41, column: 13, scope: !207)
!207 = distinct !DILexicalBlock(scope: !200, file: !3, line: 40, column: 70)
!208 = !DILocation(line: 43, column: 5, scope: !201)
!209 = !DILocation(line: 39, column: 39, scope: !196)
!210 = !DILocation(line: 39, column: 5, scope: !196)
!211 = distinct !{!211, !198, !212, !85}
!212 = !DILocation(line: 43, column: 5, scope: !192)
!213 = !DILocalVariable(name: "i", scope: !214, file: !3, line: 45, type: !60)
!214 = distinct !DILexicalBlock(scope: !176, file: !3, line: 45, column: 5)
!215 = !DILocation(line: 45, column: 14, scope: !214)
!216 = !DILocation(line: 45, column: 10, scope: !214)
!217 = !DILocation(line: 45, column: 21, scope: !218)
!218 = distinct !DILexicalBlock(scope: !214, file: !3, line: 45, column: 5)
!219 = !DILocation(line: 45, column: 23, scope: !218)
!220 = !DILocation(line: 45, column: 5, scope: !214)
!221 = !DILocation(line: 46, column: 37, scope: !222)
!222 = distinct !DILexicalBlock(scope: !223, file: !3, line: 46, column: 13)
!223 = distinct !DILexicalBlock(scope: !218, file: !3, line: 45, column: 43)
!224 = !DILocation(line: 46, column: 29, scope: !222)
!225 = !DILocation(line: 46, column: 13, scope: !222)
!226 = !DILocation(line: 46, column: 64, scope: !222)
!227 = !DILocation(line: 46, column: 13, scope: !223)
!228 = !DILocation(line: 47, column: 13, scope: !229)
!229 = distinct !DILexicalBlock(scope: !222, file: !3, line: 46, column: 70)
!230 = !DILocation(line: 49, column: 5, scope: !223)
!231 = !DILocation(line: 45, column: 39, scope: !218)
!232 = !DILocation(line: 45, column: 5, scope: !218)
!233 = distinct !{!233, !220, !234, !85}
!234 = !DILocation(line: 49, column: 5, scope: !214)
!235 = !DILocalVariable(name: "i", scope: !236, file: !3, line: 51, type: !60)
!236 = distinct !DILexicalBlock(scope: !176, file: !3, line: 51, column: 5)
!237 = !DILocation(line: 51, column: 14, scope: !236)
!238 = !DILocation(line: 51, column: 10, scope: !236)
!239 = !DILocation(line: 51, column: 21, scope: !240)
!240 = distinct !DILexicalBlock(scope: !236, file: !3, line: 51, column: 5)
!241 = !DILocation(line: 51, column: 23, scope: !240)
!242 = !DILocation(line: 51, column: 5, scope: !236)
!243 = !DILocation(line: 52, column: 30, scope: !244)
!244 = distinct !DILexicalBlock(scope: !240, file: !3, line: 51, column: 43)
!245 = !DILocation(line: 52, column: 22, scope: !244)
!246 = !DILocation(line: 52, column: 9, scope: !244)
!247 = !DILocation(line: 53, column: 5, scope: !244)
!248 = !DILocation(line: 51, column: 39, scope: !240)
!249 = !DILocation(line: 51, column: 5, scope: !240)
!250 = distinct !{!250, !242, !251, !85}
!251 = !DILocation(line: 53, column: 5, scope: !236)
!252 = !DILocalVariable(name: "i", scope: !253, file: !3, line: 55, type: !60)
!253 = distinct !DILexicalBlock(scope: !176, file: !3, line: 55, column: 5)
!254 = !DILocation(line: 55, column: 14, scope: !253)
!255 = !DILocation(line: 55, column: 10, scope: !253)
!256 = !DILocation(line: 55, column: 21, scope: !257)
!257 = distinct !DILexicalBlock(scope: !253, file: !3, line: 55, column: 5)
!258 = !DILocation(line: 55, column: 23, scope: !257)
!259 = !DILocation(line: 55, column: 5, scope: !253)
!260 = !DILocation(line: 56, column: 30, scope: !261)
!261 = distinct !DILexicalBlock(scope: !257, file: !3, line: 55, column: 43)
!262 = !DILocation(line: 56, column: 22, scope: !261)
!263 = !DILocation(line: 56, column: 9, scope: !261)
!264 = !DILocation(line: 57, column: 5, scope: !261)
!265 = !DILocation(line: 55, column: 39, scope: !257)
!266 = !DILocation(line: 55, column: 5, scope: !257)
!267 = distinct !{!267, !259, !268, !85}
!268 = !DILocation(line: 57, column: 5, scope: !253)
!269 = !DILocation(line: 59, column: 5, scope: !270)
!270 = distinct !DILexicalBlock(scope: !271, file: !3, line: 59, column: 5)
!271 = distinct !DILexicalBlock(scope: !176, file: !3, line: 59, column: 5)
!272 = !DILocation(line: 59, column: 5, scope: !271)
!273 = !DILocation(line: 61, column: 5, scope: !176)
!274 = !DILocation(line: 62, column: 1, scope: !176)
!275 = distinct !DISubprogram(name: "ck_pr_md_load_ptr", scope: !276, file: !276, line: 185, type: !277, scopeLine: 185, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!276 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!277 = !DISubroutineType(types: !278)
!278 = !{!5, !279}
!279 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !280, size: 64)
!280 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!281 = !DILocalVariable(name: "target", arg: 1, scope: !275, file: !276, line: 185, type: !279)
!282 = !DILocation(line: 185, column: 1, scope: !275)
!283 = !DILocalVariable(name: "r", scope: !275, file: !276, line: 185, type: !5)
!284 = !{i64 2147748265}
!285 = distinct !DISubprogram(name: "ck_pr_fence_store", scope: !286, file: !286, line: 157, type: !287, scopeLine: 157, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!286 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!287 = !DISubroutineType(types: !288)
!288 = !{null}
!289 = !DILocation(line: 157, column: 1, scope: !285)
!290 = distinct !DISubprogram(name: "ck_pr_cas_ptr_value", scope: !276, file: !276, line: 473, type: !291, scopeLine: 473, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !55)
!291 = !DISubroutineType(types: !292)
!292 = !{!293, !5, !5, !5, !5}
!293 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!294 = !DILocalVariable(name: "target", arg: 1, scope: !290, file: !276, line: 473, type: !5)
!295 = !DILocation(line: 473, column: 1, scope: !290)
!296 = !DILocalVariable(name: "compare", arg: 2, scope: !290, file: !276, line: 473, type: !5)
!297 = !DILocalVariable(name: "set", arg: 3, scope: !290, file: !276, line: 473, type: !5)
!298 = !DILocalVariable(name: "v", arg: 4, scope: !290, file: !276, line: 473, type: !5)
!299 = !DILocalVariable(name: "z", scope: !290, file: !276, line: 473, type: !293)
!300 = !{i64 2147811131}
!301 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !302, file: !302, line: 37, type: !287, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!302 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!303 = !DILocation(line: 40, column: 2, scope: !301)
!304 = !{i64 356564}
!305 = !DILocation(line: 41, column: 2, scope: !301)
!306 = distinct !DISubprogram(name: "ck_pr_fence_load", scope: !286, file: !286, line: 156, type: !287, scopeLine: 156, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!307 = !DILocation(line: 156, column: 1, scope: !306)
