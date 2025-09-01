import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/buttons/base_text_button.dart';

class UnitDangerCard extends StatelessWidget {
  final VoidCallback? onCancel;

  const UnitDangerCard({
    super.key,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color:  kRedDc,
        borderRadius: BorderRadius.circular(16.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: ( kRed).withOpacity(0.3),
        //     blurRadius: 15.r,
        //     offset: Offset(0, 8.h),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with icon and title
          Row(
            children: [
             Icon(Icons.warning_amber,
                      color: kGreyHint,
                      size: 24.r,
                    ),
              
              SizedBox(width: 12.w),
              
              // Title
              Expanded(
                child: Text(
                  'unit_in_danger'.tr,
                  style: Get.textTheme.headlineLarge?.copyWith(
                    color: kWhite,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Sent at time
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${'sent_at'.tr} 19:25:26',
              style: Get.textTheme.displayMedium?.copyWith(
                color: kWhite.withOpacity(0.9),
                fontSize: 14.sp,
              ),
            ),
          ),
          
          SizedBox(height: 20.h),
          
          // Cancel button
          BaseTextButton(
            title: 'cancel_sos'.tr,
            onPress: onCancel,
            primary: kRedB9,
            txtColor: kWhite,
            fontSize: 16.sp,
            height: 48.h,
            radius: 12.r,
            borderColor: kRedB9,
          ),
        ],
      ),
    );
  }
}
