import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../base/base_view.dart';
import '../../models/api/page_properties.dart';
import '../../theme/app_colors.dart';
import '../../widgets/avatar/rounded_avatar.dart';
import '../../widgets/buttons/base_text_button.dart';
import 'onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends BaseView<OnBoardingController> {
  OnBoardingScreen({super.key});

  @override
  PageProperties get pageProperties => PageProperties(showAppBar: true, );

  /// build ********************************************************************
  @override
  Widget buildBody(BuildContext context) {


    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h,),
              /// Image ***********************************************************************
              SizedBox(
                width: Get.width,
                height: Get.height / 2,
                child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) =>
                    controller.currentPosition.value = index,
                    children: controller.userGuides
                        .map(
                          (userGuide) => RoundedAvatar(width: 400.w,height: 400.h,),
                    )
                        .toList()),
              ),
              SizedBox(
                height: 60.h,
              ),
              Obx(() =>  Text(controller
                  .userGuides[
              controller.currentPosition.value]
                  .title??'',    style: Get.textTheme.headlineLarge
                  ?.copyWith(
                fontSize: 24.sp,),).paddingSymmetric(horizontal: 24.w)),
              Obx(() =>  Text(controller
                  .userGuides[
              controller.currentPosition.value]
                  .description??'',    style: Get.textTheme.displaySmall
                  ?.copyWith(
                fontSize: 24.sp,),)),

              SizedBox(
                height: 60.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: controller.userGuides.length,
                    effect: ScaleEffect(
                        activeDotColor: kPrimary,
                        dotColor: kGreyEE,
                        spacing: 6.w,
                        dotWidth: 33.w,
                        dotHeight: 5.h,
                        paintStyle: PaintingStyle.fill,
                        activePaintStyle: PaintingStyle.fill),
                  ),
                  /// Create Account ********************************************************
                  BaseTextButton(
                    title: 'sign_in'.tr,
                    onPress: controller.onSignInAccount,
                    primary: Colors.transparent,
                    borderColor: kPrimary,
                    txtColor: kPrimary,
                  ),
      
                  SizedBox(
                    height: 16.h,
                  ),
                  BaseTextButton(
                    title: 'sign_up'.tr,
                    onPress: controller.onSignUpAccount,
                  ),
                ],
              ),
      
            ],
          ),
        ),
      ),
    ).paddingSymmetric(horizontal: 24.w,vertical: 24.h);
  }

}
