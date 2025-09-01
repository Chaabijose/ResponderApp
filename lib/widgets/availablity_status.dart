import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/models/status.dart';

import '../theme/app_colors.dart';
import '../utils/constants.dart';

class AvailabilityStatus extends StatelessWidget {
  final Status status;
  const AvailabilityStatus({super.key,required  this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 8.w),
      decoration: BoxDecoration(
        color: status.color??kAccent,
        borderRadius: BorderRadius.circular(customBorderRadius.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4.w,
        children: [
          Icon(status.icon??Icons.check_box_rounded,color: kWhite,),
          Expanded(
            child: Text(status.title ?? 'Available',style: Get.textTheme.headlineLarge?.copyWith(
              fontSize: 14.sp,
            ),maxLines: 1,overflow: TextOverflow.ellipsis,).marginOnly(top: 4.h),
          ),

        ],
      ),
    );
  }
}
