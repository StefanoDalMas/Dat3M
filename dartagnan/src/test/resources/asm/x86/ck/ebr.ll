; ModuleID = 'ebr.c'
source_filename = "ebr.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ck_epoch = type { i32, i32, %struct.ck_stack }
%struct.ck_stack = type { ptr, ptr }
%struct.ck_epoch_record = type { %struct.ck_stack_entry, ptr, i32, i32, i32, [36 x i8], %struct.anon, i32, i32, i32, ptr, [4 x %struct.ck_stack], [24 x i8] }
%struct.ck_stack_entry = type { ptr }
%struct.anon = type { [2 x %struct.ck_epoch_ref] }
%struct.ck_epoch_ref = type { i32, i32 }
%struct.ck_epoch_section = type { i32 }
%struct.ck_epoch_entry = type { ptr, %struct.ck_stack_entry }

@stack_epoch = internal global %struct.ck_epoch zeroinitializer, align 8, !dbg !0
@records = dso_local global [4 x %struct.ck_epoch_record] zeroinitializer, align 64, !dbg !87
@.str = private unnamed_addr constant [41 x i8] c"!(local_epoch == 1 && global_epoch == 3)\00", align 1, !dbg !90
@.str.1 = private unnamed_addr constant [6 x i8] c"ebr.c\00", align 1, !dbg !95
@__PRETTY_FUNCTION__.thread = private unnamed_addr constant [21 x i8] c"void *thread(void *)\00", align 1, !dbg !100

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @_ck_epoch_delref(ptr noundef %0, ptr noundef %1) #0 !dbg !115 {
  %3 = alloca i1, align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !124, metadata !DIExpression()), !dbg !125
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !126, metadata !DIExpression()), !dbg !127
  call void @llvm.dbg.declare(metadata ptr %6, metadata !128, metadata !DIExpression()), !dbg !130
  call void @llvm.dbg.declare(metadata ptr %7, metadata !131, metadata !DIExpression()), !dbg !132
  call void @llvm.dbg.declare(metadata ptr %8, metadata !133, metadata !DIExpression()), !dbg !134
  %9 = load ptr, ptr %5, align 8, !dbg !135
  %10 = getelementptr inbounds %struct.ck_epoch_section, ptr %9, i32 0, i32 0, !dbg !136
  %11 = load i32, ptr %10, align 4, !dbg !136
  store i32 %11, ptr %8, align 4, !dbg !134
  %12 = load ptr, ptr %4, align 8, !dbg !137
  %13 = getelementptr inbounds %struct.ck_epoch_record, ptr %12, i32 0, i32 6, !dbg !138
  %14 = getelementptr inbounds %struct.anon, ptr %13, i32 0, i32 0, !dbg !139
  %15 = load i32, ptr %8, align 4, !dbg !140
  %16 = zext i32 %15 to i64, !dbg !137
  %17 = getelementptr inbounds [2 x %struct.ck_epoch_ref], ptr %14, i64 0, i64 %16, !dbg !137
  store ptr %17, ptr %6, align 8, !dbg !141
  %18 = load ptr, ptr %6, align 8, !dbg !142
  %19 = getelementptr inbounds %struct.ck_epoch_ref, ptr %18, i32 0, i32 1, !dbg !143
  %20 = load i32, ptr %19, align 4, !dbg !144
  %21 = add i32 %20, -1, !dbg !144
  store i32 %21, ptr %19, align 4, !dbg !144
  %22 = load ptr, ptr %6, align 8, !dbg !145
  %23 = getelementptr inbounds %struct.ck_epoch_ref, ptr %22, i32 0, i32 1, !dbg !147
  %24 = load i32, ptr %23, align 4, !dbg !147
  %25 = icmp ugt i32 %24, 0, !dbg !148
  br i1 %25, label %26, label %27, !dbg !149

26:                                               ; preds = %2
  store i1 false, ptr %3, align 1, !dbg !150
  br label %56, !dbg !150

27:                                               ; preds = %2
  %28 = load ptr, ptr %4, align 8, !dbg !151
  %29 = getelementptr inbounds %struct.ck_epoch_record, ptr %28, i32 0, i32 6, !dbg !152
  %30 = getelementptr inbounds %struct.anon, ptr %29, i32 0, i32 0, !dbg !153
  %31 = load i32, ptr %8, align 4, !dbg !154
  %32 = add i32 %31, 1, !dbg !155
  %33 = and i32 %32, 1, !dbg !156
  %34 = zext i32 %33 to i64, !dbg !151
  %35 = getelementptr inbounds [2 x %struct.ck_epoch_ref], ptr %30, i64 0, i64 %34, !dbg !151
  store ptr %35, ptr %7, align 8, !dbg !157
  %36 = load ptr, ptr %7, align 8, !dbg !158
  %37 = getelementptr inbounds %struct.ck_epoch_ref, ptr %36, i32 0, i32 1, !dbg !160
  %38 = load i32, ptr %37, align 4, !dbg !160
  %39 = icmp ugt i32 %38, 0, !dbg !161
  br i1 %39, label %40, label %55, !dbg !162

40:                                               ; preds = %27
  %41 = load ptr, ptr %6, align 8, !dbg !163
  %42 = getelementptr inbounds %struct.ck_epoch_ref, ptr %41, i32 0, i32 0, !dbg !164
  %43 = load i32, ptr %42, align 4, !dbg !164
  %44 = load ptr, ptr %7, align 8, !dbg !165
  %45 = getelementptr inbounds %struct.ck_epoch_ref, ptr %44, i32 0, i32 0, !dbg !166
  %46 = load i32, ptr %45, align 4, !dbg !166
  %47 = sub i32 %43, %46, !dbg !167
  %48 = icmp slt i32 %47, 0, !dbg !168
  br i1 %48, label %49, label %55, !dbg !169

49:                                               ; preds = %40
  %50 = load ptr, ptr %4, align 8, !dbg !170
  %51 = getelementptr inbounds %struct.ck_epoch_record, ptr %50, i32 0, i32 3, !dbg !170
  %52 = load ptr, ptr %7, align 8, !dbg !170
  %53 = getelementptr inbounds %struct.ck_epoch_ref, ptr %52, i32 0, i32 0, !dbg !170
  %54 = load i32, ptr %53, align 4, !dbg !170
  call void @ck_pr_md_store_uint(ptr noundef %51, i32 noundef %54), !dbg !170
  br label %55, !dbg !172

55:                                               ; preds = %49, %40, %27
  store i1 true, ptr %3, align 1, !dbg !173
  br label %56, !dbg !173

56:                                               ; preds = %55, %26
  %57 = load i1, ptr %3, align 1, !dbg !174
  ret i1 %57, !dbg !174
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !175 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !179, metadata !DIExpression()), !dbg !180
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !181, metadata !DIExpression()), !dbg !180
  %5 = load ptr, ptr %3, align 8, !dbg !180
  %6 = load i32, ptr %4, align 4, !dbg !180
  call void asm sideeffect "movl $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6) #7, !dbg !180, !srcloc !182
  ret void, !dbg !180
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @_ck_epoch_addref(ptr noundef %0, ptr noundef %1) #0 !dbg !183 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !186, metadata !DIExpression()), !dbg !187
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !188, metadata !DIExpression()), !dbg !189
  call void @llvm.dbg.declare(metadata ptr %5, metadata !190, metadata !DIExpression()), !dbg !191
  %9 = load ptr, ptr %3, align 8, !dbg !192
  %10 = getelementptr inbounds %struct.ck_epoch_record, ptr %9, i32 0, i32 1, !dbg !193
  %11 = load ptr, ptr %10, align 8, !dbg !193
  store ptr %11, ptr %5, align 8, !dbg !191
  call void @llvm.dbg.declare(metadata ptr %6, metadata !194, metadata !DIExpression()), !dbg !195
  call void @llvm.dbg.declare(metadata ptr %7, metadata !196, metadata !DIExpression()), !dbg !197
  call void @llvm.dbg.declare(metadata ptr %8, metadata !198, metadata !DIExpression()), !dbg !199
  %12 = load ptr, ptr %5, align 8, !dbg !200
  %13 = getelementptr inbounds %struct.ck_epoch, ptr %12, i32 0, i32 0, !dbg !200
  %14 = call i32 @ck_pr_md_load_uint(ptr noundef %13), !dbg !200
  store i32 %14, ptr %7, align 4, !dbg !201
  %15 = load i32, ptr %7, align 4, !dbg !202
  %16 = and i32 %15, 1, !dbg !203
  store i32 %16, ptr %8, align 4, !dbg !204
  %17 = load ptr, ptr %3, align 8, !dbg !205
  %18 = getelementptr inbounds %struct.ck_epoch_record, ptr %17, i32 0, i32 6, !dbg !206
  %19 = getelementptr inbounds %struct.anon, ptr %18, i32 0, i32 0, !dbg !207
  %20 = load i32, ptr %8, align 4, !dbg !208
  %21 = zext i32 %20 to i64, !dbg !205
  %22 = getelementptr inbounds [2 x %struct.ck_epoch_ref], ptr %19, i64 0, i64 %21, !dbg !205
  store ptr %22, ptr %6, align 8, !dbg !209
  %23 = load ptr, ptr %6, align 8, !dbg !210
  %24 = getelementptr inbounds %struct.ck_epoch_ref, ptr %23, i32 0, i32 1, !dbg !212
  %25 = load i32, ptr %24, align 4, !dbg !213
  %26 = add i32 %25, 1, !dbg !213
  store i32 %26, ptr %24, align 4, !dbg !213
  %27 = icmp eq i32 %25, 0, !dbg !214
  br i1 %27, label %28, label %32, !dbg !215

28:                                               ; preds = %2
  %29 = load i32, ptr %7, align 4, !dbg !216
  %30 = load ptr, ptr %6, align 8, !dbg !218
  %31 = getelementptr inbounds %struct.ck_epoch_ref, ptr %30, i32 0, i32 0, !dbg !219
  store i32 %29, ptr %31, align 4, !dbg !220
  br label %32, !dbg !221

32:                                               ; preds = %28, %2
  %33 = load i32, ptr %8, align 4, !dbg !222
  %34 = load ptr, ptr %4, align 8, !dbg !223
  %35 = getelementptr inbounds %struct.ck_epoch_section, ptr %34, i32 0, i32 0, !dbg !224
  store i32 %33, ptr %35, align 4, !dbg !225
  ret void, !dbg !226
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_md_load_uint(ptr noundef %0) #0 !dbg !227 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !230, metadata !DIExpression()), !dbg !231
  call void @llvm.dbg.declare(metadata ptr %3, metadata !232, metadata !DIExpression()), !dbg !231
  %4 = load ptr, ptr %2, align 8, !dbg !231
  %5 = call i32 asm sideeffect "movl $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %4) #7, !dbg !231, !srcloc !233
  store i32 %5, ptr %3, align 4, !dbg !231
  %6 = load i32, ptr %3, align 4, !dbg !231
  ret i32 %6, !dbg !231
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_init(ptr noundef %0) #0 !dbg !234 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !237, metadata !DIExpression()), !dbg !238
  %3 = load ptr, ptr %2, align 8, !dbg !239
  %4 = getelementptr inbounds %struct.ck_epoch, ptr %3, i32 0, i32 2, !dbg !240
  call void @ck_stack_init(ptr noundef %4), !dbg !241
  %5 = load ptr, ptr %2, align 8, !dbg !242
  %6 = getelementptr inbounds %struct.ck_epoch, ptr %5, i32 0, i32 0, !dbg !243
  store i32 1, ptr %6, align 8, !dbg !244
  %7 = load ptr, ptr %2, align 8, !dbg !245
  %8 = getelementptr inbounds %struct.ck_epoch, ptr %7, i32 0, i32 1, !dbg !246
  store i32 0, ptr %8, align 4, !dbg !247
  call void @ck_pr_fence_store(), !dbg !248
  ret void, !dbg !249
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_stack_init(ptr noundef %0) #0 !dbg !250 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !254, metadata !DIExpression()), !dbg !255
  %3 = load ptr, ptr %2, align 8, !dbg !256
  %4 = getelementptr inbounds %struct.ck_stack, ptr %3, i32 0, i32 0, !dbg !257
  store ptr null, ptr %4, align 8, !dbg !258
  %5 = load ptr, ptr %2, align 8, !dbg !259
  %6 = getelementptr inbounds %struct.ck_stack, ptr %5, i32 0, i32 1, !dbg !260
  store ptr null, ptr %6, align 8, !dbg !261
  ret void, !dbg !262
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_store() #0 !dbg !263 {
  call void @ck_pr_barrier(), !dbg !267
  ret void, !dbg !267
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local ptr @ck_epoch_recycle(ptr noundef %0, ptr noundef %1) #0 !dbg !268 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !271, metadata !DIExpression()), !dbg !272
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !273, metadata !DIExpression()), !dbg !274
  call void @llvm.dbg.declare(metadata ptr %6, metadata !275, metadata !DIExpression()), !dbg !276
  call void @llvm.dbg.declare(metadata ptr %7, metadata !277, metadata !DIExpression()), !dbg !279
  call void @llvm.dbg.declare(metadata ptr %8, metadata !280, metadata !DIExpression()), !dbg !281
  %9 = load ptr, ptr %4, align 8, !dbg !282
  %10 = getelementptr inbounds %struct.ck_epoch, ptr %9, i32 0, i32 1, !dbg !282
  %11 = call i32 @ck_pr_md_load_uint(ptr noundef %10), !dbg !282
  %12 = icmp eq i32 %11, 0, !dbg !284
  br i1 %12, label %13, label %14, !dbg !285

13:                                               ; preds = %2
  store ptr null, ptr %3, align 8, !dbg !286
  br label %49, !dbg !286

14:                                               ; preds = %2
  %15 = load ptr, ptr %4, align 8, !dbg !287
  %16 = getelementptr inbounds %struct.ck_epoch, ptr %15, i32 0, i32 2, !dbg !287
  %17 = getelementptr inbounds %struct.ck_stack, ptr %16, i32 0, i32 0, !dbg !287
  %18 = load ptr, ptr %17, align 8, !dbg !287
  store ptr %18, ptr %7, align 8, !dbg !287
  br label %19, !dbg !287

19:                                               ; preds = %44, %14
  %20 = load ptr, ptr %7, align 8, !dbg !289
  %21 = icmp ne ptr %20, null, !dbg !289
  br i1 %21, label %22, label %48, !dbg !287

22:                                               ; preds = %19
  %23 = load ptr, ptr %7, align 8, !dbg !291
  %24 = call ptr @ck_epoch_record_container(ptr noundef %23), !dbg !293
  store ptr %24, ptr %6, align 8, !dbg !294
  %25 = load ptr, ptr %6, align 8, !dbg !295
  %26 = getelementptr inbounds %struct.ck_epoch_record, ptr %25, i32 0, i32 2, !dbg !295
  %27 = call i32 @ck_pr_md_load_uint(ptr noundef %26), !dbg !295
  %28 = icmp eq i32 %27, 1, !dbg !297
  br i1 %28, label %29, label %43, !dbg !298

29:                                               ; preds = %22
  call void @ck_pr_fence_load(), !dbg !299
  %30 = load ptr, ptr %6, align 8, !dbg !301
  %31 = getelementptr inbounds %struct.ck_epoch_record, ptr %30, i32 0, i32 2, !dbg !302
  %32 = call i32 @ck_pr_fas_uint(ptr noundef %31, i32 noundef 0), !dbg !303
  store i32 %32, ptr %8, align 4, !dbg !304
  %33 = load i32, ptr %8, align 4, !dbg !305
  %34 = icmp eq i32 %33, 1, !dbg !307
  br i1 %34, label %35, label %42, !dbg !308

35:                                               ; preds = %29
  %36 = load ptr, ptr %4, align 8, !dbg !309
  %37 = getelementptr inbounds %struct.ck_epoch, ptr %36, i32 0, i32 1, !dbg !311
  call void @ck_pr_dec_uint(ptr noundef %37), !dbg !312
  %38 = load ptr, ptr %6, align 8, !dbg !313
  %39 = getelementptr inbounds %struct.ck_epoch_record, ptr %38, i32 0, i32 10, !dbg !313
  %40 = load ptr, ptr %5, align 8, !dbg !313
  call void @ck_pr_md_store_ptr(ptr noundef %39, ptr noundef %40), !dbg !313
  %41 = load ptr, ptr %6, align 8, !dbg !314
  store ptr %41, ptr %3, align 8, !dbg !315
  br label %49, !dbg !315

42:                                               ; preds = %29
  br label %43, !dbg !316

43:                                               ; preds = %42, %22
  br label %44, !dbg !317

44:                                               ; preds = %43
  %45 = load ptr, ptr %7, align 8, !dbg !289
  %46 = getelementptr inbounds %struct.ck_stack_entry, ptr %45, i32 0, i32 0, !dbg !289
  %47 = load ptr, ptr %46, align 8, !dbg !289
  store ptr %47, ptr %7, align 8, !dbg !289
  br label %19, !dbg !289, !llvm.loop !318

48:                                               ; preds = %19
  store ptr null, ptr %3, align 8, !dbg !321
  br label %49, !dbg !321

49:                                               ; preds = %48, %35, %13
  %50 = load ptr, ptr %3, align 8, !dbg !322
  ret ptr %50, !dbg !322
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_epoch_record_container(ptr noundef %0) #0 !dbg !323 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !326, metadata !DIExpression()), !dbg !327
  %3 = load ptr, ptr %2, align 8, !dbg !327
  %4 = getelementptr inbounds i8, ptr %3, i64 0, !dbg !327
  ret ptr %4, !dbg !327
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_load() #0 !dbg !328 {
  call void @ck_pr_barrier(), !dbg !329
  ret void, !dbg !329
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_pr_fas_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !330 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !333, metadata !DIExpression()), !dbg !334
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !335, metadata !DIExpression()), !dbg !334
  %5 = load ptr, ptr %3, align 8, !dbg !334
  %6 = load i32, ptr %4, align 4, !dbg !334
  %7 = call i32 asm sideeffect "xchgl $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, ptr elementtype(i32) %5, i32 %6) #7, !dbg !334, !srcloc !336
  store i32 %7, ptr %4, align 4, !dbg !334
  %8 = load i32, ptr %4, align 4, !dbg !334
  ret i32 %8, !dbg !334
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_dec_uint(ptr noundef %0) #0 !dbg !337 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !340, metadata !DIExpression()), !dbg !341
  %3 = load ptr, ptr %2, align 8, !dbg !341
  call void asm sideeffect "lock decl $0", "=*m,*m,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %3, ptr elementtype(i32) %3) #7, !dbg !341, !srcloc !342
  ret void, !dbg !341
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_md_store_ptr(ptr noundef %0, ptr noundef %1) #0 !dbg !343 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !348, metadata !DIExpression()), !dbg !349
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !350, metadata !DIExpression()), !dbg !349
  %5 = load ptr, ptr %3, align 8, !dbg !349
  %6 = load ptr, ptr %4, align 8, !dbg !349
  call void asm sideeffect "movq $1, $0", "=*m,Zq,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %5, ptr %6) #7, !dbg !349, !srcloc !351
  ret void, !dbg !349
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_register(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !352 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !355, metadata !DIExpression()), !dbg !356
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !357, metadata !DIExpression()), !dbg !358
  store ptr %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !359, metadata !DIExpression()), !dbg !360
  call void @llvm.dbg.declare(metadata ptr %7, metadata !361, metadata !DIExpression()), !dbg !364
  %8 = load ptr, ptr %4, align 8, !dbg !365
  %9 = load ptr, ptr %5, align 8, !dbg !366
  %10 = getelementptr inbounds %struct.ck_epoch_record, ptr %9, i32 0, i32 1, !dbg !367
  store ptr %8, ptr %10, align 8, !dbg !368
  %11 = load ptr, ptr %5, align 8, !dbg !369
  %12 = getelementptr inbounds %struct.ck_epoch_record, ptr %11, i32 0, i32 2, !dbg !370
  store i32 0, ptr %12, align 16, !dbg !371
  %13 = load ptr, ptr %5, align 8, !dbg !372
  %14 = getelementptr inbounds %struct.ck_epoch_record, ptr %13, i32 0, i32 4, !dbg !373
  store i32 0, ptr %14, align 8, !dbg !374
  %15 = load ptr, ptr %5, align 8, !dbg !375
  %16 = getelementptr inbounds %struct.ck_epoch_record, ptr %15, i32 0, i32 3, !dbg !376
  store i32 0, ptr %16, align 4, !dbg !377
  %17 = load ptr, ptr %5, align 8, !dbg !378
  %18 = getelementptr inbounds %struct.ck_epoch_record, ptr %17, i32 0, i32 9, !dbg !379
  store i32 0, ptr %18, align 8, !dbg !380
  %19 = load ptr, ptr %5, align 8, !dbg !381
  %20 = getelementptr inbounds %struct.ck_epoch_record, ptr %19, i32 0, i32 8, !dbg !382
  store i32 0, ptr %20, align 4, !dbg !383
  %21 = load ptr, ptr %5, align 8, !dbg !384
  %22 = getelementptr inbounds %struct.ck_epoch_record, ptr %21, i32 0, i32 7, !dbg !385
  store i32 0, ptr %22, align 16, !dbg !386
  %23 = load ptr, ptr %6, align 8, !dbg !387
  %24 = load ptr, ptr %5, align 8, !dbg !388
  %25 = getelementptr inbounds %struct.ck_epoch_record, ptr %24, i32 0, i32 10, !dbg !389
  store ptr %23, ptr %25, align 32, !dbg !390
  %26 = load ptr, ptr %5, align 8, !dbg !391
  %27 = getelementptr inbounds %struct.ck_epoch_record, ptr %26, i32 0, i32 6, !dbg !392
  call void @llvm.memset.p0.i64(ptr align 64 %27, i8 0, i64 16, i1 false), !dbg !393
  store i64 0, ptr %7, align 8, !dbg !394
  br label %28, !dbg !396

28:                                               ; preds = %36, %3
  %29 = load i64, ptr %7, align 8, !dbg !397
  %30 = icmp ult i64 %29, 4, !dbg !399
  br i1 %30, label %31, label %39, !dbg !400

31:                                               ; preds = %28
  %32 = load ptr, ptr %5, align 8, !dbg !401
  %33 = getelementptr inbounds %struct.ck_epoch_record, ptr %32, i32 0, i32 11, !dbg !402
  %34 = load i64, ptr %7, align 8, !dbg !403
  %35 = getelementptr inbounds [4 x %struct.ck_stack], ptr %33, i64 0, i64 %34, !dbg !401
  call void @ck_stack_init(ptr noundef %35), !dbg !404
  br label %36, !dbg !404

36:                                               ; preds = %31
  %37 = load i64, ptr %7, align 8, !dbg !405
  %38 = add i64 %37, 1, !dbg !405
  store i64 %38, ptr %7, align 8, !dbg !405
  br label %28, !dbg !406, !llvm.loop !407

39:                                               ; preds = %28
  call void @ck_pr_fence_store(), !dbg !409
  %40 = load ptr, ptr %4, align 8, !dbg !410
  %41 = getelementptr inbounds %struct.ck_epoch, ptr %40, i32 0, i32 2, !dbg !411
  %42 = load ptr, ptr %5, align 8, !dbg !412
  %43 = getelementptr inbounds %struct.ck_epoch_record, ptr %42, i32 0, i32 0, !dbg !413
  call void @ck_stack_push_upmc(ptr noundef %41, ptr noundef %43), !dbg !414
  ret void, !dbg !415
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_stack_push_upmc(ptr noundef %0, ptr noundef %1) #0 !dbg !416 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !419, metadata !DIExpression()), !dbg !420
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !421, metadata !DIExpression()), !dbg !422
  call void @llvm.dbg.declare(metadata ptr %5, metadata !423, metadata !DIExpression()), !dbg !424
  %6 = load ptr, ptr %3, align 8, !dbg !425
  %7 = getelementptr inbounds %struct.ck_stack, ptr %6, i32 0, i32 0, !dbg !425
  %8 = call ptr @ck_pr_md_load_ptr(ptr noundef %7), !dbg !425
  store ptr %8, ptr %5, align 8, !dbg !426
  %9 = load ptr, ptr %5, align 8, !dbg !427
  %10 = load ptr, ptr %4, align 8, !dbg !428
  %11 = getelementptr inbounds %struct.ck_stack_entry, ptr %10, i32 0, i32 0, !dbg !429
  store ptr %9, ptr %11, align 8, !dbg !430
  call void @ck_pr_fence_store(), !dbg !431
  br label %12, !dbg !432

12:                                               ; preds = %20, %2
  %13 = load ptr, ptr %3, align 8, !dbg !433
  %14 = getelementptr inbounds %struct.ck_stack, ptr %13, i32 0, i32 0, !dbg !434
  %15 = load ptr, ptr %5, align 8, !dbg !435
  %16 = load ptr, ptr %4, align 8, !dbg !436
  %17 = call zeroext i1 @ck_pr_cas_ptr_value(ptr noundef %14, ptr noundef %15, ptr noundef %16, ptr noundef %5), !dbg !437
  %18 = zext i1 %17 to i32, !dbg !437
  %19 = icmp eq i32 %18, 0, !dbg !438
  br i1 %19, label %20, label %24, !dbg !432

20:                                               ; preds = %12
  %21 = load ptr, ptr %5, align 8, !dbg !439
  %22 = load ptr, ptr %4, align 8, !dbg !441
  %23 = getelementptr inbounds %struct.ck_stack_entry, ptr %22, i32 0, i32 0, !dbg !442
  store ptr %21, ptr %23, align 8, !dbg !443
  call void @ck_pr_fence_store(), !dbg !444
  br label %12, !dbg !432, !llvm.loop !445

24:                                               ; preds = %12
  ret void, !dbg !447
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_unregister(ptr noundef %0) #0 !dbg !448 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !451, metadata !DIExpression()), !dbg !452
  call void @llvm.dbg.declare(metadata ptr %3, metadata !453, metadata !DIExpression()), !dbg !454
  %5 = load ptr, ptr %2, align 8, !dbg !455
  %6 = getelementptr inbounds %struct.ck_epoch_record, ptr %5, i32 0, i32 1, !dbg !456
  %7 = load ptr, ptr %6, align 8, !dbg !456
  store ptr %7, ptr %3, align 8, !dbg !454
  call void @llvm.dbg.declare(metadata ptr %4, metadata !457, metadata !DIExpression()), !dbg !458
  %8 = load ptr, ptr %2, align 8, !dbg !459
  %9 = getelementptr inbounds %struct.ck_epoch_record, ptr %8, i32 0, i32 4, !dbg !460
  store i32 0, ptr %9, align 8, !dbg !461
  %10 = load ptr, ptr %2, align 8, !dbg !462
  %11 = getelementptr inbounds %struct.ck_epoch_record, ptr %10, i32 0, i32 3, !dbg !463
  store i32 0, ptr %11, align 4, !dbg !464
  %12 = load ptr, ptr %2, align 8, !dbg !465
  %13 = getelementptr inbounds %struct.ck_epoch_record, ptr %12, i32 0, i32 9, !dbg !466
  store i32 0, ptr %13, align 8, !dbg !467
  %14 = load ptr, ptr %2, align 8, !dbg !468
  %15 = getelementptr inbounds %struct.ck_epoch_record, ptr %14, i32 0, i32 8, !dbg !469
  store i32 0, ptr %15, align 4, !dbg !470
  %16 = load ptr, ptr %2, align 8, !dbg !471
  %17 = getelementptr inbounds %struct.ck_epoch_record, ptr %16, i32 0, i32 7, !dbg !472
  store i32 0, ptr %17, align 16, !dbg !473
  %18 = load ptr, ptr %2, align 8, !dbg !474
  %19 = getelementptr inbounds %struct.ck_epoch_record, ptr %18, i32 0, i32 6, !dbg !475
  call void @llvm.memset.p0.i64(ptr align 64 %19, i8 0, i64 16, i1 false), !dbg !476
  store i64 0, ptr %4, align 8, !dbg !477
  br label %20, !dbg !479

20:                                               ; preds = %28, %1
  %21 = load i64, ptr %4, align 8, !dbg !480
  %22 = icmp ult i64 %21, 4, !dbg !482
  br i1 %22, label %23, label %31, !dbg !483

23:                                               ; preds = %20
  %24 = load ptr, ptr %2, align 8, !dbg !484
  %25 = getelementptr inbounds %struct.ck_epoch_record, ptr %24, i32 0, i32 11, !dbg !485
  %26 = load i64, ptr %4, align 8, !dbg !486
  %27 = getelementptr inbounds [4 x %struct.ck_stack], ptr %25, i64 0, i64 %26, !dbg !484
  call void @ck_stack_init(ptr noundef %27), !dbg !487
  br label %28, !dbg !487

28:                                               ; preds = %23
  %29 = load i64, ptr %4, align 8, !dbg !488
  %30 = add i64 %29, 1, !dbg !488
  store i64 %30, ptr %4, align 8, !dbg !488
  br label %20, !dbg !489, !llvm.loop !490

31:                                               ; preds = %20
  %32 = load ptr, ptr %2, align 8, !dbg !492
  %33 = getelementptr inbounds %struct.ck_epoch_record, ptr %32, i32 0, i32 10, !dbg !492
  call void @ck_pr_md_store_ptr(ptr noundef %33, ptr noundef null), !dbg !492
  call void @ck_pr_fence_store(), !dbg !493
  %34 = load ptr, ptr %2, align 8, !dbg !494
  %35 = getelementptr inbounds %struct.ck_epoch_record, ptr %34, i32 0, i32 2, !dbg !494
  call void @ck_pr_md_store_uint(ptr noundef %35, i32 noundef 1), !dbg !494
  %36 = load ptr, ptr %3, align 8, !dbg !495
  %37 = getelementptr inbounds %struct.ck_epoch, ptr %36, i32 0, i32 1, !dbg !496
  call void @ck_pr_inc_uint(ptr noundef %37), !dbg !497
  ret void, !dbg !498
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_inc_uint(ptr noundef %0) #0 !dbg !499 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !500, metadata !DIExpression()), !dbg !501
  %3 = load ptr, ptr %2, align 8, !dbg !501
  call void asm sideeffect "lock incl $0", "=*m,*m,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %3, ptr elementtype(i32) %3) #7, !dbg !501, !srcloc !502
  ret void, !dbg !501
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_reclaim(ptr noundef %0) #0 !dbg !503 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !504, metadata !DIExpression()), !dbg !505
  call void @llvm.dbg.declare(metadata ptr %3, metadata !506, metadata !DIExpression()), !dbg !507
  store i32 0, ptr %3, align 4, !dbg !508
  br label %4, !dbg !510

4:                                                ; preds = %11, %1
  %5 = load i32, ptr %3, align 4, !dbg !511
  %6 = icmp ult i32 %5, 4, !dbg !513
  br i1 %6, label %7, label %14, !dbg !514

7:                                                ; preds = %4
  %8 = load ptr, ptr %2, align 8, !dbg !515
  %9 = load i32, ptr %3, align 4, !dbg !516
  %10 = call i32 @ck_epoch_dispatch(ptr noundef %8, i32 noundef %9, ptr noundef null), !dbg !517
  br label %11, !dbg !517

11:                                               ; preds = %7
  %12 = load i32, ptr %3, align 4, !dbg !518
  %13 = add i32 %12, 1, !dbg !518
  store i32 %13, ptr %3, align 4, !dbg !518
  br label %4, !dbg !519, !llvm.loop !520

14:                                               ; preds = %4
  ret void, !dbg !522
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @ck_epoch_dispatch(ptr noundef %0, i32 noundef %1, ptr noundef %2) #0 !dbg !523 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !527, metadata !DIExpression()), !dbg !528
  store i32 %1, ptr %5, align 4
  call void @llvm.dbg.declare(metadata ptr %5, metadata !529, metadata !DIExpression()), !dbg !530
  store ptr %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !531, metadata !DIExpression()), !dbg !532
  call void @llvm.dbg.declare(metadata ptr %7, metadata !533, metadata !DIExpression()), !dbg !534
  %15 = load i32, ptr %5, align 4, !dbg !535
  %16 = and i32 %15, 3, !dbg !536
  store i32 %16, ptr %7, align 4, !dbg !534
  call void @llvm.dbg.declare(metadata ptr %8, metadata !537, metadata !DIExpression()), !dbg !538
  call void @llvm.dbg.declare(metadata ptr %9, metadata !539, metadata !DIExpression()), !dbg !540
  call void @llvm.dbg.declare(metadata ptr %10, metadata !541, metadata !DIExpression()), !dbg !542
  call void @llvm.dbg.declare(metadata ptr %11, metadata !543, metadata !DIExpression()), !dbg !544
  call void @llvm.dbg.declare(metadata ptr %12, metadata !545, metadata !DIExpression()), !dbg !546
  call void @llvm.dbg.declare(metadata ptr %13, metadata !547, metadata !DIExpression()), !dbg !548
  store i32 0, ptr %13, align 4, !dbg !548
  %17 = load ptr, ptr %4, align 8, !dbg !549
  %18 = getelementptr inbounds %struct.ck_epoch_record, ptr %17, i32 0, i32 11, !dbg !550
  %19 = load i32, ptr %7, align 4, !dbg !551
  %20 = zext i32 %19 to i64, !dbg !549
  %21 = getelementptr inbounds [4 x %struct.ck_stack], ptr %18, i64 0, i64 %20, !dbg !549
  %22 = call ptr @ck_stack_batch_pop_upmc(ptr noundef %21), !dbg !552
  store ptr %22, ptr %8, align 8, !dbg !553
  %23 = load ptr, ptr %8, align 8, !dbg !554
  store ptr %23, ptr %10, align 8, !dbg !556
  br label %24, !dbg !557

24:                                               ; preds = %47, %3
  %25 = load ptr, ptr %10, align 8, !dbg !558
  %26 = icmp ne ptr %25, null, !dbg !560
  br i1 %26, label %27, label %49, !dbg !561

27:                                               ; preds = %24
  call void @llvm.dbg.declare(metadata ptr %14, metadata !562, metadata !DIExpression()), !dbg !564
  %28 = load ptr, ptr %10, align 8, !dbg !565
  %29 = call ptr @ck_epoch_entry_container(ptr noundef %28), !dbg !566
  store ptr %29, ptr %14, align 8, !dbg !564
  %30 = load ptr, ptr %10, align 8, !dbg !567
  %31 = getelementptr inbounds %struct.ck_stack_entry, ptr %30, i32 0, i32 0, !dbg !567
  %32 = load ptr, ptr %31, align 8, !dbg !567
  store ptr %32, ptr %9, align 8, !dbg !568
  %33 = load ptr, ptr %6, align 8, !dbg !569
  %34 = icmp ne ptr %33, null, !dbg !571
  br i1 %34, label %35, label %39, !dbg !572

35:                                               ; preds = %27
  %36 = load ptr, ptr %6, align 8, !dbg !573
  %37 = load ptr, ptr %14, align 8, !dbg !574
  %38 = getelementptr inbounds %struct.ck_epoch_entry, ptr %37, i32 0, i32 1, !dbg !575
  call void @ck_stack_push_spnc(ptr noundef %36, ptr noundef %38), !dbg !576
  br label %44, !dbg !576

39:                                               ; preds = %27
  %40 = load ptr, ptr %14, align 8, !dbg !577
  %41 = getelementptr inbounds %struct.ck_epoch_entry, ptr %40, i32 0, i32 0, !dbg !578
  %42 = load ptr, ptr %41, align 8, !dbg !578
  %43 = load ptr, ptr %14, align 8, !dbg !579
  call void %42(ptr noundef %43), !dbg !577
  br label %44

44:                                               ; preds = %39, %35
  %45 = load i32, ptr %13, align 4, !dbg !580
  %46 = add i32 %45, 1, !dbg !580
  store i32 %46, ptr %13, align 4, !dbg !580
  br label %47, !dbg !581

47:                                               ; preds = %44
  %48 = load ptr, ptr %9, align 8, !dbg !582
  store ptr %48, ptr %10, align 8, !dbg !583
  br label %24, !dbg !584, !llvm.loop !585

49:                                               ; preds = %24
  %50 = load ptr, ptr %4, align 8, !dbg !587
  %51 = getelementptr inbounds %struct.ck_epoch_record, ptr %50, i32 0, i32 8, !dbg !587
  %52 = call i32 @ck_pr_md_load_uint(ptr noundef %51), !dbg !587
  store i32 %52, ptr %12, align 4, !dbg !588
  %53 = load ptr, ptr %4, align 8, !dbg !589
  %54 = getelementptr inbounds %struct.ck_epoch_record, ptr %53, i32 0, i32 7, !dbg !589
  %55 = call i32 @ck_pr_md_load_uint(ptr noundef %54), !dbg !589
  store i32 %55, ptr %11, align 4, !dbg !590
  %56 = load i32, ptr %11, align 4, !dbg !591
  %57 = load i32, ptr %12, align 4, !dbg !593
  %58 = icmp ugt i32 %56, %57, !dbg !594
  br i1 %58, label %59, label %63, !dbg !595

59:                                               ; preds = %49
  %60 = load ptr, ptr %4, align 8, !dbg !596
  %61 = getelementptr inbounds %struct.ck_epoch_record, ptr %60, i32 0, i32 8, !dbg !596
  %62 = load i32, ptr %12, align 4, !dbg !596
  call void @ck_pr_md_store_uint(ptr noundef %61, i32 noundef %62), !dbg !596
  br label %63, !dbg !596

63:                                               ; preds = %59, %49
  %64 = load i32, ptr %13, align 4, !dbg !597
  %65 = icmp ugt i32 %64, 0, !dbg !599
  br i1 %65, label %66, label %73, !dbg !600

66:                                               ; preds = %63
  %67 = load ptr, ptr %4, align 8, !dbg !601
  %68 = getelementptr inbounds %struct.ck_epoch_record, ptr %67, i32 0, i32 9, !dbg !603
  %69 = load i32, ptr %13, align 4, !dbg !604
  call void @ck_pr_add_uint(ptr noundef %68, i32 noundef %69), !dbg !605
  %70 = load ptr, ptr %4, align 8, !dbg !606
  %71 = getelementptr inbounds %struct.ck_epoch_record, ptr %70, i32 0, i32 7, !dbg !607
  %72 = load i32, ptr %13, align 4, !dbg !608
  call void @ck_pr_sub_uint(ptr noundef %71, i32 noundef %72), !dbg !609
  br label %73, !dbg !610

73:                                               ; preds = %66, %63
  %74 = load i32, ptr %13, align 4, !dbg !611
  ret i32 %74, !dbg !612
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_synchronize_wait(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !613 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca ptr, align 8
  %14 = alloca ptr, align 8
  %15 = alloca ptr, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  %19 = alloca i32, align 4
  %20 = alloca i8, align 1
  %21 = alloca i8, align 1
  %22 = alloca i32, align 4
  store ptr %0, ptr %12, align 8
  call void @llvm.dbg.declare(metadata ptr %12, metadata !621, metadata !DIExpression()), !dbg !622
  store ptr %1, ptr %13, align 8
  call void @llvm.dbg.declare(metadata ptr %13, metadata !623, metadata !DIExpression()), !dbg !624
  store ptr %2, ptr %14, align 8
  call void @llvm.dbg.declare(metadata ptr %14, metadata !625, metadata !DIExpression()), !dbg !626
  call void @llvm.dbg.declare(metadata ptr %15, metadata !627, metadata !DIExpression()), !dbg !628
  call void @llvm.dbg.declare(metadata ptr %16, metadata !629, metadata !DIExpression()), !dbg !630
  call void @llvm.dbg.declare(metadata ptr %17, metadata !631, metadata !DIExpression()), !dbg !632
  call void @llvm.dbg.declare(metadata ptr %18, metadata !633, metadata !DIExpression()), !dbg !634
  call void @llvm.dbg.declare(metadata ptr %19, metadata !635, metadata !DIExpression()), !dbg !636
  call void @llvm.dbg.declare(metadata ptr %20, metadata !637, metadata !DIExpression()), !dbg !638
  call void @ck_pr_fence_memory(), !dbg !639
  %23 = load ptr, ptr %12, align 8, !dbg !640
  %24 = getelementptr inbounds %struct.ck_epoch, ptr %23, i32 0, i32 0, !dbg !640
  %25 = call i32 @ck_pr_md_load_uint(ptr noundef %24), !dbg !640
  store i32 %25, ptr %17, align 4, !dbg !641
  store i32 %25, ptr %16, align 4, !dbg !642
  %26 = load i32, ptr %17, align 4, !dbg !643
  %27 = add i32 %26, 3, !dbg !644
  store i32 %27, ptr %18, align 4, !dbg !645
  store i32 0, ptr %19, align 4, !dbg !646
  store ptr null, ptr %15, align 8, !dbg !648
  br label %28, !dbg !649

28:                                               ; preds = %104, %3
  %29 = load i32, ptr %19, align 4, !dbg !650
  %30 = icmp ult i32 %29, 2, !dbg !652
  br i1 %30, label %31, label %107, !dbg !653

31:                                               ; preds = %28
  call void @llvm.dbg.declare(metadata ptr %21, metadata !654, metadata !DIExpression()), !dbg !656
  br label %32, !dbg !657

32:                                               ; preds = %84, %58, %31
  %33 = load ptr, ptr %12, align 8, !dbg !658
  %34 = load ptr, ptr %15, align 8, !dbg !659
  %35 = load i32, ptr %16, align 4, !dbg !660
  %36 = call ptr @ck_epoch_scan(ptr noundef %33, ptr noundef %34, i32 noundef %35, ptr noundef %20), !dbg !661
  store ptr %36, ptr %15, align 8, !dbg !662
  %37 = load ptr, ptr %15, align 8, !dbg !663
  %38 = icmp ne ptr %37, null, !dbg !664
  br i1 %38, label %39, label %85, !dbg !657

39:                                               ; preds = %32
  call void @llvm.dbg.declare(metadata ptr %22, metadata !665, metadata !DIExpression()), !dbg !667
  call void @ck_pr_stall(), !dbg !668
  %40 = load ptr, ptr %12, align 8, !dbg !669
  %41 = getelementptr inbounds %struct.ck_epoch, ptr %40, i32 0, i32 0, !dbg !669
  %42 = call i32 @ck_pr_md_load_uint(ptr noundef %41), !dbg !669
  store i32 %42, ptr %22, align 4, !dbg !670
  %43 = load i32, ptr %22, align 4, !dbg !671
  %44 = load i32, ptr %16, align 4, !dbg !673
  %45 = icmp eq i32 %43, %44, !dbg !674
  br i1 %45, label %46, label %59, !dbg !675

46:                                               ; preds = %39
  %47 = load ptr, ptr %12, align 8, !dbg !676
  %48 = load ptr, ptr %15, align 8, !dbg !678
  %49 = load ptr, ptr %13, align 8, !dbg !679
  %50 = load ptr, ptr %14, align 8, !dbg !680
  store ptr %47, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !681, metadata !DIExpression()), !dbg !685
  store ptr %48, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !687, metadata !DIExpression()), !dbg !688
  store ptr %49, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !689, metadata !DIExpression()), !dbg !690
  store ptr %50, ptr %7, align 8
  call void @llvm.dbg.declare(metadata ptr %7, metadata !691, metadata !DIExpression()), !dbg !692
  %51 = load ptr, ptr %6, align 8, !dbg !693
  %52 = icmp ne ptr %51, null, !dbg !695
  br i1 %52, label %53, label %58, !dbg !696

53:                                               ; preds = %46
  %54 = load ptr, ptr %6, align 8, !dbg !697
  %55 = load ptr, ptr %4, align 8, !dbg !698
  %56 = load ptr, ptr %5, align 8, !dbg !699
  %57 = load ptr, ptr %7, align 8, !dbg !700
  call void %54(ptr noundef %55, ptr noundef %56, ptr noundef %57) #7, !dbg !697
  br label %58, !dbg !697

58:                                               ; preds = %46, %53
  br label %32, !dbg !701, !llvm.loop !702

59:                                               ; preds = %39
  %60 = load i32, ptr %22, align 4, !dbg !704
  store i32 %60, ptr %16, align 4, !dbg !705
  %61 = load i32, ptr %18, align 4, !dbg !706
  %62 = load i32, ptr %17, align 4, !dbg !708
  %63 = icmp ugt i32 %61, %62, !dbg !709
  %64 = zext i1 %63 to i32, !dbg !709
  %65 = load i32, ptr %16, align 4, !dbg !710
  %66 = load i32, ptr %18, align 4, !dbg !711
  %67 = icmp uge i32 %65, %66, !dbg !712
  %68 = zext i1 %67 to i32, !dbg !712
  %69 = and i32 %64, %68, !dbg !713
  %70 = icmp ne i32 %69, 0, !dbg !713
  br i1 %70, label %71, label %72, !dbg !714

71:                                               ; preds = %59
  br label %108, !dbg !715

72:                                               ; preds = %59
  %73 = load ptr, ptr %12, align 8, !dbg !716
  %74 = load ptr, ptr %15, align 8, !dbg !717
  %75 = load ptr, ptr %13, align 8, !dbg !718
  %76 = load ptr, ptr %14, align 8, !dbg !719
  store ptr %73, ptr %8, align 8
  call void @llvm.dbg.declare(metadata ptr %8, metadata !681, metadata !DIExpression()), !dbg !720
  store ptr %74, ptr %9, align 8
  call void @llvm.dbg.declare(metadata ptr %9, metadata !687, metadata !DIExpression()), !dbg !722
  store ptr %75, ptr %10, align 8
  call void @llvm.dbg.declare(metadata ptr %10, metadata !689, metadata !DIExpression()), !dbg !723
  store ptr %76, ptr %11, align 8
  call void @llvm.dbg.declare(metadata ptr %11, metadata !691, metadata !DIExpression()), !dbg !724
  %77 = load ptr, ptr %10, align 8, !dbg !725
  %78 = icmp ne ptr %77, null, !dbg !726
  br i1 %78, label %79, label %84, !dbg !727

79:                                               ; preds = %72
  %80 = load ptr, ptr %10, align 8, !dbg !728
  %81 = load ptr, ptr %8, align 8, !dbg !729
  %82 = load ptr, ptr %9, align 8, !dbg !730
  %83 = load ptr, ptr %11, align 8, !dbg !731
  call void %80(ptr noundef %81, ptr noundef %82, ptr noundef %83) #7, !dbg !728
  br label %84, !dbg !728

84:                                               ; preds = %72, %79
  store ptr null, ptr %15, align 8, !dbg !732
  br label %32, !dbg !657, !llvm.loop !702

85:                                               ; preds = %32
  %86 = load i8, ptr %20, align 1, !dbg !733
  %87 = trunc i8 %86 to i1, !dbg !733
  %88 = zext i1 %87 to i32, !dbg !733
  %89 = icmp eq i32 %88, 0, !dbg !735
  br i1 %89, label %90, label %91, !dbg !736

90:                                               ; preds = %85
  br label %107, !dbg !737

91:                                               ; preds = %85
  %92 = load ptr, ptr %12, align 8, !dbg !738
  %93 = getelementptr inbounds %struct.ck_epoch, ptr %92, i32 0, i32 0, !dbg !739
  %94 = load i32, ptr %16, align 4, !dbg !740
  %95 = load i32, ptr %16, align 4, !dbg !741
  %96 = add i32 %95, 1, !dbg !742
  %97 = call zeroext i1 @ck_pr_cas_uint_value(ptr noundef %93, i32 noundef %94, i32 noundef %96, ptr noundef %16), !dbg !743
  %98 = zext i1 %97 to i8, !dbg !744
  store i8 %98, ptr %21, align 1, !dbg !744
  call void @ck_pr_fence_atomic_load(), !dbg !745
  %99 = load i32, ptr %16, align 4, !dbg !746
  %100 = load i8, ptr %21, align 1, !dbg !747
  %101 = trunc i8 %100 to i1, !dbg !747
  %102 = zext i1 %101 to i32, !dbg !747
  %103 = add i32 %99, %102, !dbg !748
  store i32 %103, ptr %16, align 4, !dbg !749
  br label %104, !dbg !750

104:                                              ; preds = %91
  store ptr null, ptr %15, align 8, !dbg !751
  %105 = load i32, ptr %19, align 4, !dbg !752
  %106 = add i32 %105, 1, !dbg !752
  store i32 %106, ptr %19, align 4, !dbg !752
  br label %28, !dbg !753, !llvm.loop !754

107:                                              ; preds = %90, %28
  br label %108, !dbg !755

108:                                              ; preds = %107, %71
  call void @llvm.dbg.label(metadata !756), !dbg !757
  call void @ck_pr_fence_memory(), !dbg !758
  ret void, !dbg !759
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_memory() #0 !dbg !760 {
  call void @ck_pr_fence_strict_memory(), !dbg !761
  ret void, !dbg !761
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_epoch_scan(ptr noundef %0, ptr noundef %1, i32 noundef %2, ptr noundef %3) #0 !dbg !762 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !766, metadata !DIExpression()), !dbg !767
  store ptr %1, ptr %7, align 8
  call void @llvm.dbg.declare(metadata ptr %7, metadata !768, metadata !DIExpression()), !dbg !769
  store i32 %2, ptr %8, align 4
  call void @llvm.dbg.declare(metadata ptr %8, metadata !770, metadata !DIExpression()), !dbg !771
  store ptr %3, ptr %9, align 8
  call void @llvm.dbg.declare(metadata ptr %9, metadata !772, metadata !DIExpression()), !dbg !773
  call void @llvm.dbg.declare(metadata ptr %10, metadata !774, metadata !DIExpression()), !dbg !775
  %13 = load ptr, ptr %7, align 8, !dbg !776
  %14 = icmp eq ptr %13, null, !dbg !778
  br i1 %14, label %15, label %21, !dbg !779

15:                                               ; preds = %4
  %16 = load ptr, ptr %6, align 8, !dbg !780
  %17 = getelementptr inbounds %struct.ck_epoch, ptr %16, i32 0, i32 2, !dbg !780
  %18 = getelementptr inbounds %struct.ck_stack, ptr %17, i32 0, i32 0, !dbg !780
  %19 = load ptr, ptr %18, align 8, !dbg !780
  store ptr %19, ptr %10, align 8, !dbg !782
  %20 = load ptr, ptr %9, align 8, !dbg !783
  store i8 0, ptr %20, align 1, !dbg !784
  br label %25, !dbg !785

21:                                               ; preds = %4
  %22 = load ptr, ptr %7, align 8, !dbg !786
  %23 = getelementptr inbounds %struct.ck_epoch_record, ptr %22, i32 0, i32 0, !dbg !788
  store ptr %23, ptr %10, align 8, !dbg !789
  %24 = load ptr, ptr %9, align 8, !dbg !790
  store i8 1, ptr %24, align 1, !dbg !791
  br label %25

25:                                               ; preds = %21, %15
  br label %26, !dbg !792

26:                                               ; preds = %64, %38, %25
  %27 = load ptr, ptr %10, align 8, !dbg !793
  %28 = icmp ne ptr %27, null, !dbg !794
  br i1 %28, label %29, label %68, !dbg !792

29:                                               ; preds = %26
  call void @llvm.dbg.declare(metadata ptr %11, metadata !795, metadata !DIExpression()), !dbg !797
  call void @llvm.dbg.declare(metadata ptr %12, metadata !798, metadata !DIExpression()), !dbg !799
  %30 = load ptr, ptr %10, align 8, !dbg !800
  %31 = call ptr @ck_epoch_record_container(ptr noundef %30), !dbg !801
  store ptr %31, ptr %7, align 8, !dbg !802
  %32 = load ptr, ptr %7, align 8, !dbg !803
  %33 = getelementptr inbounds %struct.ck_epoch_record, ptr %32, i32 0, i32 2, !dbg !803
  %34 = call i32 @ck_pr_md_load_uint(ptr noundef %33), !dbg !803
  store i32 %34, ptr %11, align 4, !dbg !804
  %35 = load i32, ptr %11, align 4, !dbg !805
  %36 = and i32 %35, 1, !dbg !807
  %37 = icmp ne i32 %36, 0, !dbg !807
  br i1 %37, label %38, label %42, !dbg !808

38:                                               ; preds = %29
  %39 = load ptr, ptr %10, align 8, !dbg !809
  %40 = getelementptr inbounds %struct.ck_stack_entry, ptr %39, i32 0, i32 0, !dbg !809
  %41 = load ptr, ptr %40, align 8, !dbg !809
  store ptr %41, ptr %10, align 8, !dbg !811
  br label %26, !dbg !812, !llvm.loop !813

42:                                               ; preds = %29
  %43 = load ptr, ptr %7, align 8, !dbg !815
  %44 = getelementptr inbounds %struct.ck_epoch_record, ptr %43, i32 0, i32 4, !dbg !815
  %45 = call i32 @ck_pr_md_load_uint(ptr noundef %44), !dbg !815
  store i32 %45, ptr %12, align 4, !dbg !816
  %46 = load i32, ptr %12, align 4, !dbg !817
  %47 = load ptr, ptr %9, align 8, !dbg !818
  %48 = load i8, ptr %47, align 1, !dbg !819
  %49 = trunc i8 %48 to i1, !dbg !819
  %50 = zext i1 %49 to i32, !dbg !819
  %51 = or i32 %50, %46, !dbg !819
  %52 = icmp ne i32 %51, 0, !dbg !819
  %53 = zext i1 %52 to i8, !dbg !819
  store i8 %53, ptr %47, align 1, !dbg !819
  %54 = load i32, ptr %12, align 4, !dbg !820
  %55 = icmp ne i32 %54, 0, !dbg !822
  br i1 %55, label %56, label %64, !dbg !823

56:                                               ; preds = %42
  %57 = load ptr, ptr %7, align 8, !dbg !824
  %58 = getelementptr inbounds %struct.ck_epoch_record, ptr %57, i32 0, i32 3, !dbg !824
  %59 = call i32 @ck_pr_md_load_uint(ptr noundef %58), !dbg !824
  %60 = load i32, ptr %8, align 4, !dbg !825
  %61 = icmp ne i32 %59, %60, !dbg !826
  br i1 %61, label %62, label %64, !dbg !827

62:                                               ; preds = %56
  %63 = load ptr, ptr %7, align 8, !dbg !828
  store ptr %63, ptr %5, align 8, !dbg !829
  br label %69, !dbg !829

64:                                               ; preds = %56, %42
  %65 = load ptr, ptr %10, align 8, !dbg !830
  %66 = getelementptr inbounds %struct.ck_stack_entry, ptr %65, i32 0, i32 0, !dbg !830
  %67 = load ptr, ptr %66, align 8, !dbg !830
  store ptr %67, ptr %10, align 8, !dbg !831
  br label %26, !dbg !792, !llvm.loop !813

68:                                               ; preds = %26
  store ptr null, ptr %5, align 8, !dbg !832
  br label %69, !dbg !832

69:                                               ; preds = %68, %62
  %70 = load ptr, ptr %5, align 8, !dbg !833
  ret ptr %70, !dbg !833
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_stall() #0 !dbg !834 {
  call void asm sideeffect "pause", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !835, !srcloc !836
  ret void, !dbg !837
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_uint_value(ptr noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 !dbg !838 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca i8, align 1
  store ptr %0, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !841, metadata !DIExpression()), !dbg !842
  store i32 %1, ptr %6, align 4
  call void @llvm.dbg.declare(metadata ptr %6, metadata !843, metadata !DIExpression()), !dbg !842
  store i32 %2, ptr %7, align 4
  call void @llvm.dbg.declare(metadata ptr %7, metadata !844, metadata !DIExpression()), !dbg !842
  store ptr %3, ptr %8, align 8
  call void @llvm.dbg.declare(metadata ptr %8, metadata !845, metadata !DIExpression()), !dbg !842
  call void @llvm.dbg.declare(metadata ptr %9, metadata !846, metadata !DIExpression()), !dbg !842
  %10 = load ptr, ptr %5, align 8, !dbg !842
  %11 = load i32, ptr %6, align 4, !dbg !842
  %12 = load i32, ptr %7, align 4, !dbg !842
  %13 = call { i8, i32 } asm sideeffect "lock cmpxchgl $3, $0;", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %10, i32 %12, ptr elementtype(i32) %10, i32 %11) #7, !dbg !842, !srcloc !847
  %14 = extractvalue { i8, i32 } %13, 0, !dbg !842
  %15 = extractvalue { i8, i32 } %13, 1, !dbg !842
  %16 = icmp ult i8 %14, 2, !dbg !842
  call void @llvm.assume(i1 %16), !dbg !842
  store i8 %14, ptr %9, align 1, !dbg !842
  store i32 %15, ptr %6, align 4, !dbg !842
  %17 = load i32, ptr %6, align 4, !dbg !842
  %18 = load ptr, ptr %8, align 8, !dbg !842
  store i32 %17, ptr %18, align 4, !dbg !842
  %19 = load i8, ptr %9, align 1, !dbg !842
  %20 = trunc i8 %19 to i1, !dbg !842
  ret i1 %20, !dbg !842
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_atomic_load() #0 !dbg !848 {
  call void @ck_pr_barrier(), !dbg !849
  ret void, !dbg !849
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_synchronize(ptr noundef %0) #0 !dbg !850 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !851, metadata !DIExpression()), !dbg !852
  %3 = load ptr, ptr %2, align 8, !dbg !853
  %4 = getelementptr inbounds %struct.ck_epoch_record, ptr %3, i32 0, i32 1, !dbg !854
  %5 = load ptr, ptr %4, align 8, !dbg !854
  call void @ck_epoch_synchronize_wait(ptr noundef %5, ptr noundef null, ptr noundef null), !dbg !855
  ret void, !dbg !856
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_barrier(ptr noundef %0) #0 !dbg !857 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !858, metadata !DIExpression()), !dbg !859
  %3 = load ptr, ptr %2, align 8, !dbg !860
  call void @ck_epoch_synchronize(ptr noundef %3), !dbg !861
  %4 = load ptr, ptr %2, align 8, !dbg !862
  call void @ck_epoch_reclaim(ptr noundef %4), !dbg !863
  ret void, !dbg !864
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @ck_epoch_barrier_wait(ptr noundef %0, ptr noundef %1, ptr noundef %2) #0 !dbg !865 {
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !868, metadata !DIExpression()), !dbg !869
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !870, metadata !DIExpression()), !dbg !871
  store ptr %2, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !872, metadata !DIExpression()), !dbg !873
  %7 = load ptr, ptr %4, align 8, !dbg !874
  %8 = getelementptr inbounds %struct.ck_epoch_record, ptr %7, i32 0, i32 1, !dbg !875
  %9 = load ptr, ptr %8, align 8, !dbg !875
  %10 = load ptr, ptr %5, align 8, !dbg !876
  %11 = load ptr, ptr %6, align 8, !dbg !877
  call void @ck_epoch_synchronize_wait(ptr noundef %9, ptr noundef %10, ptr noundef %11), !dbg !878
  %12 = load ptr, ptr %4, align 8, !dbg !879
  call void @ck_epoch_reclaim(ptr noundef %12), !dbg !880
  ret void, !dbg !881
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @ck_epoch_poll_deferred(ptr noundef %0, ptr noundef %1) #0 !dbg !882 {
  %3 = alloca i1, align 1
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca i8, align 1
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !885, metadata !DIExpression()), !dbg !886
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !887, metadata !DIExpression()), !dbg !888
  call void @llvm.dbg.declare(metadata ptr %6, metadata !889, metadata !DIExpression()), !dbg !890
  call void @llvm.dbg.declare(metadata ptr %7, metadata !891, metadata !DIExpression()), !dbg !892
  call void @llvm.dbg.declare(metadata ptr %8, metadata !893, metadata !DIExpression()), !dbg !894
  store ptr null, ptr %8, align 8, !dbg !894
  call void @llvm.dbg.declare(metadata ptr %9, metadata !895, metadata !DIExpression()), !dbg !896
  %11 = load ptr, ptr %4, align 8, !dbg !897
  %12 = getelementptr inbounds %struct.ck_epoch_record, ptr %11, i32 0, i32 1, !dbg !898
  %13 = load ptr, ptr %12, align 8, !dbg !898
  store ptr %13, ptr %9, align 8, !dbg !896
  call void @llvm.dbg.declare(metadata ptr %10, metadata !899, metadata !DIExpression()), !dbg !900
  %14 = load ptr, ptr %9, align 8, !dbg !901
  %15 = getelementptr inbounds %struct.ck_epoch, ptr %14, i32 0, i32 0, !dbg !901
  %16 = call i32 @ck_pr_md_load_uint(ptr noundef %15), !dbg !901
  store i32 %16, ptr %7, align 4, !dbg !902
  call void @ck_pr_fence_memory(), !dbg !903
  %17 = load ptr, ptr %4, align 8, !dbg !904
  %18 = load i32, ptr %7, align 4, !dbg !905
  %19 = sub i32 %18, 2, !dbg !906
  %20 = load ptr, ptr %5, align 8, !dbg !907
  %21 = call i32 @ck_epoch_dispatch(ptr noundef %17, i32 noundef %19, ptr noundef %20), !dbg !908
  store i32 %21, ptr %10, align 4, !dbg !909
  %22 = load ptr, ptr %9, align 8, !dbg !910
  %23 = load ptr, ptr %8, align 8, !dbg !911
  %24 = load i32, ptr %7, align 4, !dbg !912
  %25 = call ptr @ck_epoch_scan(ptr noundef %22, ptr noundef %23, i32 noundef %24, ptr noundef %6), !dbg !913
  store ptr %25, ptr %8, align 8, !dbg !914
  %26 = load ptr, ptr %8, align 8, !dbg !915
  %27 = icmp ne ptr %26, null, !dbg !917
  br i1 %27, label %28, label %31, !dbg !918

28:                                               ; preds = %2
  %29 = load i32, ptr %10, align 4, !dbg !919
  %30 = icmp ugt i32 %29, 0, !dbg !920
  store i1 %30, ptr %3, align 1, !dbg !921
  br label %64, !dbg !921

31:                                               ; preds = %2
  %32 = load i8, ptr %6, align 1, !dbg !922
  %33 = trunc i8 %32 to i1, !dbg !922
  %34 = zext i1 %33 to i32, !dbg !922
  %35 = icmp eq i32 %34, 0, !dbg !924
  br i1 %35, label %36, label %52, !dbg !925

36:                                               ; preds = %31
  %37 = load i32, ptr %7, align 4, !dbg !926
  %38 = load ptr, ptr %4, align 8, !dbg !928
  %39 = getelementptr inbounds %struct.ck_epoch_record, ptr %38, i32 0, i32 3, !dbg !929
  store i32 %37, ptr %39, align 4, !dbg !930
  store i32 0, ptr %7, align 4, !dbg !931
  br label %40, !dbg !933

40:                                               ; preds = %48, %36
  %41 = load i32, ptr %7, align 4, !dbg !934
  %42 = icmp ult i32 %41, 4, !dbg !936
  br i1 %42, label %43, label %51, !dbg !937

43:                                               ; preds = %40
  %44 = load ptr, ptr %4, align 8, !dbg !938
  %45 = load i32, ptr %7, align 4, !dbg !939
  %46 = load ptr, ptr %5, align 8, !dbg !940
  %47 = call i32 @ck_epoch_dispatch(ptr noundef %44, i32 noundef %45, ptr noundef %46), !dbg !941
  br label %48, !dbg !941

48:                                               ; preds = %43
  %49 = load i32, ptr %7, align 4, !dbg !942
  %50 = add i32 %49, 1, !dbg !942
  store i32 %50, ptr %7, align 4, !dbg !942
  br label %40, !dbg !943, !llvm.loop !944

51:                                               ; preds = %40
  store i1 true, ptr %3, align 1, !dbg !946
  br label %64, !dbg !946

52:                                               ; preds = %31
  %53 = load ptr, ptr %9, align 8, !dbg !947
  %54 = getelementptr inbounds %struct.ck_epoch, ptr %53, i32 0, i32 0, !dbg !948
  %55 = load i32, ptr %7, align 4, !dbg !949
  %56 = load i32, ptr %7, align 4, !dbg !950
  %57 = add i32 %56, 1, !dbg !951
  %58 = call zeroext i1 @ck_pr_cas_uint(ptr noundef %54, i32 noundef %55, i32 noundef %57), !dbg !952
  %59 = load ptr, ptr %4, align 8, !dbg !953
  %60 = load i32, ptr %7, align 4, !dbg !954
  %61 = sub i32 %60, 1, !dbg !955
  %62 = load ptr, ptr %5, align 8, !dbg !956
  %63 = call i32 @ck_epoch_dispatch(ptr noundef %59, i32 noundef %61, ptr noundef %62), !dbg !957
  store i1 true, ptr %3, align 1, !dbg !958
  br label %64, !dbg !958

64:                                               ; preds = %52, %51, %28
  %65 = load i1, ptr %3, align 1, !dbg !959
  ret i1 %65, !dbg !959
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_uint(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !960 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store ptr %0, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !963, metadata !DIExpression()), !dbg !964
  store i32 %1, ptr %5, align 4
  call void @llvm.dbg.declare(metadata ptr %5, metadata !965, metadata !DIExpression()), !dbg !964
  store i32 %2, ptr %6, align 4
  call void @llvm.dbg.declare(metadata ptr %6, metadata !966, metadata !DIExpression()), !dbg !964
  call void @llvm.dbg.declare(metadata ptr %7, metadata !967, metadata !DIExpression()), !dbg !964
  %8 = load ptr, ptr %4, align 8, !dbg !964
  %9 = load i32, ptr %5, align 4, !dbg !964
  %10 = load i32, ptr %6, align 4, !dbg !964
  %11 = call { i8, i32 } asm sideeffect "lock cmpxchgl $3, $0", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %8, i32 %10, ptr elementtype(i32) %8, i32 %9) #7, !dbg !964, !srcloc !968
  %12 = extractvalue { i8, i32 } %11, 0, !dbg !964
  %13 = extractvalue { i8, i32 } %11, 1, !dbg !964
  %14 = icmp ult i8 %12, 2, !dbg !964
  call void @llvm.assume(i1 %14), !dbg !964
  store i8 %12, ptr %7, align 1, !dbg !964
  store i32 %13, ptr %5, align 4, !dbg !964
  %15 = load i8, ptr %7, align 1, !dbg !964
  %16 = trunc i8 %15 to i1, !dbg !964
  ret i1 %16, !dbg !964
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @ck_epoch_poll(ptr noundef %0) #0 !dbg !969 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !972, metadata !DIExpression()), !dbg !973
  %3 = load ptr, ptr %2, align 8, !dbg !974
  %4 = call zeroext i1 @ck_epoch_poll_deferred(ptr noundef %3, ptr noundef null), !dbg !975
  ret i1 %4, !dbg !976
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 !dbg !977 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca [4 x i64], align 16
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !981, metadata !DIExpression()), !dbg !982
  store ptr %1, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !983, metadata !DIExpression()), !dbg !984
  call void @llvm.dbg.declare(metadata ptr %6, metadata !985, metadata !DIExpression()), !dbg !989
  call void @ck_epoch_init(ptr noundef @stack_epoch), !dbg !990
  call void @llvm.dbg.declare(metadata ptr %7, metadata !991, metadata !DIExpression()), !dbg !993
  store i32 0, ptr %7, align 4, !dbg !993
  br label %9, !dbg !994

9:                                                ; preds = %23, %2
  %10 = load i32, ptr %7, align 4, !dbg !995
  %11 = icmp slt i32 %10, 4, !dbg !997
  br i1 %11, label %12, label %26, !dbg !998

12:                                               ; preds = %9
  %13 = load i32, ptr %7, align 4, !dbg !999
  %14 = sext i32 %13 to i64, !dbg !1001
  %15 = getelementptr inbounds [4 x %struct.ck_epoch_record], ptr @records, i64 0, i64 %14, !dbg !1001
  call void @ck_epoch_register(ptr noundef @stack_epoch, ptr noundef %15, ptr noundef null), !dbg !1002
  %16 = load i32, ptr %7, align 4, !dbg !1003
  %17 = sext i32 %16 to i64, !dbg !1004
  %18 = getelementptr inbounds [4 x i64], ptr %6, i64 0, i64 %17, !dbg !1004
  %19 = load i32, ptr %7, align 4, !dbg !1005
  %20 = sext i32 %19 to i64, !dbg !1006
  %21 = getelementptr inbounds [4 x %struct.ck_epoch_record], ptr @records, i64 0, i64 %20, !dbg !1006
  %22 = call i32 @pthread_create(ptr noundef %18, ptr noundef null, ptr noundef @thread, ptr noundef %21) #7, !dbg !1007
  br label %23, !dbg !1008

23:                                               ; preds = %12
  %24 = load i32, ptr %7, align 4, !dbg !1009
  %25 = add nsw i32 %24, 1, !dbg !1009
  store i32 %25, ptr %7, align 4, !dbg !1009
  br label %9, !dbg !1010, !llvm.loop !1011

26:                                               ; preds = %9
  call void @llvm.dbg.declare(metadata ptr %8, metadata !1013, metadata !DIExpression()), !dbg !1015
  store i32 0, ptr %8, align 4, !dbg !1015
  br label %27, !dbg !1016

27:                                               ; preds = %36, %26
  %28 = load i32, ptr %8, align 4, !dbg !1017
  %29 = icmp slt i32 %28, 4, !dbg !1019
  br i1 %29, label %30, label %39, !dbg !1020

30:                                               ; preds = %27
  %31 = load i32, ptr %8, align 4, !dbg !1021
  %32 = sext i32 %31 to i64, !dbg !1022
  %33 = getelementptr inbounds [4 x i64], ptr %6, i64 0, i64 %32, !dbg !1022
  %34 = load i64, ptr %33, align 8, !dbg !1022
  %35 = call i32 @pthread_join(i64 noundef %34, ptr noundef null), !dbg !1023
  br label %36, !dbg !1023

36:                                               ; preds = %30
  %37 = load i32, ptr %8, align 4, !dbg !1024
  %38 = add nsw i32 %37, 1, !dbg !1024
  store i32 %38, ptr %8, align 4, !dbg !1024
  br label %27, !dbg !1025, !llvm.loop !1026

39:                                               ; preds = %27
  ret i32 0, !dbg !1028
}

; Function Attrs: nounwind
declare i32 @pthread_create(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @thread(ptr noundef %0) #0 !dbg !1029 {
  %2 = alloca i1, align 1
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store ptr %0, ptr %9, align 8
  call void @llvm.dbg.declare(metadata ptr %9, metadata !1032, metadata !DIExpression()), !dbg !1033
  call void @llvm.dbg.declare(metadata ptr %10, metadata !1034, metadata !DIExpression()), !dbg !1035
  %13 = load ptr, ptr %9, align 8, !dbg !1036
  store ptr %13, ptr %10, align 8, !dbg !1035
  %14 = load ptr, ptr %10, align 8, !dbg !1037
  store ptr %14, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !1038, metadata !DIExpression()), !dbg !1044
  store ptr null, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !1046, metadata !DIExpression()), !dbg !1047
  call void @llvm.dbg.declare(metadata ptr %7, metadata !1048, metadata !DIExpression()), !dbg !1049
  %15 = load ptr, ptr %5, align 8, !dbg !1050
  %16 = getelementptr inbounds %struct.ck_epoch_record, ptr %15, i32 0, i32 1, !dbg !1051
  %17 = load ptr, ptr %16, align 8, !dbg !1051
  store ptr %17, ptr %7, align 8, !dbg !1049
  %18 = load ptr, ptr %5, align 8, !dbg !1052
  %19 = getelementptr inbounds %struct.ck_epoch_record, ptr %18, i32 0, i32 4, !dbg !1054
  %20 = load i32, ptr %19, align 8, !dbg !1054
  %21 = icmp eq i32 %20, 0, !dbg !1055
  br i1 %21, label %22, label %31, !dbg !1056

22:                                               ; preds = %1
  call void @llvm.dbg.declare(metadata ptr %8, metadata !1057, metadata !DIExpression()), !dbg !1059
  %23 = load ptr, ptr %5, align 8, !dbg !1060
  %24 = getelementptr inbounds %struct.ck_epoch_record, ptr %23, i32 0, i32 4, !dbg !1061
  %25 = call i32 @ck_pr_fas_uint(ptr noundef %24, i32 noundef 1), !dbg !1062
  call void @ck_pr_fence_atomic_load(), !dbg !1063
  %26 = load ptr, ptr %7, align 8, !dbg !1064
  %27 = call i32 @ck_pr_md_load_uint(ptr noundef %26), !dbg !1064
  store i32 %27, ptr %8, align 4, !dbg !1065
  %28 = load ptr, ptr %5, align 8, !dbg !1066
  %29 = getelementptr inbounds %struct.ck_epoch_record, ptr %28, i32 0, i32 3, !dbg !1066
  %30 = load i32, ptr %8, align 4, !dbg !1066
  call void @ck_pr_md_store_uint(ptr noundef %29, i32 noundef %30), !dbg !1066
  br label %38, !dbg !1067

31:                                               ; preds = %1
  %32 = load ptr, ptr %5, align 8, !dbg !1068
  %33 = getelementptr inbounds %struct.ck_epoch_record, ptr %32, i32 0, i32 4, !dbg !1068
  %34 = load ptr, ptr %5, align 8, !dbg !1068
  %35 = getelementptr inbounds %struct.ck_epoch_record, ptr %34, i32 0, i32 4, !dbg !1068
  %36 = load i32, ptr %35, align 8, !dbg !1068
  %37 = add i32 %36, 1, !dbg !1068
  call void @ck_pr_md_store_uint(ptr noundef %33, i32 noundef %37), !dbg !1068
  br label %38

38:                                               ; preds = %31, %22
  %39 = load ptr, ptr %6, align 8, !dbg !1070
  %40 = icmp ne ptr %39, null, !dbg !1072
  br i1 %40, label %41, label %44, !dbg !1073

41:                                               ; preds = %38
  %42 = load ptr, ptr %5, align 8, !dbg !1074
  %43 = load ptr, ptr %6, align 8, !dbg !1075
  call void @_ck_epoch_addref(ptr noundef %42, ptr noundef %43), !dbg !1076
  br label %44, !dbg !1076

44:                                               ; preds = %38, %41
  call void @llvm.dbg.declare(metadata ptr %11, metadata !1077, metadata !DIExpression()), !dbg !1078
  %45 = call i32 @ck_pr_md_load_uint(ptr noundef @stack_epoch), !dbg !1079
  store i32 %45, ptr %11, align 4, !dbg !1078
  call void @llvm.dbg.declare(metadata ptr %12, metadata !1080, metadata !DIExpression()), !dbg !1081
  %46 = load ptr, ptr %10, align 8, !dbg !1082
  %47 = getelementptr inbounds %struct.ck_epoch_record, ptr %46, i32 0, i32 3, !dbg !1082
  %48 = call i32 @ck_pr_md_load_uint(ptr noundef %47), !dbg !1082
  store i32 %48, ptr %12, align 4, !dbg !1081
  %49 = load ptr, ptr %10, align 8, !dbg !1083
  store ptr %49, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1084, metadata !DIExpression()), !dbg !1088
  store ptr null, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !1090, metadata !DIExpression()), !dbg !1091
  call void @ck_pr_fence_release(), !dbg !1092
  %50 = load ptr, ptr %3, align 8, !dbg !1093
  %51 = getelementptr inbounds %struct.ck_epoch_record, ptr %50, i32 0, i32 4, !dbg !1093
  %52 = load ptr, ptr %3, align 8, !dbg !1093
  %53 = getelementptr inbounds %struct.ck_epoch_record, ptr %52, i32 0, i32 4, !dbg !1093
  %54 = load i32, ptr %53, align 8, !dbg !1093
  %55 = sub i32 %54, 1, !dbg !1093
  call void @ck_pr_md_store_uint(ptr noundef %51, i32 noundef %55), !dbg !1093
  %56 = load ptr, ptr %4, align 8, !dbg !1094
  %57 = icmp ne ptr %56, null, !dbg !1096
  br i1 %57, label %58, label %62, !dbg !1097

58:                                               ; preds = %44
  %59 = load ptr, ptr %3, align 8, !dbg !1098
  %60 = load ptr, ptr %4, align 8, !dbg !1099
  %61 = call zeroext i1 @_ck_epoch_delref(ptr noundef %59, ptr noundef %60), !dbg !1100
  store i1 %61, ptr %2, align 1, !dbg !1101
  br label %67, !dbg !1101

62:                                               ; preds = %44
  %63 = load ptr, ptr %3, align 8, !dbg !1102
  %64 = getelementptr inbounds %struct.ck_epoch_record, ptr %63, i32 0, i32 4, !dbg !1103
  %65 = load i32, ptr %64, align 8, !dbg !1103
  %66 = icmp eq i32 %65, 0, !dbg !1104
  store i1 %66, ptr %2, align 1, !dbg !1105
  br label %67, !dbg !1105

67:                                               ; preds = %58, %62
  %68 = load i1, ptr %2, align 1, !dbg !1106
  %69 = load i32, ptr %12, align 4, !dbg !1107
  %70 = icmp eq i32 %69, 1, !dbg !1107
  br i1 %70, label %71, label %74, !dbg !1107

71:                                               ; preds = %67
  %72 = load i32, ptr %11, align 4, !dbg !1107
  %73 = icmp eq i32 %72, 3, !dbg !1107
  br i1 %73, label %75, label %74, !dbg !1110

74:                                               ; preds = %71, %67
  br label %76, !dbg !1110

75:                                               ; preds = %71
  call void @__assert_fail(ptr noundef @.str, ptr noundef @.str.1, i32 noundef 37, ptr noundef @__PRETTY_FUNCTION__.thread) #8, !dbg !1107
  unreachable, !dbg !1107

76:                                               ; preds = %74
  %77 = load ptr, ptr %10, align 8, !dbg !1111
  %78 = call zeroext i1 @ck_epoch_poll(ptr noundef %77), !dbg !1112
  ret ptr null, !dbg !1113
}

declare i32 @pthread_join(i64 noundef, ptr noundef) #4

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_barrier() #0 !dbg !1114 {
  call void asm sideeffect "", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !1116, !srcloc !1117
  ret void, !dbg !1118
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_md_load_ptr(ptr noundef %0) #0 !dbg !1119 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !1122, metadata !DIExpression()), !dbg !1123
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1124, metadata !DIExpression()), !dbg !1123
  %4 = load ptr, ptr %2, align 8, !dbg !1123
  %5 = call ptr asm sideeffect "movq $1, $0", "=q,*m,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %4) #7, !dbg !1123, !srcloc !1125
  store ptr %5, ptr %3, align 8, !dbg !1123
  %6 = load ptr, ptr %3, align 8, !dbg !1123
  ret ptr %6, !dbg !1123
}

; Function Attrs: noinline nounwind optnone uwtable
define internal zeroext i1 @ck_pr_cas_ptr_value(ptr noundef %0, ptr noundef %1, ptr noundef %2, ptr noundef %3) #0 !dbg !1126 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i8, align 1
  store ptr %0, ptr %5, align 8
  call void @llvm.dbg.declare(metadata ptr %5, metadata !1129, metadata !DIExpression()), !dbg !1130
  store ptr %1, ptr %6, align 8
  call void @llvm.dbg.declare(metadata ptr %6, metadata !1131, metadata !DIExpression()), !dbg !1130
  store ptr %2, ptr %7, align 8
  call void @llvm.dbg.declare(metadata ptr %7, metadata !1132, metadata !DIExpression()), !dbg !1130
  store ptr %3, ptr %8, align 8
  call void @llvm.dbg.declare(metadata ptr %8, metadata !1133, metadata !DIExpression()), !dbg !1130
  call void @llvm.dbg.declare(metadata ptr %9, metadata !1134, metadata !DIExpression()), !dbg !1130
  %10 = load ptr, ptr %5, align 8, !dbg !1130
  %11 = load ptr, ptr %6, align 8, !dbg !1130
  %12 = load ptr, ptr %7, align 8, !dbg !1130
  %13 = call { i8, ptr } asm sideeffect "lock cmpxchgq $3, $0;", "=*m,={@ccz},={ax},q,*m,2,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %10, ptr %12, ptr elementtype(i64) %10, ptr %11) #7, !dbg !1130, !srcloc !1135
  %14 = extractvalue { i8, ptr } %13, 0, !dbg !1130
  %15 = extractvalue { i8, ptr } %13, 1, !dbg !1130
  %16 = icmp ult i8 %14, 2, !dbg !1130
  call void @llvm.assume(i1 %16), !dbg !1130
  store i8 %14, ptr %9, align 1, !dbg !1130
  store ptr %15, ptr %6, align 8, !dbg !1130
  %17 = load ptr, ptr %6, align 8, !dbg !1130
  %18 = load ptr, ptr %8, align 8, !dbg !1130
  store ptr %17, ptr %18, align 8, !dbg !1130
  %19 = load i8, ptr %9, align 1, !dbg !1130
  %20 = trunc i8 %19 to i1, !dbg !1130
  ret i1 %20, !dbg !1130
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #5

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_stack_batch_pop_upmc(ptr noundef %0) #0 !dbg !1136 {
  %2 = alloca ptr, align 8
  %3 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !1139, metadata !DIExpression()), !dbg !1140
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1141, metadata !DIExpression()), !dbg !1142
  %4 = load ptr, ptr %2, align 8, !dbg !1143
  %5 = getelementptr inbounds %struct.ck_stack, ptr %4, i32 0, i32 0, !dbg !1144
  %6 = call ptr @ck_pr_fas_ptr(ptr noundef %5, ptr noundef null), !dbg !1145
  store ptr %6, ptr %3, align 8, !dbg !1146
  call void @ck_pr_fence_load(), !dbg !1147
  %7 = load ptr, ptr %3, align 8, !dbg !1148
  ret ptr %7, !dbg !1149
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_epoch_entry_container(ptr noundef %0) #0 !dbg !1150 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  call void @llvm.dbg.declare(metadata ptr %2, metadata !1153, metadata !DIExpression()), !dbg !1154
  %3 = load ptr, ptr %2, align 8, !dbg !1154
  %4 = getelementptr inbounds i8, ptr %3, i64 -8, !dbg !1154
  ret ptr %4, !dbg !1154
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_stack_push_spnc(ptr noundef %0, ptr noundef %1) #0 !dbg !1155 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1156, metadata !DIExpression()), !dbg !1157
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !1158, metadata !DIExpression()), !dbg !1159
  %5 = load ptr, ptr %3, align 8, !dbg !1160
  %6 = getelementptr inbounds %struct.ck_stack, ptr %5, i32 0, i32 0, !dbg !1161
  %7 = load ptr, ptr %6, align 8, !dbg !1161
  %8 = load ptr, ptr %4, align 8, !dbg !1162
  %9 = getelementptr inbounds %struct.ck_stack_entry, ptr %8, i32 0, i32 0, !dbg !1163
  store ptr %7, ptr %9, align 8, !dbg !1164
  %10 = load ptr, ptr %4, align 8, !dbg !1165
  %11 = load ptr, ptr %3, align 8, !dbg !1166
  %12 = getelementptr inbounds %struct.ck_stack, ptr %11, i32 0, i32 0, !dbg !1167
  store ptr %10, ptr %12, align 8, !dbg !1168
  ret void, !dbg !1169
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_add_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !1170 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1171, metadata !DIExpression()), !dbg !1172
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !1173, metadata !DIExpression()), !dbg !1172
  %5 = load ptr, ptr %3, align 8, !dbg !1172
  %6 = load i32, ptr %4, align 4, !dbg !1172
  call void asm sideeffect "lock addl $1, $0", "=*m,Zq,*m,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6, ptr elementtype(i32) %5) #7, !dbg !1172, !srcloc !1174
  ret void, !dbg !1172
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_sub_uint(ptr noundef %0, i32 noundef %1) #0 !dbg !1175 {
  %3 = alloca ptr, align 8
  %4 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1176, metadata !DIExpression()), !dbg !1177
  store i32 %1, ptr %4, align 4
  call void @llvm.dbg.declare(metadata ptr %4, metadata !1178, metadata !DIExpression()), !dbg !1177
  %5 = load ptr, ptr %3, align 8, !dbg !1177
  %6 = load i32, ptr %4, align 4, !dbg !1177
  call void asm sideeffect "lock subl $1, $0", "=*m,Zq,*m,~{memory},~{cc},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i32) %5, i32 %6, ptr elementtype(i32) %5) #7, !dbg !1177, !srcloc !1179
  ret void, !dbg !1177
}

; Function Attrs: noinline nounwind optnone uwtable
define internal ptr @ck_pr_fas_ptr(ptr noundef %0, ptr noundef %1) #0 !dbg !1180 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  store ptr %0, ptr %3, align 8
  call void @llvm.dbg.declare(metadata ptr %3, metadata !1183, metadata !DIExpression()), !dbg !1184
  store ptr %1, ptr %4, align 8
  call void @llvm.dbg.declare(metadata ptr %4, metadata !1185, metadata !DIExpression()), !dbg !1184
  %5 = load ptr, ptr %3, align 8, !dbg !1184
  %6 = load ptr, ptr %4, align 8, !dbg !1184
  %7 = call ptr asm sideeffect "xchgq $0, $1", "=*m,=q,*m,1,~{memory},~{dirflag},~{fpsr},~{flags}"(ptr elementtype(i64) %5, ptr elementtype(i64) %5, ptr %6) #7, !dbg !1184, !srcloc !1186
  store ptr %7, ptr %4, align 8, !dbg !1184
  %8 = load ptr, ptr %4, align 8, !dbg !1184
  ret ptr %8, !dbg !1184
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_strict_memory() #0 !dbg !1187 {
  call void asm sideeffect "mfence", "~{memory},~{dirflag},~{fpsr},~{flags}"() #7, !dbg !1188, !srcloc !1189
  ret void, !dbg !1188
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(ptr noundef, ptr noundef, i32 noundef, ptr noundef) #6

; Function Attrs: noinline nounwind optnone uwtable
define internal void @ck_pr_fence_release() #0 !dbg !1190 {
  call void @ck_pr_barrier(), !dbg !1191
  ret void, !dbg !1191
}

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #6 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }
attributes #8 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!107, !108, !109, !110, !111, !112, !113}
!llvm.ident = !{!114}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "stack_epoch", scope: !2, file: !3, line: 23, type: !106, isLocal: true, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !11, globals: !86, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "ebr.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "97073fc1e306f2d013b171ccf01e7e22")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 138, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "src/ck_epoch.c", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6acf017f2c970ef5b9eb888b55a36640")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10}
!9 = !DIEnumerator(name: "CK_EPOCH_STATE_USED", value: 0)
!10 = !DIEnumerator(name: "CK_EPOCH_STATE_FREE", value: 1)
!11 = !{!12, !13, !14, !15, !17, !40, !64, !27, !70, !72, !73, !84}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_epoch_record", file: !19, line: 85, size: 1536, align: 512, elements: !20)
!19 = !DIFile(filename: "include/ck_epoch.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "2210cffd498b468d38353410cd7d3066")
!20 = !{!21, !28, !42, !43, !44, !45, !56, !57, !58, !59, !60}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "record_next", scope: !18, file: !19, line: 86, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_stack_entry_t", file: !23, line: 38, baseType: !24)
!23 = !DIFile(filename: "include/ck_stack.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "19674f5fb31e41969a7583ca1d1160b2")
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_stack_entry", file: !23, line: 35, size: 64, elements: !25)
!25 = !{!26}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !24, file: !23, line: 36, baseType: !27, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "global", scope: !18, file: !19, line: 87, baseType: !29, size: 64, offset: 64)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_epoch", file: !19, line: 102, size: 192, elements: !31)
!31 = !{!32, !33, !34}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "epoch", scope: !30, file: !19, line: 103, baseType: !7, size: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "n_free", scope: !30, file: !19, line: 104, baseType: !7, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "records", scope: !30, file: !19, line: 105, baseType: !35, size: 128, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_stack_t", file: !23, line: 44, baseType: !36)
!36 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_stack", file: !23, line: 40, size: 128, elements: !37)
!37 = !{!38, !39}
!38 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !36, file: !23, line: 41, baseType: !27, size: 64)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "generation", scope: !36, file: !23, line: 42, baseType: !40, size: 64, offset: 64)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !18, file: !19, line: 88, baseType: !7, size: 32, offset: 128)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "epoch", scope: !18, file: !19, line: 89, baseType: !7, size: 32, offset: 160)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "active", scope: !18, file: !19, line: 90, baseType: !7, size: 32, offset: 192)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "local", scope: !18, file: !19, line: 93, baseType: !46, size: 128, align: 512, offset: 512)
!46 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !18, file: !19, line: 91, size: 128, elements: !47)
!47 = !{!48}
!48 = !DIDerivedType(tag: DW_TAG_member, name: "bucket", scope: !46, file: !19, line: 92, baseType: !49, size: 128)
!49 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 128, elements: !54)
!50 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_epoch_ref", file: !19, line: 80, size: 64, elements: !51)
!51 = !{!52, !53}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "epoch", scope: !50, file: !19, line: 81, baseType: !7, size: 32)
!53 = !DIDerivedType(tag: DW_TAG_member, name: "count", scope: !50, file: !19, line: 82, baseType: !7, size: 32, offset: 32)
!54 = !{!55}
!55 = !DISubrange(count: 2)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "n_pending", scope: !18, file: !19, line: 94, baseType: !7, size: 32, offset: 640)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "n_peak", scope: !18, file: !19, line: 95, baseType: !7, size: 32, offset: 672)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "n_dispatch", scope: !18, file: !19, line: 96, baseType: !7, size: 32, offset: 704)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "ct", scope: !18, file: !19, line: 97, baseType: !13, size: 64, offset: 768)
!60 = !DIDerivedType(tag: DW_TAG_member, name: "pending", scope: !18, file: !19, line: 98, baseType: !61, size: 512, offset: 832)
!61 = !DICompositeType(tag: DW_TAG_array_type, baseType: !35, size: 512, elements: !62)
!62 = !{!63}
!63 = !DISubrange(count: 4)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !65, size: 64)
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !66, line: 27, baseType: !67)
!66 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "256fcabbefa27ca8cf5e6d37525e6e16")
!67 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !68, line: 45, baseType: !69)
!68 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "e1865d9fe29fe1b5ced550b7ba458f9e")
!69 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !65)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !74, size: 64)
!74 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_epoch_entry", file: !19, line: 60, size: 128, elements: !75)
!75 = !{!76, !83}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "function", scope: !74, file: !19, line: 61, baseType: !77, size: 64)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_epoch_cb_t", file: !19, line: 54, baseType: !79)
!79 = !DISubroutineType(types: !80)
!80 = !{null, !81}
!81 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !82, size: 64)
!82 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_epoch_entry_t", file: !19, line: 53, baseType: !74)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "stack_entry", scope: !74, file: !19, line: 62, baseType: !22, size: 64, offset: 64)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_epoch_record_t", file: !19, line: 100, baseType: !18)
!86 = !{!0, !87, !90, !95, !100}
!87 = !DIGlobalVariableExpression(var: !88, expr: !DIExpression())
!88 = distinct !DIGlobalVariable(name: "records", scope: !2, file: !3, line: 44, type: !89, isLocal: false, isDefinition: true)
!89 = !DICompositeType(tag: DW_TAG_array_type, baseType: !85, size: 6144, align: 512, elements: !62)
!90 = !DIGlobalVariableExpression(var: !91, expr: !DIExpression())
!91 = distinct !DIGlobalVariable(scope: null, file: !3, line: 37, type: !92, isLocal: true, isDefinition: true)
!92 = !DICompositeType(tag: DW_TAG_array_type, baseType: !41, size: 328, elements: !93)
!93 = !{!94}
!94 = !DISubrange(count: 41)
!95 = !DIGlobalVariableExpression(var: !96, expr: !DIExpression())
!96 = distinct !DIGlobalVariable(scope: null, file: !3, line: 37, type: !97, isLocal: true, isDefinition: true)
!97 = !DICompositeType(tag: DW_TAG_array_type, baseType: !41, size: 48, elements: !98)
!98 = !{!99}
!99 = !DISubrange(count: 6)
!100 = !DIGlobalVariableExpression(var: !101, expr: !DIExpression())
!101 = distinct !DIGlobalVariable(scope: null, file: !3, line: 37, type: !102, isLocal: true, isDefinition: true)
!102 = !DICompositeType(tag: DW_TAG_array_type, baseType: !103, size: 168, elements: !104)
!103 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !41)
!104 = !{!105}
!105 = !DISubrange(count: 21)
!106 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_epoch_t", file: !19, line: 107, baseType: !30)
!107 = !{i32 7, !"Dwarf Version", i32 5}
!108 = !{i32 2, !"Debug Info Version", i32 3}
!109 = !{i32 1, !"wchar_size", i32 4}
!110 = !{i32 8, !"PIC Level", i32 2}
!111 = !{i32 7, !"PIE Level", i32 2}
!112 = !{i32 7, !"uwtable", i32 2}
!113 = !{i32 7, !"frame-pointer", i32 2}
!114 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!115 = distinct !DISubprogram(name: "_ck_epoch_delref", scope: !6, file: !6, line: 151, type: !116, scopeLine: 153, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!116 = !DISubroutineType(types: !117)
!117 = !{!118, !17, !119}
!118 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ck_epoch_section", file: !19, line: 69, size: 32, elements: !121)
!121 = !{!122}
!122 = !DIDerivedType(tag: DW_TAG_member, name: "bucket", scope: !120, file: !19, line: 70, baseType: !7, size: 32)
!123 = !{}
!124 = !DILocalVariable(name: "record", arg: 1, scope: !115, file: !6, line: 151, type: !17)
!125 = !DILocation(line: 151, column: 42, scope: !115)
!126 = !DILocalVariable(name: "section", arg: 2, scope: !115, file: !6, line: 152, type: !119)
!127 = !DILocation(line: 152, column: 30, scope: !115)
!128 = !DILocalVariable(name: "current", scope: !115, file: !6, line: 154, type: !129)
!129 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!130 = !DILocation(line: 154, column: 23, scope: !115)
!131 = !DILocalVariable(name: "other", scope: !115, file: !6, line: 154, type: !129)
!132 = !DILocation(line: 154, column: 33, scope: !115)
!133 = !DILocalVariable(name: "i", scope: !115, file: !6, line: 155, type: !7)
!134 = !DILocation(line: 155, column: 15, scope: !115)
!135 = !DILocation(line: 155, column: 19, scope: !115)
!136 = !DILocation(line: 155, column: 28, scope: !115)
!137 = !DILocation(line: 157, column: 13, scope: !115)
!138 = !DILocation(line: 157, column: 21, scope: !115)
!139 = !DILocation(line: 157, column: 27, scope: !115)
!140 = !DILocation(line: 157, column: 34, scope: !115)
!141 = !DILocation(line: 157, column: 10, scope: !115)
!142 = !DILocation(line: 158, column: 2, scope: !115)
!143 = !DILocation(line: 158, column: 11, scope: !115)
!144 = !DILocation(line: 158, column: 16, scope: !115)
!145 = !DILocation(line: 160, column: 6, scope: !146)
!146 = distinct !DILexicalBlock(scope: !115, file: !6, line: 160, column: 6)
!147 = !DILocation(line: 160, column: 15, scope: !146)
!148 = !DILocation(line: 160, column: 21, scope: !146)
!149 = !DILocation(line: 160, column: 6, scope: !115)
!150 = !DILocation(line: 161, column: 3, scope: !146)
!151 = !DILocation(line: 172, column: 11, scope: !115)
!152 = !DILocation(line: 172, column: 19, scope: !115)
!153 = !DILocation(line: 172, column: 25, scope: !115)
!154 = !DILocation(line: 172, column: 33, scope: !115)
!155 = !DILocation(line: 172, column: 35, scope: !115)
!156 = !DILocation(line: 172, column: 40, scope: !115)
!157 = !DILocation(line: 172, column: 8, scope: !115)
!158 = !DILocation(line: 173, column: 6, scope: !159)
!159 = distinct !DILexicalBlock(scope: !115, file: !6, line: 173, column: 6)
!160 = !DILocation(line: 173, column: 13, scope: !159)
!161 = !DILocation(line: 173, column: 19, scope: !159)
!162 = !DILocation(line: 173, column: 23, scope: !159)
!163 = !DILocation(line: 174, column: 13, scope: !159)
!164 = !DILocation(line: 174, column: 22, scope: !159)
!165 = !DILocation(line: 174, column: 30, scope: !159)
!166 = !DILocation(line: 174, column: 37, scope: !159)
!167 = !DILocation(line: 174, column: 28, scope: !159)
!168 = !DILocation(line: 174, column: 44, scope: !159)
!169 = !DILocation(line: 173, column: 6, scope: !115)
!170 = !DILocation(line: 179, column: 3, scope: !171)
!171 = distinct !DILexicalBlock(scope: !159, file: !6, line: 174, column: 50)
!172 = !DILocation(line: 180, column: 2, scope: !171)
!173 = !DILocation(line: 182, column: 2, scope: !115)
!174 = !DILocation(line: 183, column: 1, scope: !115)
!175 = distinct !DISubprogram(name: "ck_pr_md_store_uint", scope: !176, file: !176, line: 276, type: !177, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!176 = !DIFile(filename: "include/gcc/x86_64/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "caff40debc1c9427348a405a2e1d8659")
!177 = !DISubroutineType(types: !178)
!178 = !{null, !14, !7}
!179 = !DILocalVariable(name: "target", arg: 1, scope: !175, file: !176, line: 276, type: !14)
!180 = !DILocation(line: 276, column: 1, scope: !175)
!181 = !DILocalVariable(name: "v", arg: 2, scope: !175, file: !176, line: 276, type: !7)
!182 = !{i64 2148191894}
!183 = distinct !DISubprogram(name: "_ck_epoch_addref", scope: !6, file: !6, line: 186, type: !184, scopeLine: 188, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!184 = !DISubroutineType(types: !185)
!185 = !{null, !17, !119}
!186 = !DILocalVariable(name: "record", arg: 1, scope: !183, file: !6, line: 186, type: !17)
!187 = !DILocation(line: 186, column: 42, scope: !183)
!188 = !DILocalVariable(name: "section", arg: 2, scope: !183, file: !6, line: 187, type: !119)
!189 = !DILocation(line: 187, column: 30, scope: !183)
!190 = !DILocalVariable(name: "global", scope: !183, file: !6, line: 189, type: !29)
!191 = !DILocation(line: 189, column: 19, scope: !183)
!192 = !DILocation(line: 189, column: 28, scope: !183)
!193 = !DILocation(line: 189, column: 36, scope: !183)
!194 = !DILocalVariable(name: "ref", scope: !183, file: !6, line: 190, type: !129)
!195 = !DILocation(line: 190, column: 23, scope: !183)
!196 = !DILocalVariable(name: "epoch", scope: !183, file: !6, line: 191, type: !7)
!197 = !DILocation(line: 191, column: 15, scope: !183)
!198 = !DILocalVariable(name: "i", scope: !183, file: !6, line: 191, type: !7)
!199 = !DILocation(line: 191, column: 22, scope: !183)
!200 = !DILocation(line: 193, column: 10, scope: !183)
!201 = !DILocation(line: 193, column: 8, scope: !183)
!202 = !DILocation(line: 194, column: 6, scope: !183)
!203 = !DILocation(line: 194, column: 12, scope: !183)
!204 = !DILocation(line: 194, column: 4, scope: !183)
!205 = !DILocation(line: 195, column: 9, scope: !183)
!206 = !DILocation(line: 195, column: 17, scope: !183)
!207 = !DILocation(line: 195, column: 23, scope: !183)
!208 = !DILocation(line: 195, column: 30, scope: !183)
!209 = !DILocation(line: 195, column: 6, scope: !183)
!210 = !DILocation(line: 197, column: 6, scope: !211)
!211 = distinct !DILexicalBlock(scope: !183, file: !6, line: 197, column: 6)
!212 = !DILocation(line: 197, column: 11, scope: !211)
!213 = !DILocation(line: 197, column: 16, scope: !211)
!214 = !DILocation(line: 197, column: 19, scope: !211)
!215 = !DILocation(line: 197, column: 6, scope: !183)
!216 = !DILocation(line: 221, column: 16, scope: !217)
!217 = distinct !DILexicalBlock(scope: !211, file: !6, line: 197, column: 25)
!218 = !DILocation(line: 221, column: 3, scope: !217)
!219 = !DILocation(line: 221, column: 8, scope: !217)
!220 = !DILocation(line: 221, column: 14, scope: !217)
!221 = !DILocation(line: 222, column: 2, scope: !217)
!222 = !DILocation(line: 224, column: 20, scope: !183)
!223 = !DILocation(line: 224, column: 2, scope: !183)
!224 = !DILocation(line: 224, column: 11, scope: !183)
!225 = !DILocation(line: 224, column: 18, scope: !183)
!226 = !DILocation(line: 225, column: 2, scope: !183)
!227 = distinct !DISubprogram(name: "ck_pr_md_load_uint", scope: !176, file: !176, line: 190, type: !228, scopeLine: 190, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!228 = !DISubroutineType(types: !229)
!229 = !{!7, !15}
!230 = !DILocalVariable(name: "target", arg: 1, scope: !227, file: !176, line: 190, type: !15)
!231 = !DILocation(line: 190, column: 1, scope: !227)
!232 = !DILocalVariable(name: "r", scope: !227, file: !176, line: 190, type: !7)
!233 = !{i64 2148185900}
!234 = distinct !DISubprogram(name: "ck_epoch_init", scope: !6, file: !6, line: 229, type: !235, scopeLine: 230, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!235 = !DISubroutineType(types: !236)
!236 = !{null, !29}
!237 = !DILocalVariable(name: "global", arg: 1, scope: !234, file: !6, line: 229, type: !29)
!238 = !DILocation(line: 229, column: 32, scope: !234)
!239 = !DILocation(line: 232, column: 17, scope: !234)
!240 = !DILocation(line: 232, column: 25, scope: !234)
!241 = !DILocation(line: 232, column: 2, scope: !234)
!242 = !DILocation(line: 233, column: 2, scope: !234)
!243 = !DILocation(line: 233, column: 10, scope: !234)
!244 = !DILocation(line: 233, column: 16, scope: !234)
!245 = !DILocation(line: 234, column: 2, scope: !234)
!246 = !DILocation(line: 234, column: 10, scope: !234)
!247 = !DILocation(line: 234, column: 17, scope: !234)
!248 = !DILocation(line: 235, column: 2, scope: !234)
!249 = !DILocation(line: 236, column: 2, scope: !234)
!250 = distinct !DISubprogram(name: "ck_stack_init", scope: !23, file: !23, line: 334, type: !251, scopeLine: 335, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!251 = !DISubroutineType(types: !252)
!252 = !{null, !253}
!253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!254 = !DILocalVariable(name: "stack", arg: 1, scope: !250, file: !23, line: 334, type: !253)
!255 = !DILocation(line: 334, column: 32, scope: !250)
!256 = !DILocation(line: 337, column: 2, scope: !250)
!257 = !DILocation(line: 337, column: 9, scope: !250)
!258 = !DILocation(line: 337, column: 14, scope: !250)
!259 = !DILocation(line: 338, column: 2, scope: !250)
!260 = !DILocation(line: 338, column: 9, scope: !250)
!261 = !DILocation(line: 338, column: 20, scope: !250)
!262 = !DILocation(line: 339, column: 2, scope: !250)
!263 = distinct !DISubprogram(name: "ck_pr_fence_store", scope: !264, file: !264, line: 157, type: !265, scopeLine: 157, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!264 = !DIFile(filename: "include/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "a04525ce1c6aca0c6489b709b33f6356")
!265 = !DISubroutineType(types: !266)
!266 = !{null}
!267 = !DILocation(line: 157, column: 1, scope: !263)
!268 = distinct !DISubprogram(name: "ck_epoch_recycle", scope: !6, file: !6, line: 240, type: !269, scopeLine: 241, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!269 = !DISubroutineType(types: !270)
!270 = !{!84, !29, !13}
!271 = !DILocalVariable(name: "global", arg: 1, scope: !268, file: !6, line: 240, type: !29)
!272 = !DILocation(line: 240, column: 35, scope: !268)
!273 = !DILocalVariable(name: "ct", arg: 2, scope: !268, file: !6, line: 240, type: !13)
!274 = !DILocation(line: 240, column: 49, scope: !268)
!275 = !DILocalVariable(name: "record", scope: !268, file: !6, line: 242, type: !17)
!276 = !DILocation(line: 242, column: 26, scope: !268)
!277 = !DILocalVariable(name: "cursor", scope: !268, file: !6, line: 243, type: !278)
!278 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!279 = !DILocation(line: 243, column: 20, scope: !268)
!280 = !DILocalVariable(name: "state", scope: !268, file: !6, line: 244, type: !7)
!281 = !DILocation(line: 244, column: 15, scope: !268)
!282 = !DILocation(line: 246, column: 6, scope: !283)
!283 = distinct !DILexicalBlock(scope: !268, file: !6, line: 246, column: 6)
!284 = !DILocation(line: 246, column: 39, scope: !283)
!285 = !DILocation(line: 246, column: 6, scope: !268)
!286 = !DILocation(line: 247, column: 3, scope: !283)
!287 = !DILocation(line: 249, column: 2, scope: !288)
!288 = distinct !DILexicalBlock(scope: !268, file: !6, line: 249, column: 2)
!289 = !DILocation(line: 249, column: 2, scope: !290)
!290 = distinct !DILexicalBlock(scope: !288, file: !6, line: 249, column: 2)
!291 = !DILocation(line: 250, column: 38, scope: !292)
!292 = distinct !DILexicalBlock(scope: !290, file: !6, line: 249, column: 45)
!293 = !DILocation(line: 250, column: 12, scope: !292)
!294 = !DILocation(line: 250, column: 10, scope: !292)
!295 = !DILocation(line: 252, column: 7, scope: !296)
!296 = distinct !DILexicalBlock(scope: !292, file: !6, line: 252, column: 7)
!297 = !DILocation(line: 252, column: 39, scope: !296)
!298 = !DILocation(line: 252, column: 7, scope: !292)
!299 = !DILocation(line: 254, column: 4, scope: !300)
!300 = distinct !DILexicalBlock(scope: !296, file: !6, line: 252, column: 63)
!301 = !DILocation(line: 255, column: 28, scope: !300)
!302 = !DILocation(line: 255, column: 36, scope: !300)
!303 = !DILocation(line: 255, column: 12, scope: !300)
!304 = !DILocation(line: 255, column: 10, scope: !300)
!305 = !DILocation(line: 257, column: 8, scope: !306)
!306 = distinct !DILexicalBlock(scope: !300, file: !6, line: 257, column: 8)
!307 = !DILocation(line: 257, column: 14, scope: !306)
!308 = !DILocation(line: 257, column: 8, scope: !300)
!309 = !DILocation(line: 258, column: 21, scope: !310)
!310 = distinct !DILexicalBlock(scope: !306, file: !6, line: 257, column: 38)
!311 = !DILocation(line: 258, column: 29, scope: !310)
!312 = !DILocation(line: 258, column: 5, scope: !310)
!313 = !DILocation(line: 259, column: 5, scope: !310)
!314 = !DILocation(line: 265, column: 12, scope: !310)
!315 = !DILocation(line: 265, column: 5, scope: !310)
!316 = !DILocation(line: 267, column: 3, scope: !300)
!317 = !DILocation(line: 268, column: 2, scope: !292)
!318 = distinct !{!318, !287, !319, !320}
!319 = !DILocation(line: 268, column: 2, scope: !288)
!320 = !{!"llvm.loop.mustprogress"}
!321 = !DILocation(line: 270, column: 2, scope: !268)
!322 = !DILocation(line: 271, column: 1, scope: !268)
!323 = distinct !DISubprogram(name: "ck_epoch_record_container", scope: !6, file: !6, line: 143, type: !324, scopeLine: 143, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!324 = !DISubroutineType(types: !325)
!325 = !{!17, !278}
!326 = !DILocalVariable(name: "p", arg: 1, scope: !323, file: !6, line: 143, type: !278)
!327 = !DILocation(line: 143, column: 1, scope: !323)
!328 = distinct !DISubprogram(name: "ck_pr_fence_load", scope: !264, file: !264, line: 156, type: !265, scopeLine: 156, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!329 = !DILocation(line: 156, column: 1, scope: !328)
!330 = distinct !DISubprogram(name: "ck_pr_fas_uint", scope: !176, file: !176, line: 160, type: !331, scopeLine: 160, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!331 = !DISubroutineType(types: !332)
!332 = !{!7, !14, !7}
!333 = !DILocalVariable(name: "target", arg: 1, scope: !330, file: !176, line: 160, type: !14)
!334 = !DILocation(line: 160, column: 1, scope: !330)
!335 = !DILocalVariable(name: "v", arg: 2, scope: !330, file: !176, line: 160, type: !7)
!336 = !{i64 2148182921}
!337 = distinct !DISubprogram(name: "ck_pr_dec_uint", scope: !176, file: !176, line: 360, type: !338, scopeLine: 360, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!338 = !DISubroutineType(types: !339)
!339 = !{null, !14}
!340 = !DILocalVariable(name: "target", arg: 1, scope: !337, file: !176, line: 360, type: !14)
!341 = !DILocation(line: 360, column: 1, scope: !337)
!342 = !{i64 2148211800}
!343 = distinct !DISubprogram(name: "ck_pr_md_store_ptr", scope: !176, file: !176, line: 267, type: !344, scopeLine: 267, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!344 = !DISubroutineType(types: !345)
!345 = !{null, !13, !346}
!346 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !347, size: 64)
!347 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!348 = !DILocalVariable(name: "target", arg: 1, scope: !343, file: !176, line: 267, type: !13)
!349 = !DILocation(line: 267, column: 1, scope: !343)
!350 = !DILocalVariable(name: "v", arg: 2, scope: !343, file: !176, line: 267, type: !346)
!351 = !{i64 2148190433}
!352 = distinct !DISubprogram(name: "ck_epoch_register", scope: !6, file: !6, line: 274, type: !353, scopeLine: 276, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!353 = !DISubroutineType(types: !354)
!354 = !{null, !29, !17, !13}
!355 = !DILocalVariable(name: "global", arg: 1, scope: !352, file: !6, line: 274, type: !29)
!356 = !DILocation(line: 274, column: 36, scope: !352)
!357 = !DILocalVariable(name: "record", arg: 2, scope: !352, file: !6, line: 274, type: !17)
!358 = !DILocation(line: 274, column: 68, scope: !352)
!359 = !DILocalVariable(name: "ct", arg: 3, scope: !352, file: !6, line: 275, type: !13)
!360 = !DILocation(line: 275, column: 11, scope: !352)
!361 = !DILocalVariable(name: "i", scope: !352, file: !6, line: 277, type: !362)
!362 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !363, line: 18, baseType: !69)
!363 = !DIFile(filename: "/usr/lib/llvm-18/lib/clang/18/include/__stddef_size_t.h", directory: "", checksumkind: CSK_MD5, checksum: "2c44e821a2b1951cde2eb0fb2e656867")
!364 = !DILocation(line: 277, column: 9, scope: !352)
!365 = !DILocation(line: 279, column: 19, scope: !352)
!366 = !DILocation(line: 279, column: 2, scope: !352)
!367 = !DILocation(line: 279, column: 10, scope: !352)
!368 = !DILocation(line: 279, column: 17, scope: !352)
!369 = !DILocation(line: 280, column: 2, scope: !352)
!370 = !DILocation(line: 280, column: 10, scope: !352)
!371 = !DILocation(line: 280, column: 16, scope: !352)
!372 = !DILocation(line: 281, column: 2, scope: !352)
!373 = !DILocation(line: 281, column: 10, scope: !352)
!374 = !DILocation(line: 281, column: 17, scope: !352)
!375 = !DILocation(line: 282, column: 2, scope: !352)
!376 = !DILocation(line: 282, column: 10, scope: !352)
!377 = !DILocation(line: 282, column: 16, scope: !352)
!378 = !DILocation(line: 283, column: 2, scope: !352)
!379 = !DILocation(line: 283, column: 10, scope: !352)
!380 = !DILocation(line: 283, column: 21, scope: !352)
!381 = !DILocation(line: 284, column: 2, scope: !352)
!382 = !DILocation(line: 284, column: 10, scope: !352)
!383 = !DILocation(line: 284, column: 17, scope: !352)
!384 = !DILocation(line: 285, column: 2, scope: !352)
!385 = !DILocation(line: 285, column: 10, scope: !352)
!386 = !DILocation(line: 285, column: 20, scope: !352)
!387 = !DILocation(line: 286, column: 15, scope: !352)
!388 = !DILocation(line: 286, column: 2, scope: !352)
!389 = !DILocation(line: 286, column: 10, scope: !352)
!390 = !DILocation(line: 286, column: 13, scope: !352)
!391 = !DILocation(line: 287, column: 10, scope: !352)
!392 = !DILocation(line: 287, column: 18, scope: !352)
!393 = !DILocation(line: 287, column: 2, scope: !352)
!394 = !DILocation(line: 289, column: 9, scope: !395)
!395 = distinct !DILexicalBlock(scope: !352, file: !6, line: 289, column: 2)
!396 = !DILocation(line: 289, column: 7, scope: !395)
!397 = !DILocation(line: 289, column: 14, scope: !398)
!398 = distinct !DILexicalBlock(scope: !395, file: !6, line: 289, column: 2)
!399 = !DILocation(line: 289, column: 16, scope: !398)
!400 = !DILocation(line: 289, column: 2, scope: !395)
!401 = !DILocation(line: 290, column: 18, scope: !398)
!402 = !DILocation(line: 290, column: 26, scope: !398)
!403 = !DILocation(line: 290, column: 34, scope: !398)
!404 = !DILocation(line: 290, column: 3, scope: !398)
!405 = !DILocation(line: 289, column: 36, scope: !398)
!406 = !DILocation(line: 289, column: 2, scope: !398)
!407 = distinct !{!407, !400, !408, !320}
!408 = !DILocation(line: 290, column: 36, scope: !395)
!409 = !DILocation(line: 292, column: 2, scope: !352)
!410 = !DILocation(line: 293, column: 22, scope: !352)
!411 = !DILocation(line: 293, column: 30, scope: !352)
!412 = !DILocation(line: 293, column: 40, scope: !352)
!413 = !DILocation(line: 293, column: 48, scope: !352)
!414 = !DILocation(line: 293, column: 2, scope: !352)
!415 = !DILocation(line: 294, column: 2, scope: !352)
!416 = distinct !DISubprogram(name: "ck_stack_push_upmc", scope: !23, file: !23, line: 54, type: !417, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!417 = !DISubroutineType(types: !418)
!418 = !{null, !253, !27}
!419 = !DILocalVariable(name: "target", arg: 1, scope: !416, file: !23, line: 54, type: !253)
!420 = !DILocation(line: 54, column: 37, scope: !416)
!421 = !DILocalVariable(name: "entry", arg: 2, scope: !416, file: !23, line: 54, type: !27)
!422 = !DILocation(line: 54, column: 68, scope: !416)
!423 = !DILocalVariable(name: "stack", scope: !416, file: !23, line: 56, type: !27)
!424 = !DILocation(line: 56, column: 25, scope: !416)
!425 = !DILocation(line: 58, column: 10, scope: !416)
!426 = !DILocation(line: 58, column: 8, scope: !416)
!427 = !DILocation(line: 59, column: 16, scope: !416)
!428 = !DILocation(line: 59, column: 2, scope: !416)
!429 = !DILocation(line: 59, column: 9, scope: !416)
!430 = !DILocation(line: 59, column: 14, scope: !416)
!431 = !DILocation(line: 60, column: 2, scope: !416)
!432 = !DILocation(line: 62, column: 2, scope: !416)
!433 = !DILocation(line: 62, column: 30, scope: !416)
!434 = !DILocation(line: 62, column: 38, scope: !416)
!435 = !DILocation(line: 62, column: 44, scope: !416)
!436 = !DILocation(line: 62, column: 51, scope: !416)
!437 = !DILocation(line: 62, column: 9, scope: !416)
!438 = !DILocation(line: 62, column: 66, scope: !416)
!439 = !DILocation(line: 63, column: 17, scope: !440)
!440 = distinct !DILexicalBlock(scope: !416, file: !23, line: 62, column: 76)
!441 = !DILocation(line: 63, column: 3, scope: !440)
!442 = !DILocation(line: 63, column: 10, scope: !440)
!443 = !DILocation(line: 63, column: 15, scope: !440)
!444 = !DILocation(line: 64, column: 3, scope: !440)
!445 = distinct !{!445, !432, !446, !320}
!446 = !DILocation(line: 65, column: 2, scope: !416)
!447 = !DILocation(line: 67, column: 2, scope: !416)
!448 = distinct !DISubprogram(name: "ck_epoch_unregister", scope: !6, file: !6, line: 298, type: !449, scopeLine: 299, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!449 = !DISubroutineType(types: !450)
!450 = !{null, !17}
!451 = !DILocalVariable(name: "record", arg: 1, scope: !448, file: !6, line: 298, type: !17)
!452 = !DILocation(line: 298, column: 45, scope: !448)
!453 = !DILocalVariable(name: "global", scope: !448, file: !6, line: 300, type: !29)
!454 = !DILocation(line: 300, column: 19, scope: !448)
!455 = !DILocation(line: 300, column: 28, scope: !448)
!456 = !DILocation(line: 300, column: 36, scope: !448)
!457 = !DILocalVariable(name: "i", scope: !448, file: !6, line: 301, type: !362)
!458 = !DILocation(line: 301, column: 9, scope: !448)
!459 = !DILocation(line: 303, column: 2, scope: !448)
!460 = !DILocation(line: 303, column: 10, scope: !448)
!461 = !DILocation(line: 303, column: 17, scope: !448)
!462 = !DILocation(line: 304, column: 2, scope: !448)
!463 = !DILocation(line: 304, column: 10, scope: !448)
!464 = !DILocation(line: 304, column: 16, scope: !448)
!465 = !DILocation(line: 305, column: 2, scope: !448)
!466 = !DILocation(line: 305, column: 10, scope: !448)
!467 = !DILocation(line: 305, column: 21, scope: !448)
!468 = !DILocation(line: 306, column: 2, scope: !448)
!469 = !DILocation(line: 306, column: 10, scope: !448)
!470 = !DILocation(line: 306, column: 17, scope: !448)
!471 = !DILocation(line: 307, column: 2, scope: !448)
!472 = !DILocation(line: 307, column: 10, scope: !448)
!473 = !DILocation(line: 307, column: 20, scope: !448)
!474 = !DILocation(line: 308, column: 10, scope: !448)
!475 = !DILocation(line: 308, column: 18, scope: !448)
!476 = !DILocation(line: 308, column: 2, scope: !448)
!477 = !DILocation(line: 310, column: 9, scope: !478)
!478 = distinct !DILexicalBlock(scope: !448, file: !6, line: 310, column: 2)
!479 = !DILocation(line: 310, column: 7, scope: !478)
!480 = !DILocation(line: 310, column: 14, scope: !481)
!481 = distinct !DILexicalBlock(scope: !478, file: !6, line: 310, column: 2)
!482 = !DILocation(line: 310, column: 16, scope: !481)
!483 = !DILocation(line: 310, column: 2, scope: !478)
!484 = !DILocation(line: 311, column: 18, scope: !481)
!485 = !DILocation(line: 311, column: 26, scope: !481)
!486 = !DILocation(line: 311, column: 34, scope: !481)
!487 = !DILocation(line: 311, column: 3, scope: !481)
!488 = !DILocation(line: 310, column: 36, scope: !481)
!489 = !DILocation(line: 310, column: 2, scope: !481)
!490 = distinct !{!490, !483, !491, !320}
!491 = !DILocation(line: 311, column: 36, scope: !478)
!492 = !DILocation(line: 313, column: 2, scope: !448)
!493 = !DILocation(line: 314, column: 2, scope: !448)
!494 = !DILocation(line: 315, column: 2, scope: !448)
!495 = !DILocation(line: 316, column: 18, scope: !448)
!496 = !DILocation(line: 316, column: 26, scope: !448)
!497 = !DILocation(line: 316, column: 2, scope: !448)
!498 = !DILocation(line: 317, column: 2, scope: !448)
!499 = distinct !DISubprogram(name: "ck_pr_inc_uint", scope: !176, file: !176, line: 359, type: !338, scopeLine: 359, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!500 = !DILocalVariable(name: "target", arg: 1, scope: !499, file: !176, line: 359, type: !14)
!501 = !DILocation(line: 359, column: 1, scope: !499)
!502 = !{i64 2148200261}
!503 = distinct !DISubprogram(name: "ck_epoch_reclaim", scope: !6, file: !6, line: 400, type: !449, scopeLine: 401, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!504 = !DILocalVariable(name: "record", arg: 1, scope: !503, file: !6, line: 400, type: !17)
!505 = !DILocation(line: 400, column: 42, scope: !503)
!506 = !DILocalVariable(name: "epoch", scope: !503, file: !6, line: 402, type: !7)
!507 = !DILocation(line: 402, column: 15, scope: !503)
!508 = !DILocation(line: 404, column: 13, scope: !509)
!509 = distinct !DILexicalBlock(scope: !503, file: !6, line: 404, column: 2)
!510 = !DILocation(line: 404, column: 7, scope: !509)
!511 = !DILocation(line: 404, column: 18, scope: !512)
!512 = distinct !DILexicalBlock(scope: !509, file: !6, line: 404, column: 2)
!513 = !DILocation(line: 404, column: 24, scope: !512)
!514 = !DILocation(line: 404, column: 2, scope: !509)
!515 = !DILocation(line: 405, column: 21, scope: !512)
!516 = !DILocation(line: 405, column: 29, scope: !512)
!517 = !DILocation(line: 405, column: 3, scope: !512)
!518 = !DILocation(line: 404, column: 48, scope: !512)
!519 = !DILocation(line: 404, column: 2, scope: !512)
!520 = distinct !{!520, !514, !521, !320}
!521 = !DILocation(line: 405, column: 40, scope: !509)
!522 = !DILocation(line: 407, column: 2, scope: !503)
!523 = distinct !DISubprogram(name: "ck_epoch_dispatch", scope: !6, file: !6, line: 360, type: !524, scopeLine: 361, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!524 = !DISubroutineType(types: !525)
!525 = !{!7, !17, !7, !526}
!526 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!527 = !DILocalVariable(name: "record", arg: 1, scope: !523, file: !6, line: 360, type: !17)
!528 = !DILocation(line: 360, column: 43, scope: !523)
!529 = !DILocalVariable(name: "e", arg: 2, scope: !523, file: !6, line: 360, type: !7)
!530 = !DILocation(line: 360, column: 64, scope: !523)
!531 = !DILocalVariable(name: "deferred", arg: 3, scope: !523, file: !6, line: 360, type: !526)
!532 = !DILocation(line: 360, column: 79, scope: !523)
!533 = !DILocalVariable(name: "epoch", scope: !523, file: !6, line: 362, type: !7)
!534 = !DILocation(line: 362, column: 15, scope: !523)
!535 = !DILocation(line: 362, column: 23, scope: !523)
!536 = !DILocation(line: 362, column: 25, scope: !523)
!537 = !DILocalVariable(name: "head", scope: !523, file: !6, line: 363, type: !278)
!538 = !DILocation(line: 363, column: 20, scope: !523)
!539 = !DILocalVariable(name: "next", scope: !523, file: !6, line: 363, type: !278)
!540 = !DILocation(line: 363, column: 27, scope: !523)
!541 = !DILocalVariable(name: "cursor", scope: !523, file: !6, line: 363, type: !278)
!542 = !DILocation(line: 363, column: 34, scope: !523)
!543 = !DILocalVariable(name: "n_pending", scope: !523, file: !6, line: 364, type: !7)
!544 = !DILocation(line: 364, column: 15, scope: !523)
!545 = !DILocalVariable(name: "n_peak", scope: !523, file: !6, line: 364, type: !7)
!546 = !DILocation(line: 364, column: 26, scope: !523)
!547 = !DILocalVariable(name: "i", scope: !523, file: !6, line: 365, type: !7)
!548 = !DILocation(line: 365, column: 15, scope: !523)
!549 = !DILocation(line: 367, column: 34, scope: !523)
!550 = !DILocation(line: 367, column: 42, scope: !523)
!551 = !DILocation(line: 367, column: 50, scope: !523)
!552 = !DILocation(line: 367, column: 9, scope: !523)
!553 = !DILocation(line: 367, column: 7, scope: !523)
!554 = !DILocation(line: 368, column: 16, scope: !555)
!555 = distinct !DILexicalBlock(scope: !523, file: !6, line: 368, column: 2)
!556 = !DILocation(line: 368, column: 14, scope: !555)
!557 = !DILocation(line: 368, column: 7, scope: !555)
!558 = !DILocation(line: 368, column: 22, scope: !559)
!559 = distinct !DILexicalBlock(scope: !555, file: !6, line: 368, column: 2)
!560 = !DILocation(line: 368, column: 29, scope: !559)
!561 = !DILocation(line: 368, column: 2, scope: !555)
!562 = !DILocalVariable(name: "entry", scope: !563, file: !6, line: 369, type: !73)
!563 = distinct !DILexicalBlock(scope: !559, file: !6, line: 368, column: 53)
!564 = !DILocation(line: 369, column: 26, scope: !563)
!565 = !DILocation(line: 370, column: 32, scope: !563)
!566 = !DILocation(line: 370, column: 7, scope: !563)
!567 = !DILocation(line: 372, column: 10, scope: !563)
!568 = !DILocation(line: 372, column: 8, scope: !563)
!569 = !DILocation(line: 373, column: 7, scope: !570)
!570 = distinct !DILexicalBlock(scope: !563, file: !6, line: 373, column: 7)
!571 = !DILocation(line: 373, column: 16, scope: !570)
!572 = !DILocation(line: 373, column: 7, scope: !563)
!573 = !DILocation(line: 374, column: 23, scope: !570)
!574 = !DILocation(line: 374, column: 34, scope: !570)
!575 = !DILocation(line: 374, column: 41, scope: !570)
!576 = !DILocation(line: 374, column: 4, scope: !570)
!577 = !DILocation(line: 376, column: 4, scope: !570)
!578 = !DILocation(line: 376, column: 11, scope: !570)
!579 = !DILocation(line: 376, column: 20, scope: !570)
!580 = !DILocation(line: 378, column: 4, scope: !563)
!581 = !DILocation(line: 379, column: 2, scope: !563)
!582 = !DILocation(line: 368, column: 47, scope: !559)
!583 = !DILocation(line: 368, column: 45, scope: !559)
!584 = !DILocation(line: 368, column: 2, scope: !559)
!585 = distinct !{!585, !561, !586, !320}
!586 = !DILocation(line: 379, column: 2, scope: !555)
!587 = !DILocation(line: 381, column: 11, scope: !523)
!588 = !DILocation(line: 381, column: 9, scope: !523)
!589 = !DILocation(line: 382, column: 14, scope: !523)
!590 = !DILocation(line: 382, column: 12, scope: !523)
!591 = !DILocation(line: 385, column: 6, scope: !592)
!592 = distinct !DILexicalBlock(scope: !523, file: !6, line: 385, column: 6)
!593 = !DILocation(line: 385, column: 18, scope: !592)
!594 = !DILocation(line: 385, column: 16, scope: !592)
!595 = !DILocation(line: 385, column: 6, scope: !523)
!596 = !DILocation(line: 386, column: 3, scope: !592)
!597 = !DILocation(line: 388, column: 6, scope: !598)
!598 = distinct !DILexicalBlock(scope: !523, file: !6, line: 388, column: 6)
!599 = !DILocation(line: 388, column: 8, scope: !598)
!600 = !DILocation(line: 388, column: 6, scope: !523)
!601 = !DILocation(line: 389, column: 19, scope: !602)
!602 = distinct !DILexicalBlock(scope: !598, file: !6, line: 388, column: 13)
!603 = !DILocation(line: 389, column: 27, scope: !602)
!604 = !DILocation(line: 389, column: 39, scope: !602)
!605 = !DILocation(line: 389, column: 3, scope: !602)
!606 = !DILocation(line: 390, column: 19, scope: !602)
!607 = !DILocation(line: 390, column: 27, scope: !602)
!608 = !DILocation(line: 390, column: 38, scope: !602)
!609 = !DILocation(line: 390, column: 3, scope: !602)
!610 = !DILocation(line: 391, column: 2, scope: !602)
!611 = !DILocation(line: 393, column: 9, scope: !523)
!612 = !DILocation(line: 393, column: 2, scope: !523)
!613 = distinct !DISubprogram(name: "ck_epoch_synchronize_wait", scope: !6, file: !6, line: 425, type: !614, scopeLine: 427, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!614 = !DISubroutineType(types: !615)
!615 = !{null, !29, !616, !13}
!616 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !617, size: 64)
!617 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_epoch_wait_cb_t", file: !19, line: 234, baseType: !618)
!618 = !DISubroutineType(types: !619)
!619 = !{null, !620, !84, !13}
!620 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !106, size: 64)
!621 = !DILocalVariable(name: "global", arg: 1, scope: !613, file: !6, line: 425, type: !29)
!622 = !DILocation(line: 425, column: 44, scope: !613)
!623 = !DILocalVariable(name: "cb", arg: 2, scope: !613, file: !6, line: 426, type: !616)
!624 = !DILocation(line: 426, column: 25, scope: !613)
!625 = !DILocalVariable(name: "ct", arg: 3, scope: !613, file: !6, line: 426, type: !13)
!626 = !DILocation(line: 426, column: 35, scope: !613)
!627 = !DILocalVariable(name: "cr", scope: !613, file: !6, line: 428, type: !17)
!628 = !DILocation(line: 428, column: 26, scope: !613)
!629 = !DILocalVariable(name: "delta", scope: !613, file: !6, line: 429, type: !7)
!630 = !DILocation(line: 429, column: 15, scope: !613)
!631 = !DILocalVariable(name: "epoch", scope: !613, file: !6, line: 429, type: !7)
!632 = !DILocation(line: 429, column: 22, scope: !613)
!633 = !DILocalVariable(name: "goal", scope: !613, file: !6, line: 429, type: !7)
!634 = !DILocation(line: 429, column: 29, scope: !613)
!635 = !DILocalVariable(name: "i", scope: !613, file: !6, line: 429, type: !7)
!636 = !DILocation(line: 429, column: 35, scope: !613)
!637 = !DILocalVariable(name: "active", scope: !613, file: !6, line: 430, type: !118)
!638 = !DILocation(line: 430, column: 7, scope: !613)
!639 = !DILocation(line: 432, column: 2, scope: !613)
!640 = !DILocation(line: 443, column: 18, scope: !613)
!641 = !DILocation(line: 443, column: 16, scope: !613)
!642 = !DILocation(line: 443, column: 8, scope: !613)
!643 = !DILocation(line: 444, column: 9, scope: !613)
!644 = !DILocation(line: 444, column: 15, scope: !613)
!645 = !DILocation(line: 444, column: 7, scope: !613)
!646 = !DILocation(line: 446, column: 9, scope: !647)
!647 = distinct !DILexicalBlock(scope: !613, file: !6, line: 446, column: 2)
!648 = !DILocation(line: 446, column: 17, scope: !647)
!649 = !DILocation(line: 446, column: 7, scope: !647)
!650 = !DILocation(line: 446, column: 25, scope: !651)
!651 = distinct !DILexicalBlock(scope: !647, file: !6, line: 446, column: 2)
!652 = !DILocation(line: 446, column: 27, scope: !651)
!653 = !DILocation(line: 446, column: 2, scope: !647)
!654 = !DILocalVariable(name: "r", scope: !655, file: !6, line: 447, type: !118)
!655 = distinct !DILexicalBlock(scope: !651, file: !6, line: 446, column: 65)
!656 = !DILocation(line: 447, column: 8, scope: !655)
!657 = !DILocation(line: 453, column: 3, scope: !655)
!658 = !DILocation(line: 453, column: 29, scope: !655)
!659 = !DILocation(line: 453, column: 37, scope: !655)
!660 = !DILocation(line: 453, column: 41, scope: !655)
!661 = !DILocation(line: 453, column: 15, scope: !655)
!662 = !DILocation(line: 453, column: 13, scope: !655)
!663 = !DILocation(line: 454, column: 7, scope: !655)
!664 = !DILocation(line: 454, column: 10, scope: !655)
!665 = !DILocalVariable(name: "e_d", scope: !666, file: !6, line: 455, type: !7)
!666 = distinct !DILexicalBlock(scope: !655, file: !6, line: 454, column: 19)
!667 = !DILocation(line: 455, column: 17, scope: !666)
!668 = !DILocation(line: 457, column: 4, scope: !666)
!669 = !DILocation(line: 463, column: 10, scope: !666)
!670 = !DILocation(line: 463, column: 8, scope: !666)
!671 = !DILocation(line: 464, column: 8, scope: !672)
!672 = distinct !DILexicalBlock(scope: !666, file: !6, line: 464, column: 8)
!673 = !DILocation(line: 464, column: 15, scope: !672)
!674 = !DILocation(line: 464, column: 12, scope: !672)
!675 = !DILocation(line: 464, column: 8, scope: !666)
!676 = !DILocation(line: 465, column: 17, scope: !677)
!677 = distinct !DILexicalBlock(scope: !672, file: !6, line: 464, column: 22)
!678 = !DILocation(line: 465, column: 25, scope: !677)
!679 = !DILocation(line: 465, column: 29, scope: !677)
!680 = !DILocation(line: 465, column: 33, scope: !677)
!681 = !DILocalVariable(name: "global", arg: 1, scope: !682, file: !6, line: 411, type: !29)
!682 = distinct !DISubprogram(name: "epoch_block", scope: !6, file: !6, line: 411, type: !683, scopeLine: 413, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!683 = !DISubroutineType(types: !684)
!684 = !{null, !29, !17, !616, !13}
!685 = !DILocation(line: 411, column: 30, scope: !682, inlinedAt: !686)
!686 = distinct !DILocation(line: 465, column: 5, scope: !677)
!687 = !DILocalVariable(name: "cr", arg: 2, scope: !682, file: !6, line: 411, type: !17)
!688 = !DILocation(line: 411, column: 62, scope: !682, inlinedAt: !686)
!689 = !DILocalVariable(name: "cb", arg: 3, scope: !682, file: !6, line: 412, type: !616)
!690 = !DILocation(line: 412, column: 25, scope: !682, inlinedAt: !686)
!691 = !DILocalVariable(name: "ct", arg: 4, scope: !682, file: !6, line: 412, type: !13)
!692 = !DILocation(line: 412, column: 35, scope: !682, inlinedAt: !686)
!693 = !DILocation(line: 415, column: 6, scope: !694, inlinedAt: !686)
!694 = distinct !DILexicalBlock(scope: !682, file: !6, line: 415, column: 6)
!695 = !DILocation(line: 415, column: 9, scope: !694, inlinedAt: !686)
!696 = !DILocation(line: 415, column: 6, scope: !682, inlinedAt: !686)
!697 = !DILocation(line: 416, column: 3, scope: !694, inlinedAt: !686)
!698 = !DILocation(line: 416, column: 6, scope: !694, inlinedAt: !686)
!699 = !DILocation(line: 416, column: 14, scope: !694, inlinedAt: !686)
!700 = !DILocation(line: 416, column: 18, scope: !694, inlinedAt: !686)
!701 = !DILocation(line: 466, column: 5, scope: !677)
!702 = distinct !{!702, !657, !703, !320}
!703 = !DILocation(line: 485, column: 3, scope: !655)
!704 = !DILocation(line: 473, column: 12, scope: !666)
!705 = !DILocation(line: 473, column: 10, scope: !666)
!706 = !DILocation(line: 474, column: 9, scope: !707)
!707 = distinct !DILexicalBlock(scope: !666, file: !6, line: 474, column: 8)
!708 = !DILocation(line: 474, column: 16, scope: !707)
!709 = !DILocation(line: 474, column: 14, scope: !707)
!710 = !DILocation(line: 474, column: 26, scope: !707)
!711 = !DILocation(line: 474, column: 35, scope: !707)
!712 = !DILocation(line: 474, column: 32, scope: !707)
!713 = !DILocation(line: 474, column: 23, scope: !707)
!714 = !DILocation(line: 474, column: 8, scope: !666)
!715 = !DILocation(line: 475, column: 5, scope: !707)
!716 = !DILocation(line: 477, column: 16, scope: !666)
!717 = !DILocation(line: 477, column: 24, scope: !666)
!718 = !DILocation(line: 477, column: 28, scope: !666)
!719 = !DILocation(line: 477, column: 32, scope: !666)
!720 = !DILocation(line: 411, column: 30, scope: !682, inlinedAt: !721)
!721 = distinct !DILocation(line: 477, column: 4, scope: !666)
!722 = !DILocation(line: 411, column: 62, scope: !682, inlinedAt: !721)
!723 = !DILocation(line: 412, column: 25, scope: !682, inlinedAt: !721)
!724 = !DILocation(line: 412, column: 35, scope: !682, inlinedAt: !721)
!725 = !DILocation(line: 415, column: 6, scope: !694, inlinedAt: !721)
!726 = !DILocation(line: 415, column: 9, scope: !694, inlinedAt: !721)
!727 = !DILocation(line: 415, column: 6, scope: !682, inlinedAt: !721)
!728 = !DILocation(line: 416, column: 3, scope: !694, inlinedAt: !721)
!729 = !DILocation(line: 416, column: 6, scope: !694, inlinedAt: !721)
!730 = !DILocation(line: 416, column: 14, scope: !694, inlinedAt: !721)
!731 = !DILocation(line: 416, column: 18, scope: !694, inlinedAt: !721)
!732 = !DILocation(line: 484, column: 7, scope: !666)
!733 = !DILocation(line: 491, column: 7, scope: !734)
!734 = distinct !DILexicalBlock(scope: !655, file: !6, line: 491, column: 7)
!735 = !DILocation(line: 491, column: 14, scope: !734)
!736 = !DILocation(line: 491, column: 7, scope: !655)
!737 = !DILocation(line: 492, column: 4, scope: !734)
!738 = !DILocation(line: 505, column: 29, scope: !655)
!739 = !DILocation(line: 505, column: 37, scope: !655)
!740 = !DILocation(line: 505, column: 44, scope: !655)
!741 = !DILocation(line: 505, column: 51, scope: !655)
!742 = !DILocation(line: 505, column: 57, scope: !655)
!743 = !DILocation(line: 505, column: 7, scope: !655)
!744 = !DILocation(line: 505, column: 5, scope: !655)
!745 = !DILocation(line: 509, column: 3, scope: !655)
!746 = !DILocation(line: 515, column: 11, scope: !655)
!747 = !DILocation(line: 515, column: 19, scope: !655)
!748 = !DILocation(line: 515, column: 17, scope: !655)
!749 = !DILocation(line: 515, column: 9, scope: !655)
!750 = !DILocation(line: 516, column: 2, scope: !655)
!751 = !DILocation(line: 446, column: 52, scope: !651)
!752 = !DILocation(line: 446, column: 61, scope: !651)
!753 = !DILocation(line: 446, column: 2, scope: !651)
!754 = distinct !{!754, !653, !755, !320}
!755 = !DILocation(line: 516, column: 2, scope: !647)
!756 = !DILabel(scope: !613, name: "leave", file: !6, line: 523)
!757 = !DILocation(line: 523, column: 1, scope: !613)
!758 = !DILocation(line: 524, column: 2, scope: !613)
!759 = !DILocation(line: 525, column: 2, scope: !613)
!760 = distinct !DISubprogram(name: "ck_pr_fence_memory", scope: !264, file: !264, line: 158, type: !265, scopeLine: 158, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!761 = !DILocation(line: 158, column: 1, scope: !760)
!762 = distinct !DISubprogram(name: "ck_epoch_scan", scope: !6, file: !6, line: 321, type: !763, scopeLine: 325, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!763 = !DISubroutineType(types: !764)
!764 = !{!17, !29, !17, !7, !765}
!765 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !118, size: 64)
!766 = !DILocalVariable(name: "global", arg: 1, scope: !762, file: !6, line: 321, type: !29)
!767 = !DILocation(line: 321, column: 32, scope: !762)
!768 = !DILocalVariable(name: "cr", arg: 2, scope: !762, file: !6, line: 322, type: !17)
!769 = !DILocation(line: 322, column: 29, scope: !762)
!770 = !DILocalVariable(name: "epoch", arg: 3, scope: !762, file: !6, line: 323, type: !7)
!771 = !DILocation(line: 323, column: 18, scope: !762)
!772 = !DILocalVariable(name: "af", arg: 4, scope: !762, file: !6, line: 324, type: !765)
!773 = !DILocation(line: 324, column: 11, scope: !762)
!774 = !DILocalVariable(name: "cursor", scope: !762, file: !6, line: 326, type: !278)
!775 = !DILocation(line: 326, column: 20, scope: !762)
!776 = !DILocation(line: 328, column: 6, scope: !777)
!777 = distinct !DILexicalBlock(scope: !762, file: !6, line: 328, column: 6)
!778 = !DILocation(line: 328, column: 9, scope: !777)
!779 = !DILocation(line: 328, column: 6, scope: !762)
!780 = !DILocation(line: 329, column: 12, scope: !781)
!781 = distinct !DILexicalBlock(scope: !777, file: !6, line: 328, column: 18)
!782 = !DILocation(line: 329, column: 10, scope: !781)
!783 = !DILocation(line: 330, column: 4, scope: !781)
!784 = !DILocation(line: 330, column: 7, scope: !781)
!785 = !DILocation(line: 331, column: 2, scope: !781)
!786 = !DILocation(line: 332, column: 13, scope: !787)
!787 = distinct !DILexicalBlock(scope: !777, file: !6, line: 331, column: 9)
!788 = !DILocation(line: 332, column: 17, scope: !787)
!789 = !DILocation(line: 332, column: 10, scope: !787)
!790 = !DILocation(line: 333, column: 4, scope: !787)
!791 = !DILocation(line: 333, column: 7, scope: !787)
!792 = !DILocation(line: 336, column: 2, scope: !762)
!793 = !DILocation(line: 336, column: 9, scope: !762)
!794 = !DILocation(line: 336, column: 16, scope: !762)
!795 = !DILocalVariable(name: "state", scope: !796, file: !6, line: 337, type: !7)
!796 = distinct !DILexicalBlock(scope: !762, file: !6, line: 336, column: 25)
!797 = !DILocation(line: 337, column: 16, scope: !796)
!798 = !DILocalVariable(name: "active", scope: !796, file: !6, line: 337, type: !7)
!799 = !DILocation(line: 337, column: 23, scope: !796)
!800 = !DILocation(line: 339, column: 34, scope: !796)
!801 = !DILocation(line: 339, column: 8, scope: !796)
!802 = !DILocation(line: 339, column: 6, scope: !796)
!803 = !DILocation(line: 341, column: 11, scope: !796)
!804 = !DILocation(line: 341, column: 9, scope: !796)
!805 = !DILocation(line: 342, column: 7, scope: !806)
!806 = distinct !DILexicalBlock(scope: !796, file: !6, line: 342, column: 7)
!807 = !DILocation(line: 342, column: 13, scope: !806)
!808 = !DILocation(line: 342, column: 7, scope: !796)
!809 = !DILocation(line: 343, column: 13, scope: !810)
!810 = distinct !DILexicalBlock(scope: !806, file: !6, line: 342, column: 36)
!811 = !DILocation(line: 343, column: 11, scope: !810)
!812 = !DILocation(line: 344, column: 4, scope: !810)
!813 = distinct !{!813, !792, !814, !320}
!814 = !DILocation(line: 354, column: 2, scope: !762)
!815 = !DILocation(line: 347, column: 12, scope: !796)
!816 = !DILocation(line: 347, column: 10, scope: !796)
!817 = !DILocation(line: 348, column: 10, scope: !796)
!818 = !DILocation(line: 348, column: 4, scope: !796)
!819 = !DILocation(line: 348, column: 7, scope: !796)
!820 = !DILocation(line: 350, column: 7, scope: !821)
!821 = distinct !DILexicalBlock(scope: !796, file: !6, line: 350, column: 7)
!822 = !DILocation(line: 350, column: 14, scope: !821)
!823 = !DILocation(line: 350, column: 19, scope: !821)
!824 = !DILocation(line: 350, column: 22, scope: !821)
!825 = !DILocation(line: 350, column: 53, scope: !821)
!826 = !DILocation(line: 350, column: 50, scope: !821)
!827 = !DILocation(line: 350, column: 7, scope: !796)
!828 = !DILocation(line: 351, column: 11, scope: !821)
!829 = !DILocation(line: 351, column: 4, scope: !821)
!830 = !DILocation(line: 353, column: 12, scope: !796)
!831 = !DILocation(line: 353, column: 10, scope: !796)
!832 = !DILocation(line: 356, column: 2, scope: !762)
!833 = !DILocation(line: 357, column: 1, scope: !762)
!834 = distinct !DISubprogram(name: "ck_pr_stall", scope: !176, file: !176, line: 65, type: !265, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!835 = !DILocation(line: 67, column: 2, scope: !834)
!836 = !{i64 674043}
!837 = !DILocation(line: 68, column: 2, scope: !834)
!838 = distinct !DISubprogram(name: "ck_pr_cas_uint_value", scope: !176, file: !176, line: 479, type: !839, scopeLine: 479, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!839 = !DISubroutineType(types: !840)
!840 = !{!118, !14, !7, !7, !14}
!841 = !DILocalVariable(name: "target", arg: 1, scope: !838, file: !176, line: 479, type: !14)
!842 = !DILocation(line: 479, column: 1, scope: !838)
!843 = !DILocalVariable(name: "compare", arg: 2, scope: !838, file: !176, line: 479, type: !7)
!844 = !DILocalVariable(name: "set", arg: 3, scope: !838, file: !176, line: 479, type: !7)
!845 = !DILocalVariable(name: "v", arg: 4, scope: !838, file: !176, line: 479, type: !14)
!846 = !DILocalVariable(name: "z", scope: !838, file: !176, line: 479, type: !118)
!847 = !{i64 2148251233}
!848 = distinct !DISubprogram(name: "ck_pr_fence_atomic_load", scope: !264, file: !264, line: 150, type: !265, scopeLine: 150, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!849 = !DILocation(line: 150, column: 1, scope: !848)
!850 = distinct !DISubprogram(name: "ck_epoch_synchronize", scope: !6, file: !6, line: 529, type: !449, scopeLine: 530, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!851 = !DILocalVariable(name: "record", arg: 1, scope: !850, file: !6, line: 529, type: !17)
!852 = !DILocation(line: 529, column: 46, scope: !850)
!853 = !DILocation(line: 532, column: 28, scope: !850)
!854 = !DILocation(line: 532, column: 36, scope: !850)
!855 = !DILocation(line: 532, column: 2, scope: !850)
!856 = !DILocation(line: 533, column: 2, scope: !850)
!857 = distinct !DISubprogram(name: "ck_epoch_barrier", scope: !6, file: !6, line: 537, type: !449, scopeLine: 538, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!858 = !DILocalVariable(name: "record", arg: 1, scope: !857, file: !6, line: 537, type: !17)
!859 = !DILocation(line: 537, column: 42, scope: !857)
!860 = !DILocation(line: 540, column: 23, scope: !857)
!861 = !DILocation(line: 540, column: 2, scope: !857)
!862 = !DILocation(line: 541, column: 19, scope: !857)
!863 = !DILocation(line: 541, column: 2, scope: !857)
!864 = !DILocation(line: 542, column: 2, scope: !857)
!865 = distinct !DISubprogram(name: "ck_epoch_barrier_wait", scope: !6, file: !6, line: 546, type: !866, scopeLine: 548, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!866 = !DISubroutineType(types: !867)
!867 = !{null, !17, !616, !13}
!868 = !DILocalVariable(name: "record", arg: 1, scope: !865, file: !6, line: 546, type: !17)
!869 = !DILocation(line: 546, column: 47, scope: !865)
!870 = !DILocalVariable(name: "cb", arg: 2, scope: !865, file: !6, line: 546, type: !616)
!871 = !DILocation(line: 546, column: 75, scope: !865)
!872 = !DILocalVariable(name: "ct", arg: 3, scope: !865, file: !6, line: 547, type: !13)
!873 = !DILocation(line: 547, column: 11, scope: !865)
!874 = !DILocation(line: 550, column: 28, scope: !865)
!875 = !DILocation(line: 550, column: 36, scope: !865)
!876 = !DILocation(line: 550, column: 44, scope: !865)
!877 = !DILocation(line: 550, column: 48, scope: !865)
!878 = !DILocation(line: 550, column: 2, scope: !865)
!879 = !DILocation(line: 551, column: 19, scope: !865)
!880 = !DILocation(line: 551, column: 2, scope: !865)
!881 = !DILocation(line: 552, column: 2, scope: !865)
!882 = distinct !DISubprogram(name: "ck_epoch_poll_deferred", scope: !6, file: !6, line: 566, type: !883, scopeLine: 567, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!883 = !DISubroutineType(types: !884)
!884 = !{!118, !17, !526}
!885 = !DILocalVariable(name: "record", arg: 1, scope: !882, file: !6, line: 566, type: !17)
!886 = !DILocation(line: 566, column: 48, scope: !882)
!887 = !DILocalVariable(name: "deferred", arg: 2, scope: !882, file: !6, line: 566, type: !526)
!888 = !DILocation(line: 566, column: 68, scope: !882)
!889 = !DILocalVariable(name: "active", scope: !882, file: !6, line: 568, type: !118)
!890 = !DILocation(line: 568, column: 7, scope: !882)
!891 = !DILocalVariable(name: "epoch", scope: !882, file: !6, line: 569, type: !7)
!892 = !DILocation(line: 569, column: 15, scope: !882)
!893 = !DILocalVariable(name: "cr", scope: !882, file: !6, line: 570, type: !17)
!894 = !DILocation(line: 570, column: 26, scope: !882)
!895 = !DILocalVariable(name: "global", scope: !882, file: !6, line: 571, type: !29)
!896 = !DILocation(line: 571, column: 19, scope: !882)
!897 = !DILocation(line: 571, column: 28, scope: !882)
!898 = !DILocation(line: 571, column: 36, scope: !882)
!899 = !DILocalVariable(name: "n_dispatch", scope: !882, file: !6, line: 572, type: !7)
!900 = !DILocation(line: 572, column: 15, scope: !882)
!901 = !DILocation(line: 574, column: 10, scope: !882)
!902 = !DILocation(line: 574, column: 8, scope: !882)
!903 = !DILocation(line: 577, column: 2, scope: !882)
!904 = !DILocation(line: 589, column: 33, scope: !882)
!905 = !DILocation(line: 589, column: 41, scope: !882)
!906 = !DILocation(line: 589, column: 47, scope: !882)
!907 = !DILocation(line: 589, column: 52, scope: !882)
!908 = !DILocation(line: 589, column: 15, scope: !882)
!909 = !DILocation(line: 589, column: 13, scope: !882)
!910 = !DILocation(line: 591, column: 21, scope: !882)
!911 = !DILocation(line: 591, column: 29, scope: !882)
!912 = !DILocation(line: 591, column: 33, scope: !882)
!913 = !DILocation(line: 591, column: 7, scope: !882)
!914 = !DILocation(line: 591, column: 5, scope: !882)
!915 = !DILocation(line: 592, column: 6, scope: !916)
!916 = distinct !DILexicalBlock(scope: !882, file: !6, line: 592, column: 6)
!917 = !DILocation(line: 592, column: 9, scope: !916)
!918 = !DILocation(line: 592, column: 6, scope: !882)
!919 = !DILocation(line: 593, column: 11, scope: !916)
!920 = !DILocation(line: 593, column: 22, scope: !916)
!921 = !DILocation(line: 593, column: 3, scope: !916)
!922 = !DILocation(line: 596, column: 6, scope: !923)
!923 = distinct !DILexicalBlock(scope: !882, file: !6, line: 596, column: 6)
!924 = !DILocation(line: 596, column: 13, scope: !923)
!925 = !DILocation(line: 596, column: 6, scope: !882)
!926 = !DILocation(line: 597, column: 19, scope: !927)
!927 = distinct !DILexicalBlock(scope: !923, file: !6, line: 596, column: 23)
!928 = !DILocation(line: 597, column: 3, scope: !927)
!929 = !DILocation(line: 597, column: 11, scope: !927)
!930 = !DILocation(line: 597, column: 17, scope: !927)
!931 = !DILocation(line: 598, column: 14, scope: !932)
!932 = distinct !DILexicalBlock(scope: !927, file: !6, line: 598, column: 3)
!933 = !DILocation(line: 598, column: 8, scope: !932)
!934 = !DILocation(line: 598, column: 19, scope: !935)
!935 = distinct !DILexicalBlock(scope: !932, file: !6, line: 598, column: 3)
!936 = !DILocation(line: 598, column: 25, scope: !935)
!937 = !DILocation(line: 598, column: 3, scope: !932)
!938 = !DILocation(line: 599, column: 22, scope: !935)
!939 = !DILocation(line: 599, column: 30, scope: !935)
!940 = !DILocation(line: 599, column: 37, scope: !935)
!941 = !DILocation(line: 599, column: 4, scope: !935)
!942 = !DILocation(line: 598, column: 49, scope: !935)
!943 = !DILocation(line: 598, column: 3, scope: !935)
!944 = distinct !{!944, !937, !945, !320}
!945 = !DILocation(line: 599, column: 45, scope: !932)
!946 = !DILocation(line: 601, column: 3, scope: !927)
!947 = !DILocation(line: 612, column: 24, scope: !882)
!948 = !DILocation(line: 612, column: 32, scope: !882)
!949 = !DILocation(line: 612, column: 39, scope: !882)
!950 = !DILocation(line: 612, column: 46, scope: !882)
!951 = !DILocation(line: 612, column: 52, scope: !882)
!952 = !DILocation(line: 612, column: 8, scope: !882)
!953 = !DILocation(line: 614, column: 20, scope: !882)
!954 = !DILocation(line: 614, column: 28, scope: !882)
!955 = !DILocation(line: 614, column: 34, scope: !882)
!956 = !DILocation(line: 614, column: 39, scope: !882)
!957 = !DILocation(line: 614, column: 2, scope: !882)
!958 = !DILocation(line: 615, column: 2, scope: !882)
!959 = !DILocation(line: 616, column: 1, scope: !882)
!960 = distinct !DISubprogram(name: "ck_pr_cas_uint", scope: !176, file: !176, line: 479, type: !961, scopeLine: 479, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!961 = !DISubroutineType(types: !962)
!962 = !{!118, !14, !7, !7}
!963 = !DILocalVariable(name: "target", arg: 1, scope: !960, file: !176, line: 479, type: !14)
!964 = !DILocation(line: 479, column: 1, scope: !960)
!965 = !DILocalVariable(name: "compare", arg: 2, scope: !960, file: !176, line: 479, type: !7)
!966 = !DILocalVariable(name: "set", arg: 3, scope: !960, file: !176, line: 479, type: !7)
!967 = !DILocalVariable(name: "z", scope: !960, file: !176, line: 479, type: !118)
!968 = !{i64 2148251155}
!969 = distinct !DISubprogram(name: "ck_epoch_poll", scope: !6, file: !6, line: 619, type: !970, scopeLine: 620, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!970 = !DISubroutineType(types: !971)
!971 = !{!118, !17}
!972 = !DILocalVariable(name: "record", arg: 1, scope: !969, file: !6, line: 619, type: !17)
!973 = !DILocation(line: 619, column: 39, scope: !969)
!974 = !DILocation(line: 622, column: 32, scope: !969)
!975 = !DILocation(line: 622, column: 9, scope: !969)
!976 = !DILocation(line: 622, column: 2, scope: !969)
!977 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 46, type: !978, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !123)
!978 = !DISubroutineType(types: !979)
!979 = !{!12, !12, !980}
!980 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!981 = !DILocalVariable(name: "argc", arg: 1, scope: !977, file: !3, line: 46, type: !12)
!982 = !DILocation(line: 46, column: 14, scope: !977)
!983 = !DILocalVariable(name: "argv", arg: 2, scope: !977, file: !3, line: 46, type: !980)
!984 = !DILocation(line: 46, column: 26, scope: !977)
!985 = !DILocalVariable(name: "threads", scope: !977, file: !3, line: 48, type: !986)
!986 = !DICompositeType(tag: DW_TAG_array_type, baseType: !987, size: 256, elements: !62)
!987 = !DIDerivedType(tag: DW_TAG_typedef, name: "pthread_t", file: !988, line: 27, baseType: !69)
!988 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h", directory: "", checksumkind: CSK_MD5, checksum: "8a5acdbeec491eca11cf81cb1ef77ea7")
!989 = !DILocation(line: 48, column: 12, scope: !977)
!990 = !DILocation(line: 50, column: 2, scope: !977)
!991 = !DILocalVariable(name: "i", scope: !992, file: !3, line: 52, type: !12)
!992 = distinct !DILexicalBlock(scope: !977, file: !3, line: 52, column: 2)
!993 = !DILocation(line: 52, column: 11, scope: !992)
!994 = !DILocation(line: 52, column: 7, scope: !992)
!995 = !DILocation(line: 52, column: 18, scope: !996)
!996 = distinct !DILexicalBlock(scope: !992, file: !3, line: 52, column: 2)
!997 = !DILocation(line: 52, column: 20, scope: !996)
!998 = !DILocation(line: 52, column: 2, scope: !992)
!999 = !DILocation(line: 54, column: 44, scope: !1000)
!1000 = distinct !DILexicalBlock(scope: !996, file: !3, line: 53, column: 2)
!1001 = !DILocation(line: 54, column: 36, scope: !1000)
!1002 = !DILocation(line: 54, column: 3, scope: !1000)
!1003 = !DILocation(line: 55, column: 27, scope: !1000)
!1004 = !DILocation(line: 55, column: 19, scope: !1000)
!1005 = !DILocation(line: 55, column: 54, scope: !1000)
!1006 = !DILocation(line: 55, column: 46, scope: !1000)
!1007 = !DILocation(line: 55, column: 3, scope: !1000)
!1008 = !DILocation(line: 56, column: 2, scope: !1000)
!1009 = !DILocation(line: 52, column: 33, scope: !996)
!1010 = !DILocation(line: 52, column: 2, scope: !996)
!1011 = distinct !{!1011, !998, !1012, !320}
!1012 = !DILocation(line: 56, column: 2, scope: !992)
!1013 = !DILocalVariable(name: "i", scope: !1014, file: !3, line: 58, type: !12)
!1014 = distinct !DILexicalBlock(scope: !977, file: !3, line: 58, column: 2)
!1015 = !DILocation(line: 58, column: 11, scope: !1014)
!1016 = !DILocation(line: 58, column: 7, scope: !1014)
!1017 = !DILocation(line: 58, column: 18, scope: !1018)
!1018 = distinct !DILexicalBlock(scope: !1014, file: !3, line: 58, column: 2)
!1019 = !DILocation(line: 58, column: 20, scope: !1018)
!1020 = !DILocation(line: 58, column: 2, scope: !1014)
!1021 = !DILocation(line: 59, column: 24, scope: !1018)
!1022 = !DILocation(line: 59, column: 16, scope: !1018)
!1023 = !DILocation(line: 59, column: 3, scope: !1018)
!1024 = !DILocation(line: 58, column: 33, scope: !1018)
!1025 = !DILocation(line: 58, column: 2, scope: !1018)
!1026 = distinct !{!1026, !1020, !1027, !320}
!1027 = !DILocation(line: 59, column: 32, scope: !1014)
!1028 = !DILocation(line: 61, column: 2, scope: !977)
!1029 = distinct !DISubprogram(name: "thread", scope: !3, file: !3, line: 25, type: !1030, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1030 = !DISubroutineType(types: !1031)
!1031 = !{!13, !13}
!1032 = !DILocalVariable(name: "arg", arg: 1, scope: !1029, file: !3, line: 25, type: !13)
!1033 = !DILocation(line: 25, column: 27, scope: !1029)
!1034 = !DILocalVariable(name: "record", scope: !1029, file: !3, line: 27, type: !84)
!1035 = !DILocation(line: 27, column: 21, scope: !1029)
!1036 = !DILocation(line: 27, column: 51, scope: !1029)
!1037 = !DILocation(line: 31, column: 17, scope: !1029)
!1038 = !DILocalVariable(name: "record", arg: 1, scope: !1039, file: !19, line: 126, type: !84)
!1039 = distinct !DISubprogram(name: "ck_epoch_begin", scope: !19, file: !19, line: 126, type: !1040, scopeLine: 127, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1040 = !DISubroutineType(types: !1041)
!1041 = !{null, !84, !1042}
!1042 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1043, size: 64)
!1043 = !DIDerivedType(tag: DW_TAG_typedef, name: "ck_epoch_section_t", file: !19, line: 72, baseType: !120)
!1044 = !DILocation(line: 126, column: 35, scope: !1039, inlinedAt: !1045)
!1045 = distinct !DILocation(line: 31, column: 2, scope: !1029)
!1046 = !DILocalVariable(name: "section", arg: 2, scope: !1039, file: !19, line: 126, type: !1042)
!1047 = !DILocation(line: 126, column: 63, scope: !1039, inlinedAt: !1045)
!1048 = !DILocalVariable(name: "epoch", scope: !1039, file: !19, line: 128, type: !29)
!1049 = !DILocation(line: 128, column: 19, scope: !1039, inlinedAt: !1045)
!1050 = !DILocation(line: 128, column: 27, scope: !1039, inlinedAt: !1045)
!1051 = !DILocation(line: 128, column: 35, scope: !1039, inlinedAt: !1045)
!1052 = !DILocation(line: 134, column: 6, scope: !1053, inlinedAt: !1045)
!1053 = distinct !DILexicalBlock(scope: !1039, file: !19, line: 134, column: 6)
!1054 = !DILocation(line: 134, column: 14, scope: !1053, inlinedAt: !1045)
!1055 = !DILocation(line: 134, column: 21, scope: !1053, inlinedAt: !1045)
!1056 = !DILocation(line: 134, column: 6, scope: !1039, inlinedAt: !1045)
!1057 = !DILocalVariable(name: "g_epoch", scope: !1058, file: !19, line: 135, type: !7)
!1058 = distinct !DILexicalBlock(scope: !1053, file: !19, line: 134, column: 27)
!1059 = !DILocation(line: 135, column: 16, scope: !1058, inlinedAt: !1045)
!1060 = !DILocation(line: 143, column: 19, scope: !1058, inlinedAt: !1045)
!1061 = !DILocation(line: 143, column: 27, scope: !1058, inlinedAt: !1045)
!1062 = !DILocation(line: 143, column: 3, scope: !1058, inlinedAt: !1045)
!1063 = !DILocation(line: 144, column: 3, scope: !1058, inlinedAt: !1045)
!1064 = !DILocation(line: 157, column: 13, scope: !1058, inlinedAt: !1045)
!1065 = !DILocation(line: 157, column: 11, scope: !1058, inlinedAt: !1045)
!1066 = !DILocation(line: 158, column: 3, scope: !1058, inlinedAt: !1045)
!1067 = !DILocation(line: 159, column: 2, scope: !1058, inlinedAt: !1045)
!1068 = !DILocation(line: 160, column: 3, scope: !1069, inlinedAt: !1045)
!1069 = distinct !DILexicalBlock(scope: !1053, file: !19, line: 159, column: 9)
!1070 = !DILocation(line: 163, column: 6, scope: !1071, inlinedAt: !1045)
!1071 = distinct !DILexicalBlock(scope: !1039, file: !19, line: 163, column: 6)
!1072 = !DILocation(line: 163, column: 14, scope: !1071, inlinedAt: !1045)
!1073 = !DILocation(line: 163, column: 6, scope: !1039, inlinedAt: !1045)
!1074 = !DILocation(line: 164, column: 20, scope: !1071, inlinedAt: !1045)
!1075 = !DILocation(line: 164, column: 28, scope: !1071, inlinedAt: !1045)
!1076 = !DILocation(line: 164, column: 3, scope: !1071, inlinedAt: !1045)
!1077 = !DILocalVariable(name: "global_epoch", scope: !1029, file: !3, line: 32, type: !12)
!1078 = !DILocation(line: 32, column: 6, scope: !1029)
!1079 = !DILocation(line: 32, column: 21, scope: !1029)
!1080 = !DILocalVariable(name: "local_epoch", scope: !1029, file: !3, line: 33, type: !12)
!1081 = !DILocation(line: 33, column: 6, scope: !1029)
!1082 = !DILocation(line: 33, column: 20, scope: !1029)
!1083 = !DILocation(line: 34, column: 15, scope: !1029)
!1084 = !DILocalVariable(name: "record", arg: 1, scope: !1085, file: !19, line: 174, type: !84)
!1085 = distinct !DISubprogram(name: "ck_epoch_end", scope: !19, file: !19, line: 174, type: !1086, scopeLine: 175, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1086 = !DISubroutineType(types: !1087)
!1087 = !{!118, !84, !1042}
!1088 = !DILocation(line: 174, column: 33, scope: !1085, inlinedAt: !1089)
!1089 = distinct !DILocation(line: 34, column: 2, scope: !1029)
!1090 = !DILocalVariable(name: "section", arg: 2, scope: !1085, file: !19, line: 174, type: !1042)
!1091 = !DILocation(line: 174, column: 61, scope: !1085, inlinedAt: !1089)
!1092 = !DILocation(line: 177, column: 2, scope: !1085, inlinedAt: !1089)
!1093 = !DILocation(line: 178, column: 2, scope: !1085, inlinedAt: !1089)
!1094 = !DILocation(line: 180, column: 6, scope: !1095, inlinedAt: !1089)
!1095 = distinct !DILexicalBlock(scope: !1085, file: !19, line: 180, column: 6)
!1096 = !DILocation(line: 180, column: 14, scope: !1095, inlinedAt: !1089)
!1097 = !DILocation(line: 180, column: 6, scope: !1085, inlinedAt: !1089)
!1098 = !DILocation(line: 181, column: 27, scope: !1095, inlinedAt: !1089)
!1099 = !DILocation(line: 181, column: 35, scope: !1095, inlinedAt: !1089)
!1100 = !DILocation(line: 181, column: 10, scope: !1095, inlinedAt: !1089)
!1101 = !DILocation(line: 181, column: 3, scope: !1095, inlinedAt: !1089)
!1102 = !DILocation(line: 183, column: 9, scope: !1085, inlinedAt: !1089)
!1103 = !DILocation(line: 183, column: 17, scope: !1085, inlinedAt: !1089)
!1104 = !DILocation(line: 183, column: 24, scope: !1085, inlinedAt: !1089)
!1105 = !DILocation(line: 183, column: 2, scope: !1085, inlinedAt: !1089)
!1106 = !DILocation(line: 184, column: 1, scope: !1085, inlinedAt: !1089)
!1107 = !DILocation(line: 37, column: 2, scope: !1108)
!1108 = distinct !DILexicalBlock(scope: !1109, file: !3, line: 37, column: 2)
!1109 = distinct !DILexicalBlock(scope: !1029, file: !3, line: 37, column: 2)
!1110 = !DILocation(line: 37, column: 2, scope: !1109)
!1111 = !DILocation(line: 39, column: 16, scope: !1029)
!1112 = !DILocation(line: 39, column: 2, scope: !1029)
!1113 = !DILocation(line: 41, column: 2, scope: !1029)
!1114 = distinct !DISubprogram(name: "ck_pr_barrier", scope: !1115, file: !1115, line: 37, type: !265, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!1115 = !DIFile(filename: "include/gcc/ck_pr.h", directory: "/home/stefano/huawei/ck", checksumkind: CSK_MD5, checksum: "6bd985a96b46842a406b2123a32bcf68")
!1116 = !DILocation(line: 40, column: 2, scope: !1114)
!1117 = !{i64 793388}
!1118 = !DILocation(line: 41, column: 2, scope: !1114)
!1119 = distinct !DISubprogram(name: "ck_pr_md_load_ptr", scope: !176, file: !176, line: 185, type: !1120, scopeLine: 185, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1120 = !DISubroutineType(types: !1121)
!1121 = !{!13, !346}
!1122 = !DILocalVariable(name: "target", arg: 1, scope: !1119, file: !176, line: 185, type: !346)
!1123 = !DILocation(line: 185, column: 1, scope: !1119)
!1124 = !DILocalVariable(name: "r", scope: !1119, file: !176, line: 185, type: !13)
!1125 = !{i64 2148185089}
!1126 = distinct !DISubprogram(name: "ck_pr_cas_ptr_value", scope: !176, file: !176, line: 473, type: !1127, scopeLine: 473, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1127 = !DISubroutineType(types: !1128)
!1128 = !{!118, !13, !13, !13, !13}
!1129 = !DILocalVariable(name: "target", arg: 1, scope: !1126, file: !176, line: 473, type: !13)
!1130 = !DILocation(line: 473, column: 1, scope: !1126)
!1131 = !DILocalVariable(name: "compare", arg: 2, scope: !1126, file: !176, line: 473, type: !13)
!1132 = !DILocalVariable(name: "set", arg: 3, scope: !1126, file: !176, line: 473, type: !13)
!1133 = !DILocalVariable(name: "v", arg: 4, scope: !1126, file: !176, line: 473, type: !13)
!1134 = !DILocalVariable(name: "z", scope: !1126, file: !176, line: 473, type: !118)
!1135 = !{i64 2148247955}
!1136 = distinct !DISubprogram(name: "ck_stack_batch_pop_upmc", scope: !23, file: !23, line: 151, type: !1137, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1137 = !DISubroutineType(types: !1138)
!1138 = !{!27, !253}
!1139 = !DILocalVariable(name: "target", arg: 1, scope: !1136, file: !23, line: 151, type: !253)
!1140 = !DILocation(line: 151, column: 42, scope: !1136)
!1141 = !DILocalVariable(name: "entry", scope: !1136, file: !23, line: 153, type: !27)
!1142 = !DILocation(line: 153, column: 25, scope: !1136)
!1143 = !DILocation(line: 155, column: 25, scope: !1136)
!1144 = !DILocation(line: 155, column: 33, scope: !1136)
!1145 = !DILocation(line: 155, column: 10, scope: !1136)
!1146 = !DILocation(line: 155, column: 8, scope: !1136)
!1147 = !DILocation(line: 156, column: 2, scope: !1136)
!1148 = !DILocation(line: 157, column: 9, scope: !1136)
!1149 = !DILocation(line: 157, column: 2, scope: !1136)
!1150 = distinct !DISubprogram(name: "ck_epoch_entry_container", scope: !6, file: !6, line: 145, type: !1151, scopeLine: 145, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1151 = !DISubroutineType(types: !1152)
!1152 = !{!73, !278}
!1153 = !DILocalVariable(name: "p", arg: 1, scope: !1150, file: !6, line: 145, type: !278)
!1154 = !DILocation(line: 145, column: 1, scope: !1150)
!1155 = distinct !DISubprogram(name: "ck_stack_push_spnc", scope: !23, file: !23, line: 291, type: !417, scopeLine: 292, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1156 = !DILocalVariable(name: "target", arg: 1, scope: !1155, file: !23, line: 291, type: !253)
!1157 = !DILocation(line: 291, column: 37, scope: !1155)
!1158 = !DILocalVariable(name: "entry", arg: 2, scope: !1155, file: !23, line: 291, type: !27)
!1159 = !DILocation(line: 291, column: 68, scope: !1155)
!1160 = !DILocation(line: 294, column: 16, scope: !1155)
!1161 = !DILocation(line: 294, column: 24, scope: !1155)
!1162 = !DILocation(line: 294, column: 2, scope: !1155)
!1163 = !DILocation(line: 294, column: 9, scope: !1155)
!1164 = !DILocation(line: 294, column: 14, scope: !1155)
!1165 = !DILocation(line: 295, column: 17, scope: !1155)
!1166 = !DILocation(line: 295, column: 2, scope: !1155)
!1167 = !DILocation(line: 295, column: 10, scope: !1155)
!1168 = !DILocation(line: 295, column: 15, scope: !1155)
!1169 = !DILocation(line: 296, column: 2, scope: !1155)
!1170 = distinct !DISubprogram(name: "ck_pr_add_uint", scope: !176, file: !176, line: 400, type: !177, scopeLine: 400, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1171 = !DILocalVariable(name: "target", arg: 1, scope: !1170, file: !176, line: 400, type: !14)
!1172 = !DILocation(line: 400, column: 1, scope: !1170)
!1173 = !DILocalVariable(name: "d", arg: 2, scope: !1170, file: !176, line: 400, type: !7)
!1174 = !{i64 2148229752}
!1175 = distinct !DISubprogram(name: "ck_pr_sub_uint", scope: !176, file: !176, line: 401, type: !177, scopeLine: 401, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1176 = !DILocalVariable(name: "target", arg: 1, scope: !1175, file: !176, line: 401, type: !14)
!1177 = !DILocation(line: 401, column: 1, scope: !1175)
!1178 = !DILocalVariable(name: "d", arg: 2, scope: !1175, file: !176, line: 401, type: !7)
!1179 = !{i64 2148233635}
!1180 = distinct !DISubprogram(name: "ck_pr_fas_ptr", scope: !176, file: !176, line: 152, type: !1181, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !123)
!1181 = !DISubroutineType(types: !1182)
!1182 = !{!13, !13, !13}
!1183 = !DILocalVariable(name: "target", arg: 1, scope: !1180, file: !176, line: 152, type: !13)
!1184 = !DILocation(line: 152, column: 1, scope: !1180)
!1185 = !DILocalVariable(name: "v", arg: 2, scope: !1180, file: !176, line: 152, type: !13)
!1186 = !{i64 2148181791}
!1187 = distinct !DISubprogram(name: "ck_pr_fence_strict_memory", scope: !176, file: !176, line: 90, type: !265, scopeLine: 90, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!1188 = !DILocation(line: 90, column: 1, scope: !1187)
!1189 = !{i64 2148180459}
!1190 = distinct !DISubprogram(name: "ck_pr_fence_release", scope: !264, file: !264, line: 160, type: !265, scopeLine: 160, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2)
!1191 = !DILocation(line: 160, column: 1, scope: !1190)
