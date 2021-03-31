; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-simplify -loop-fusion < %s | FileCheck %s

@B = common global [1024 x i32] zeroinitializer, align 16

define void @dep_free(i32* noalias %arg) {
; CHECK-LABEL: @dep_free(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB7:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[DOT014:%.*]] = phi i32 [ 0, [[BB:%.*]] ], [ [[TMP15:%.*]], [[BB27:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV23:%.*]] = phi i64 [ 0, [[BB]] ], [ [[INDVARS_IV_NEXT3:%.*]], [[BB27]] ]
; CHECK-NEXT:    [[DOT02:%.*]] = phi i32 [ 0, [[BB]] ], [ [[TMP28:%.*]], [[BB27]] ]
; CHECK-NEXT:    [[INDVARS_IV1:%.*]] = phi i64 [ 0, [[BB]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BB27]] ]
; CHECK-NEXT:    [[TMP:%.*]] = add nsw i32 [[DOT014]], -3
; CHECK-NEXT:    [[TMP8:%.*]] = add nuw nsw i64 [[INDVARS_IV23]], 3
; CHECK-NEXT:    [[TMP9:%.*]] = trunc i64 [[TMP8]] to i32
; CHECK-NEXT:    [[TMP10:%.*]] = mul nsw i32 [[TMP]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = trunc i64 [[INDVARS_IV23]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = srem i32 [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, i32* [[ARG:%.*]], i64 [[INDVARS_IV23]]
; CHECK-NEXT:    store i32 [[TMP12]], i32* [[TMP13]], align 4
; CHECK-NEXT:    br label [[BB14:%.*]]
; CHECK:       bb14:
; CHECK-NEXT:    [[TMP20:%.*]] = add nsw i32 [[DOT02]], -3
; CHECK-NEXT:    [[TMP21:%.*]] = add nuw nsw i64 [[INDVARS_IV1]], 3
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[TMP21]] to i32
; CHECK-NEXT:    [[TMP23:%.*]] = mul nsw i32 [[TMP20]], [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = trunc i64 [[INDVARS_IV1]] to i32
; CHECK-NEXT:    [[TMP25:%.*]] = srem i32 [[TMP23]], [[TMP24]]
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 [[INDVARS_IV1]]
; CHECK-NEXT:    store i32 [[TMP25]], i32* [[TMP26]], align 4
; CHECK-NEXT:    br label [[BB27]]
; CHECK:       bb27:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3]] = add nuw nsw i64 [[INDVARS_IV23]], 1
; CHECK-NEXT:    [[TMP15]] = add nuw nsw i32 [[DOT014]], 1
; CHECK-NEXT:    [[EXITCOND4:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3]], 100
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV1]], 1
; CHECK-NEXT:    [[TMP28]] = add nuw nsw i32 [[DOT02]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB7]], label [[BB18:%.*]]
; CHECK:       bb18:
; CHECK-NEXT:    br label [[BB29:%.*]]
; CHECK:       bb29:
; CHECK-NEXT:    ret void
;
bb:
  br label %bb7

bb7:                                              ; preds = %bb, %bb14
  %.014 = phi i32 [ 0, %bb ], [ %tmp15, %bb14 ]
  %indvars.iv23 = phi i64 [ 0, %bb ], [ %indvars.iv.next3, %bb14 ]
  %tmp = add nsw i32 %.014, -3
  %tmp8 = add nuw nsw i64 %indvars.iv23, 3
  %tmp9 = trunc i64 %tmp8 to i32
  %tmp10 = mul nsw i32 %tmp, %tmp9
  %tmp11 = trunc i64 %indvars.iv23 to i32
  %tmp12 = srem i32 %tmp10, %tmp11
  %tmp13 = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv23
  store i32 %tmp12, i32* %tmp13, align 4
  br label %bb14

bb14:                                             ; preds = %bb7
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv23, 1
  %tmp15 = add nuw nsw i32 %.014, 1
  %exitcond4 = icmp ne i64 %indvars.iv.next3, 100
  br i1 %exitcond4, label %bb7, label %bb17.preheader

bb17.preheader:                                   ; preds = %bb14
  br label %bb19

bb19:                                             ; preds = %bb17.preheader, %bb27
  %.02 = phi i32 [ 0, %bb17.preheader ], [ %tmp28, %bb27 ]
  %indvars.iv1 = phi i64 [ 0, %bb17.preheader ], [ %indvars.iv.next, %bb27 ]
  %tmp20 = add nsw i32 %.02, -3
  %tmp21 = add nuw nsw i64 %indvars.iv1, 3
  %tmp22 = trunc i64 %tmp21 to i32
  %tmp23 = mul nsw i32 %tmp20, %tmp22
  %tmp24 = trunc i64 %indvars.iv1 to i32
  %tmp25 = srem i32 %tmp23, %tmp24
  %tmp26 = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 %indvars.iv1
  store i32 %tmp25, i32* %tmp26, align 4
  br label %bb27

bb27:                                             ; preds = %bb19
  %indvars.iv.next = add nuw nsw i64 %indvars.iv1, 1
  %tmp28 = add nuw nsw i32 %.02, 1
  %exitcond = icmp ne i64 %indvars.iv.next, 100
  br i1 %exitcond, label %bb19, label %bb18

bb18:                                             ; preds = %bb27
  br label %bb29

bb29:                                             ; preds = %bb18
  ret void
}

define void @dep_free_parametric(i32* noalias %arg, i64 %arg2) {
; CHECK-LABEL: @dep_free_parametric(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP3:%.*]] = icmp slt i64 0, [[ARG2:%.*]]
; CHECK-NEXT:    [[TMP161:%.*]] = icmp slt i64 0, [[ARG2]]
; CHECK-NEXT:    br i1 [[TMP3]], label [[BB5_PREHEADER:%.*]], label [[BB27:%.*]]
; CHECK:       bb5.preheader:
; CHECK-NEXT:    br label [[BB5:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    [[DOT014:%.*]] = phi i64 [ [[TMP13:%.*]], [[BB25:%.*]] ], [ 0, [[BB5_PREHEADER]] ]
; CHECK-NEXT:    [[DOT02:%.*]] = phi i64 [ [[TMP26:%.*]], [[BB25]] ], [ 0, [[BB5_PREHEADER]] ]
; CHECK-NEXT:    [[TMP6:%.*]] = add nsw i64 [[DOT014]], -3
; CHECK-NEXT:    [[TMP7:%.*]] = add nuw nsw i64 [[DOT014]], 3
; CHECK-NEXT:    [[TMP8:%.*]] = mul nsw i64 [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = srem i64 [[TMP8]], [[DOT014]]
; CHECK-NEXT:    [[TMP10:%.*]] = trunc i64 [[TMP9]] to i32
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i32, i32* [[ARG:%.*]], i64 [[DOT014]]
; CHECK-NEXT:    store i32 [[TMP10]], i32* [[TMP11]], align 4
; CHECK-NEXT:    br label [[BB12:%.*]]
; CHECK:       bb12:
; CHECK-NEXT:    [[TMP19:%.*]] = add nsw i64 [[DOT02]], -3
; CHECK-NEXT:    [[TMP20:%.*]] = add nuw nsw i64 [[DOT02]], 3
; CHECK-NEXT:    [[TMP21:%.*]] = mul nsw i64 [[TMP19]], [[TMP20]]
; CHECK-NEXT:    [[TMP22:%.*]] = srem i64 [[TMP21]], [[DOT02]]
; CHECK-NEXT:    [[TMP23:%.*]] = trunc i64 [[TMP22]] to i32
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 [[DOT02]]
; CHECK-NEXT:    store i32 [[TMP23]], i32* [[TMP24]], align 4
; CHECK-NEXT:    br label [[BB25]]
; CHECK:       bb25:
; CHECK-NEXT:    [[TMP13]] = add nuw nsw i64 [[DOT014]], 1
; CHECK-NEXT:    [[TMP:%.*]] = icmp slt i64 [[TMP13]], [[ARG2]]
; CHECK-NEXT:    [[TMP26]] = add nuw nsw i64 [[DOT02]], 1
; CHECK-NEXT:    [[TMP16:%.*]] = icmp slt i64 [[TMP26]], [[ARG2]]
; CHECK-NEXT:    br i1 [[TMP16]], label [[BB5]], label [[BB27_LOOPEXIT:%.*]]
; CHECK:       bb27.loopexit:
; CHECK-NEXT:    br label [[BB27]]
; CHECK:       bb27:
; CHECK-NEXT:    ret void
;
bb:
  %tmp3 = icmp slt i64 0, %arg2
  br i1 %tmp3, label %bb5, label %bb15.preheader

bb5:                                              ; preds = %bb5, %bb12
  %.014 = phi i64 [ 0, %bb ], [ %tmp13, %bb12 ]
  %tmp6 = add nsw i64 %.014, -3
  %tmp7 = add nuw nsw i64 %.014, 3
  %tmp8 = mul nsw i64 %tmp6, %tmp7
  %tmp9 = srem i64 %tmp8, %.014
  %tmp10 = trunc i64 %tmp9 to i32
  %tmp11 = getelementptr inbounds i32, i32* %arg, i64 %.014
  store i32 %tmp10, i32* %tmp11, align 4
  br label %bb12

bb12:                                             ; preds = %bb5
  %tmp13 = add nuw nsw i64 %.014, 1
  %tmp = icmp slt i64 %tmp13, %arg2
  br i1 %tmp, label %bb5, label %bb15.preheader

bb15.preheader:                                   ; preds = %bb12, %bb
  %tmp161 = icmp slt i64 0, %arg2
  br i1 %tmp161, label %bb18, label %bb27

bb18:                                             ; preds = %bb15.preheader, %bb25
  %.02 = phi i64 [ 0, %bb15.preheader ], [ %tmp26, %bb25 ]
  %tmp19 = add nsw i64 %.02, -3
  %tmp20 = add nuw nsw i64 %.02, 3
  %tmp21 = mul nsw i64 %tmp19, %tmp20
  %tmp22 = srem i64 %tmp21, %.02
  %tmp23 = trunc i64 %tmp22 to i32
  %tmp24 = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 %.02
  store i32 %tmp23, i32* %tmp24, align 4
  br label %bb25

bb25:                                             ; preds = %bb18
  %tmp26 = add nuw nsw i64 %.02, 1
  %tmp16 = icmp slt i64 %tmp26, %arg2
  br i1 %tmp16, label %bb18, label %bb27

bb27:                                             ; preds = %bb17
  ret void
}

define void @raw_only(i32* noalias %arg) {
; CHECK-LABEL: @raw_only(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB7:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[INDVARS_IV22:%.*]] = phi i64 [ 0, [[BB:%.*]] ], [ [[INDVARS_IV_NEXT3:%.*]], [[BB18:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV1:%.*]] = phi i64 [ 0, [[BB]] ], [ [[INDVARS_IV_NEXT:%.*]], [[BB18]] ]
; CHECK-NEXT:    [[TMP:%.*]] = getelementptr inbounds i32, i32* [[ARG:%.*]], i64 [[INDVARS_IV22]]
; CHECK-NEXT:    [[TMP8:%.*]] = trunc i64 [[INDVARS_IV22]] to i32
; CHECK-NEXT:    store i32 [[TMP8]], i32* [[TMP]], align 4
; CHECK-NEXT:    br label [[BB9:%.*]]
; CHECK:       bb9:
; CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds i32, i32* [[ARG]], i64 [[INDVARS_IV1]]
; CHECK-NEXT:    [[TMP15:%.*]] = load i32, i32* [[TMP14]], align 4
; CHECK-NEXT:    [[TMP16:%.*]] = shl nsw i32 [[TMP15]], 1
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 [[INDVARS_IV1]]
; CHECK-NEXT:    store i32 [[TMP16]], i32* [[TMP17]], align 4
; CHECK-NEXT:    br label [[BB18]]
; CHECK:       bb18:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3]] = add nuw nsw i64 [[INDVARS_IV22]], 1
; CHECK-NEXT:    [[EXITCOND4:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3]], 100
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV1]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB7]], label [[BB19:%.*]]
; CHECK:       bb19:
; CHECK-NEXT:    ret void
;
bb:
  br label %bb7

bb11.preheader:                                   ; preds = %bb9
  br label %bb13

bb7:                                              ; preds = %bb, %bb9
  %indvars.iv22 = phi i64 [ 0, %bb ], [ %indvars.iv.next3, %bb9 ]
  %tmp = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv22
  %tmp8 = trunc i64 %indvars.iv22 to i32
  store i32 %tmp8, i32* %tmp, align 4
  br label %bb9

bb9:                                              ; preds = %bb7
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv22, 1
  %exitcond4 = icmp ne i64 %indvars.iv.next3, 100
  br i1 %exitcond4, label %bb7, label %bb11.preheader

bb13:                                             ; preds = %bb11.preheader, %bb18
  %indvars.iv1 = phi i64 [ 0, %bb11.preheader ], [ %indvars.iv.next, %bb18 ]
  %tmp14 = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv1
  %tmp15 = load i32, i32* %tmp14, align 4
  %tmp16 = shl nsw i32 %tmp15, 1
  %tmp17 = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 %indvars.iv1
  store i32 %tmp16, i32* %tmp17, align 4
  br label %bb18

bb18:                                             ; preds = %bb13
  %indvars.iv.next = add nuw nsw i64 %indvars.iv1, 1
  %exitcond = icmp ne i64 %indvars.iv.next, 100 br i1 %exitcond, label %bb13, label %bb19

bb19:                                             ; preds = %bb18
  ret void
}

define void @raw_only_parametric(i32* noalias %arg, i32 %arg4) {
; CHECK-LABEL: @raw_only_parametric(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP:%.*]] = sext i32 [[ARG4:%.*]] to i64
; CHECK-NEXT:    [[TMP64:%.*]] = icmp sgt i32 [[ARG4]], 0
; CHECK-NEXT:    br i1 [[TMP64]], label [[BB8_PREHEADER:%.*]], label [[BB23:%.*]]
; CHECK:       bb8.preheader:
; CHECK-NEXT:    br label [[BB8:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    [[INDVARS_IV25:%.*]] = phi i64 [ [[INDVARS_IV_NEXT3:%.*]], [[BB8]] ], [ 0, [[BB8_PREHEADER]] ]
; CHECK-NEXT:    [[INDVARS_IV3:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BB8]] ], [ 0, [[BB8_PREHEADER]] ]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i32, i32* [[ARG:%.*]], i64 [[INDVARS_IV25]]
; CHECK-NEXT:    [[TMP10:%.*]] = trunc i64 [[INDVARS_IV25]] to i32
; CHECK-NEXT:    store i32 [[TMP10]], i32* [[TMP9]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT3]] = add nuw nsw i64 [[INDVARS_IV25]], 1
; CHECK-NEXT:    [[TMP6:%.*]] = icmp slt i64 [[INDVARS_IV_NEXT3]], [[TMP]]
; CHECK-NEXT:    [[TMP18:%.*]] = getelementptr inbounds i32, i32* [[ARG]], i64 [[INDVARS_IV3]]
; CHECK-NEXT:    [[TMP19:%.*]] = load i32, i32* [[TMP18]], align 4
; CHECK-NEXT:    [[TMP20:%.*]] = shl nsw i32 [[TMP19]], 1
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 [[INDVARS_IV3]]
; CHECK-NEXT:    store i32 [[TMP20]], i32* [[TMP21]], align 4
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV3]], 1
; CHECK-NEXT:    [[TMP15:%.*]] = icmp slt i64 [[INDVARS_IV_NEXT]], [[TMP]]
; CHECK-NEXT:    br i1 [[TMP15]], label [[BB8]], label [[BB23_LOOPEXIT:%.*]]
; CHECK:       bb23.loopexit:
; CHECK-NEXT:    br label [[BB23]]
; CHECK:       bb23:
; CHECK-NEXT:    ret void
;
bb:
  %tmp = sext i32 %arg4 to i64
  %tmp64 = icmp sgt i32 %arg4, 0
  br i1 %tmp64, label %bb8, label %bb23

bb8:                                              ; preds = %bb, %bb8
  %indvars.iv25 = phi i64 [ %indvars.iv.next3, %bb8 ], [ 0, %bb ]
  %tmp9 = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv25
  %tmp10 = trunc i64 %indvars.iv25 to i32
  store i32 %tmp10, i32* %tmp9, align 4
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv25, 1
  %tmp6 = icmp slt i64 %indvars.iv.next3, %tmp
  br i1 %tmp6, label %bb8, label %bb17

bb17:                                             ; preds = %bb8, %bb17
  %indvars.iv3 = phi i64 [ %indvars.iv.next, %bb17 ], [ 0, %bb8 ]
  %tmp18 = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv3
  %tmp19 = load i32, i32* %tmp18, align 4
  %tmp20 = shl nsw i32 %tmp19, 1
  %tmp21 = getelementptr inbounds [1024 x i32], [1024 x i32]* @B, i64 0, i64 %indvars.iv3
  store i32 %tmp20, i32* %tmp21, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv3, 1
  %tmp15 = icmp slt i64 %indvars.iv.next, %tmp
  br i1 %tmp15, label %bb17, label %bb23

bb23:                                             ; preds = %bb17, %bb
  ret void
}

define void @forward_dep(i32* noalias %arg) {
; CHECK-LABEL: @forward_dep(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB7:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    [[DOT013:%.*]] = phi i32 [ 0, [[BB:%.*]] ], [ [[TMP15:%.*]], [[BB14:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV22:%.*]] = phi i64 [ 0, [[BB]] ], [ [[INDVARS_IV_NEXT3:%.*]], [[BB14]] ]
; CHECK-NEXT:    [[TMP:%.*]] = add nsw i32 [[DOT013]], -3
; CHECK-NEXT:    [[TMP8:%.*]] = add nuw nsw i64 [[INDVARS_IV22]], 3
; CHECK-NEXT:    [[TMP9:%.*]] = trunc i64 [[TMP8]] to i32
; CHECK-NEXT:    [[TMP10:%.*]] = mul nsw i32 [[TMP]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = trunc i64 [[INDVARS_IV22]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = srem i32 [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, i32* [[ARG:%.*]], i64 [[INDVARS_IV22]]
; CHECK-NEXT:    store i32 [[TMP12]], i32* [[TMP13]], align 4
; CHECK-NEXT:    br label [[BB14]]
; CHECK:       bb14:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3]] = add nuw nsw i64 [[INDVARS_IV22]], 1
; CHECK-NEXT:    [[TMP15]] = add nuw nsw i32 [[DOT013]], 1
; CHECK-NEXT:    [[EXITCOND4:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3]], 100
; CHECK-NEXT:    br i1 [[EXITCOND4]], label [[BB7]], label [[BB19_PREHEADER:%.*]]
; CHECK:       bb19.preheader:
; CHECK-NEXT:    br label [[BB19:%.*]]
; CHECK:       bb19:
; CHECK-NEXT:    [[INDVARS_IV1:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BB25:%.*]] ], [ 0, [[BB19_PREHEADER]] ]
; CHECK-NEXT:    [[TMP20:%.*]] = add nsw i64 [[INDVARS_IV1]], -3
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i32, i32* [[ARG]], i64 [[TMP20]]
; CHECK-NEXT:    [[TMP22:%.*]] = load i32, i32* [[TMP21]], align 4
; CHECK-NEXT:    [[TMP23:%.*]] = mul nsw i32 [[TMP22]], 3
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i32, i32* [[ARG]], i64 [[INDVARS_IV1]]
; CHECK-NEXT:    store i32 [[TMP23]], i32* [[TMP24]], align 4
; CHECK-NEXT:    br label [[BB25]]
; CHECK:       bb25:
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV1]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[BB19]], label [[BB26:%.*]]
; CHECK:       bb26:
; CHECK-NEXT:    ret void
;
bb:
  br label %bb7

bb7:                                              ; preds = %bb, %bb14
  %.013 = phi i32 [ 0, %bb ], [ %tmp15, %bb14 ]
  %indvars.iv22 = phi i64 [ 0, %bb ], [ %indvars.iv.next3, %bb14 ]
  %tmp = add nsw i32 %.013, -3
  %tmp8 = add nuw nsw i64 %indvars.iv22, 3
  %tmp9 = trunc i64 %tmp8 to i32
  %tmp10 = mul nsw i32 %tmp, %tmp9
  %tmp11 = trunc i64 %indvars.iv22 to i32
  %tmp12 = srem i32 %tmp10, %tmp11
  %tmp13 = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv22
  store i32 %tmp12, i32* %tmp13, align 4
  br label %bb14

bb14:                                             ; preds = %bb7
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv22, 1
  %tmp15 = add nuw nsw i32 %.013, 1
  %exitcond4 = icmp ne i64 %indvars.iv.next3, 100
  br i1 %exitcond4, label %bb7, label %bb19

bb19:                                             ; preds = %bb14, %bb25
  %indvars.iv1 = phi i64 [ 0, %bb14 ], [ %indvars.iv.next, %bb25 ]
  %tmp20 = add nsw i64 %indvars.iv1, -3
  %tmp21 = getelementptr inbounds i32, i32* %arg, i64 %tmp20
  %tmp22 = load i32, i32* %tmp21, align 4
  %tmp23 = mul nsw i32 %tmp22, 3
  %tmp24 = getelementptr inbounds i32, i32* %arg, i64 %indvars.iv1
  store i32 %tmp23, i32* %tmp24, align 4
  br label %bb25

bb25:                                             ; preds = %bb19
  %indvars.iv.next = add nuw nsw i64 %indvars.iv1, 1
  %exitcond = icmp ne i64 %indvars.iv.next, 100
  br i1 %exitcond, label %bb19, label %bb26

bb26:                                             ; preds = %bb25
  ret void
}

; Test that instructions in loop 1 latch are moved to the beginning of loop 2
; latch iff it is proven safe. %inc.first and %cmp.first are moved, but
; `store i32 0, i32* %Ai.first` is not.

define void @flow_dep(i32* noalias %A, i32* noalias %B) {
; CHECK-LABEL: @flow_dep(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_FIRST:%.*]]
; CHECK:       for.first:
; CHECK-NEXT:    [[I_FIRST:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC_FIRST:%.*]], [[FOR_SECOND_LATCH:%.*]] ]
; CHECK-NEXT:    [[I_SECOND:%.*]] = phi i64 [ [[INC_SECOND:%.*]], [[FOR_SECOND_LATCH]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    [[AI_FIRST:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[I_FIRST]]
; CHECK-NEXT:    store i32 0, i32* [[AI_FIRST]], align 4
; CHECK-NEXT:    [[AI_SECOND:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[I_SECOND]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[AI_SECOND]], align 4
; CHECK-NEXT:    [[BI:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i64 [[I_SECOND]]
; CHECK-NEXT:    store i32 [[TMP0]], i32* [[BI]], align 4
; CHECK-NEXT:    br label [[FOR_SECOND_LATCH]]
; CHECK:       for.second.latch:
; CHECK-NEXT:    [[INC_FIRST]] = add nsw i64 [[I_FIRST]], 1
; CHECK-NEXT:    [[CMP_FIRST:%.*]] = icmp slt i64 [[INC_FIRST]], 100
; CHECK-NEXT:    [[INC_SECOND]] = add nsw i64 [[I_SECOND]], 1
; CHECK-NEXT:    [[CMP_SECOND:%.*]] = icmp slt i64 [[INC_SECOND]], 100
; CHECK-NEXT:    br i1 [[CMP_SECOND]], label [[FOR_FIRST]], label [[FOR_END:%.*]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for.first

for.first:
  %i.first = phi i64 [ 0, %entry ], [ %inc.first, %for.first ]
  %Ai.first = getelementptr inbounds i32, i32* %A, i64 %i.first
  store i32 0, i32* %Ai.first, align 4
  %inc.first = add nsw i64 %i.first, 1
  %cmp.first = icmp slt i64 %inc.first, 100
  br i1 %cmp.first, label %for.first, label %for.second.preheader

for.second.preheader:
  br label %for.second

for.second:
  %i.second = phi i64 [ %inc.second, %for.second.latch ], [ 0, %for.second.preheader ]
  %Ai.second = getelementptr inbounds i32, i32* %A, i64 %i.second
  %0 = load i32, i32* %Ai.second, align 4
  %Bi = getelementptr inbounds i32, i32* %B, i64 %i.second
  store i32 %0, i32* %Bi, align 4
  br label %for.second.latch

for.second.latch:
  %inc.second = add nsw i64 %i.second, 1
  %cmp.second = icmp slt i64 %inc.second, 100
  br i1 %cmp.second, label %for.second, label %for.end

for.end:
  ret void
}

; Test that `%add` is moved in basic block entry, and the two loops for.first
; and for.second are fused.

define i32 @moveinsts_preheader(i32* %A, i32 %x) {
; CHECK-LABEL: @moveinsts_preheader(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[X:%.*]], 1
; CHECK-NEXT:    br label [[FOR_FIRST:%.*]]
; CHECK:       for.first:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC_I:%.*]], [[FOR_FIRST]] ]
; CHECK-NEXT:    [[J:%.*]] = phi i64 [ 0, [[ENTRY]] ], [ [[INC_J:%.*]], [[FOR_FIRST]] ]
; CHECK-NEXT:    [[AI:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[I]]
; CHECK-NEXT:    store i32 0, i32* [[AI]], align 4
; CHECK-NEXT:    [[INC_I]] = add nsw i64 [[I]], 1
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp slt i64 [[INC_I]], 100
; CHECK-NEXT:    [[AJ:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[J]]
; CHECK-NEXT:    store i32 2, i32* [[AJ]], align 4
; CHECK-NEXT:    [[INC_J]] = add nsw i64 [[J]], 1
; CHECK-NEXT:    [[CMP_J:%.*]] = icmp slt i64 [[INC_J]], 100
; CHECK-NEXT:    br i1 [[CMP_J]], label [[FOR_FIRST]], label [[FOR_SECOND_EXIT:%.*]]
; CHECK:       for.second.exit:
; CHECK-NEXT:    ret i32 [[ADD]]
;
entry:
  br label %for.first

for.first:
  %i = phi i64 [ 0, %entry ], [ %inc.i, %for.first ]
  %Ai = getelementptr inbounds i32, i32* %A, i64 %i
  store i32 0, i32* %Ai, align 4
  %inc.i = add nsw i64 %i, 1
  %cmp.i = icmp slt i64 %inc.i, 100
  br i1 %cmp.i, label %for.first, label %for.first.exit

for.first.exit:
  %add = add nsw i32 %x, 1
  br label %for.second

for.second:
  %j = phi i64 [ 0, %for.first.exit ], [ %inc.j, %for.second ]
  %Aj = getelementptr inbounds i32, i32* %A, i64 %j
  store i32 2, i32* %Aj, align 4
  %inc.j = add nsw i64 %j, 1
  %cmp.j = icmp slt i64 %inc.j, 100
  br i1 %cmp.j, label %for.second, label %for.second.exit

for.second.exit:
  ret i32 %add
}

; Test that `%add` cannot be moved to basic block entry, as it uses %i, which
; defined after basic block entry. And the two loops for.first and for.second
; are not fused.

define i64 @unsafe_preheader(i32* %A, i64 %x) {
; CHECK-LABEL: @unsafe_preheader(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_FIRST:%.*]]
; CHECK:       for.first:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INC_I:%.*]], [[FOR_FIRST]] ]
; CHECK-NEXT:    [[AI:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i64 [[I]]
; CHECK-NEXT:    store i32 0, i32* [[AI]], align 4
; CHECK-NEXT:    [[INC_I]] = add nsw i64 [[I]], 1
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp slt i64 [[INC_I]], 100
; CHECK-NEXT:    br i1 [[CMP_I]], label [[FOR_FIRST]], label [[FOR_FIRST_EXIT:%.*]]
; CHECK:       for.first.exit:
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i64 [[X:%.*]], [[I]]
; CHECK-NEXT:    br label [[FOR_SECOND:%.*]]
; CHECK:       for.second:
; CHECK-NEXT:    [[J:%.*]] = phi i64 [ 0, [[FOR_FIRST_EXIT]] ], [ [[INC_J:%.*]], [[FOR_SECOND]] ]
; CHECK-NEXT:    [[AJ:%.*]] = getelementptr inbounds i32, i32* [[A]], i64 [[J]]
; CHECK-NEXT:    store i32 2, i32* [[AJ]], align 4
; CHECK-NEXT:    [[INC_J]] = add nsw i64 [[J]], 1
; CHECK-NEXT:    [[CMP_J:%.*]] = icmp slt i64 [[INC_J]], 100
; CHECK-NEXT:    br i1 [[CMP_J]], label [[FOR_SECOND]], label [[FOR_SECOND_EXIT:%.*]]
; CHECK:       for.second.exit:
; CHECK-NEXT:    ret i64 [[ADD]]
;
entry:
  br label %for.first

for.first:
  %i = phi i64 [ 0, %entry ], [ %inc.i, %for.first ]
  %Ai = getelementptr inbounds i32, i32* %A, i64 %i
  store i32 0, i32* %Ai, align 4
  %inc.i = add nsw i64 %i, 1
  %cmp.i = icmp slt i64 %inc.i, 100
  br i1 %cmp.i, label %for.first, label %for.first.exit

for.first.exit:
  %add = add nsw i64 %x, %i
  br label %for.second

for.second:
  %j = phi i64 [ 0, %for.first.exit ], [ %inc.j, %for.second ]
  %Aj = getelementptr inbounds i32, i32* %A, i64 %j
  store i32 2, i32* %Aj, align 4
  %inc.j = add nsw i64 %j, 1
  %cmp.j = icmp slt i64 %inc.j, 100
  br i1 %cmp.j, label %for.second, label %for.second.exit

for.second.exit:
  ret i64 %add
}