import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/models/status.dart';
import 'package:responder_app/theme/app_images.dart';
import 'package:responder_app/utils/constants.dart';
import 'package:responder_app/widgets/availablity_status.dart';

import '../theme/app_colors.dart';

class UnitInfoSheet extends StatefulWidget {
  final Status status;
  const UnitInfoSheet(
      {super.key, required this.status,});

  @override
  State<UnitInfoSheet> createState() => _UnitInfoSheetState();
}

class _UnitInfoSheetState extends State<UnitInfoSheet> with SingleTickerProviderStateMixin{
  AnimationController? controller;
  Animation<double>? scaleAnimation;

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
    return Center(
      child: Wrap(
        children: [
          Material(
            color: Colors.transparent,
            child: Platform.isAndroid ? ScaleTransition(scale: scaleAnimation!,child: _body(),) :
            _body(),
          )
          ,
        ],
      ),
    );
  }

  Widget _body(){
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: horizontalPadding.w, vertical: verticalPadding.h),
      decoration:  BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Close and icon ***********************************************************
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 80.w,),
                /// unit info
                Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            border: Border.all(color: kAccent,width: 3.w),
                            color: kGrey38
                        ),
                        child: Image.asset(AppImages.police1,height: 40.h,)),
                    SizedBox(height: 16.h),

                    /// type ***********************************************************
                    Text('police unit',style: Get.textTheme.displayMedium?.copyWith(
                        fontSize: 15.sp
                    ),),
                    SizedBox(height: 4.h,),
                    Text('Riyadh 1',style: Get.textTheme.headlineLarge?.copyWith(
                        fontSize: 22.sp
                    ),),
                  ],
                ),
                /// close and status
                Row(
                  spacing: 8.w,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AvailabilityStatus(status: widget.status,),
                    InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.close_sharp,
                            color: kGrey9C, size: 20)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            /// Location ***********************************************************
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,vertical: verticalPadding.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(customBorderRadius.r),
                color: kPrimaryLight,
              ),
              child: Row(
                spacing: 12.w,
                children: [
                  Icon(Icons.navigation_outlined,color: kBlueSky,size: 30.r,),
                  Column(
                    spacing: 8.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('current_location'.tr,style: Get.textTheme.displayLarge?.copyWith(
                        fontSize: 18.sp,
                      ),),
                      Text('Al Olaya Distict, Northern Patrol Route'.tr,style: Get.textTheme.displayMedium?.copyWith(
                        fontSize: 15.sp,
                      ),),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            /// btn actions ***********************************************************
            Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,vertical: verticalPadding.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(customBorderRadius.r),
                      color: kPrimaryLight,
                    ),
                    child: Column(
                      spacing: 8.h,
                      children: [
                        Icon(Icons.person_2_outlined,color: kBlueSky,size: 30.r,),
                        Text('unit_details'.tr,style: Get.textTheme.displayLarge?.copyWith(
                          fontSize: 16.sp,
                        ),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,vertical: verticalPadding.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(customBorderRadius.r),
                      color: kPrimaryLight,
                    ),
                    child: Column(
                      spacing: 8.h,
                      children: [
                        Icon(Icons.access_time_rounded,color: kBlueSky,size: 30.r,),
                        Text('shift_log'.tr,style: Get.textTheme.displayLarge?.copyWith(
                          fontSize: 16.sp,
                        ),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w,vertical: verticalPadding.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(customBorderRadius.r),
                      color: kPrimaryLight,
                    ),
                    child: Column(
                      spacing: 8.h,
                      children: [
                        Icon(Icons.location_on_outlined,color: kBlueSky,size: 30.r,),
                        Text('filed_event'.tr,style: Get.textTheme.displayLarge?.copyWith(
                          fontSize: 16.sp,
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}