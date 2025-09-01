import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/utils/constants.dart';

import '../models/status.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/base_text_button.dart';

class ConfirmChangeStatus extends StatefulWidget {
  final Status newStatus;
  const ConfirmChangeStatus({super.key, required this.newStatus});

  @override
  State<ConfirmChangeStatus> createState() => _ConfirmChangeStatusState();
}

class _ConfirmChangeStatusState extends State<ConfirmChangeStatus> with SingleTickerProviderStateMixin{
  AnimationController? controller;
  Animation<double>? scaleAnimation;
  Status currentStatus = Get.arguments;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Platform.isIOS) controller!.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(color: Colors.black.withOpacity(0.1)),
        ),
        Center(
            child: Wrap(children: [
              Material(
                color: Colors.transparent,
                child: Platform.isAndroid
                    ? ScaleTransition(
                  scale: scaleAnimation!,
                  child: buildBody(context),
                )
                    : buildBody(context),
              )
            ])),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 180.h, maxWidth: 500.w,),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
          color: kPrimaryLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kGreen.withOpacity(0.1), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// title ---------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'confirm_status_change'.tr,
              style: Get.textTheme.headlineLarge?.copyWith(
                fontSize: 22.sp,
              ),
            ),
            InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.clear,
                  color: kGrey9C,
                ))
          ],
        ),
        SizedBox(
          height: 30.h,
        ),

        Text(
          'you_are_about_change_status'.tr,
          style: Get.textTheme.headlineMedium?.copyWith(
            fontSize: 16.sp,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),

        /// current status
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,vertical: verticalPadding.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kGrey38,
          ),
          child: Row(
            spacing: 12.w,
            children: [
              Icon(currentStatus.icon,color: currentStatus.color??kWhite,size:30.sp),
              Text(
                '${'current'.tr}: ${currentStatus.title}'.tr,
                style: Get.textTheme.headlineLarge?.copyWith(
                  fontSize: 18.sp,
                ),
              ),

            ],
          ),
        ),

        SizedBox(
          height: 16.h,
        ),

        Center(child: Icon(Icons.arrow_drop_down_circle,color:kGrey64,size:30.sp)),

        SizedBox(
          height: 16.h,
        ),
        /// new status
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,vertical: verticalPadding.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kGrey1c,
            border: Border.all(color: kAccent,width: 2.w)
          ),
          child: Row(
            spacing: 12.w,
            children: [
              Icon(widget.newStatus.icon,color: widget.newStatus.color??kWhite,size:30.sp),
              Text(
                '${'new'.tr}: ${widget.newStatus.title}'.tr,
                style: Get.textTheme.headlineLarge?.copyWith(
                  fontSize: 18.sp,
                ),
              ),

            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),


        /// btn
        Row(
          spacing: 12.w,
          children: [
            Expanded(child: BaseTextButton(title: 'cancel'.tr,onPress: ()=>Get.back(),),),
            Expanded(child: BaseTextButton(title: 'confirm'.tr,primary: kAccent00,onPress: ()=>Get.back(result: widget.newStatus),),),
          ],
        )
      ],
      ),
    );
  }

}
