import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/models/args/args_coming_soon.dart';
import 'package:responder_app/theme/app_colors.dart';

class ComingSoon extends BaseView{
  ComingSoon({super.key});

  @override
  PageProperties get pageProperties => PageProperties();

  ArgsComingSoon argsComingSoon = Get.arguments;

  @override
  Widget buildAppBarTitle() {
    return Text(argsComingSoon.screenTitle.tr,style: Get.textTheme.headlineLarge?.copyWith(
      fontSize: 18.sp,
    ),);
  }

  @override
  Widget? buildBody(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kAccent12,
            ),
            child: Icon(Icons.search,color: kBlueSky,size: 50.r,),
          ),
          SizedBox(height: 30.h,),

          Text('coming_soon'.tr,style: Get.textTheme.headlineLarge?.copyWith(
            fontSize: 24.sp,
          ),),
          SizedBox(height: 20.h,),

          Text('Search incidents, reports, and records will be available here.',
            style: Get.textTheme.headlineMedium?.copyWith(
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 16.h,),
          Text('Comprehensive filtering and search capabilities for record lookup.',
            style: Get.textTheme.displayMedium?.copyWith(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 12.h,),
          Text('Formerly known as Advanced Search',
            style: Get.textTheme.displayMedium?.copyWith(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

}