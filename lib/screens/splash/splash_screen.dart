import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:network_logger/network_logger.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/theme/app_colors.dart';
import 'package:responder_app/theme/app_images.dart';
import 'package:responder_app/widgets/avatar/rounded_avatar.dart';
import '../../base/base_view.dart';
import '../../environment/flavor_config.dart';
import '../../models/api/page_properties.dart';
import 'splash_controller.dart';

class SplashScreen extends BaseView<SplashController> {
  SplashScreen({super.key});

  @override
  PageProperties get pageProperties => PageProperties(
        showAppBar: false,
        extendBody: true,
      );

  @override
  Widget buildBody(BuildContext context) {
    if (FlavorConfig.isDev()) {
      NetworkLoggerOverlay.attachTo(context);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: SafeArea(
        child: Center(
          child: Obx(
            () => AnimatedOpacity(
              opacity: controller.logoOpacity.value,
              duration: const Duration(seconds: 2),
              curve: Curves.linear,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16.h,
                children: [
                  RoundedAvatar(
                    borderRadius: 8.r,
                    avatarUrl: controller.serverConfig?.logoUrl,
                    placeHolder: AppImages.comingSoon,
                    width: 200.w,
                    height: 400.h,
                  ),
                  Text(controller.serverConfig?.name??'',style: Get.textTheme.headlineLarge?.copyWith(
                    fontSize: 30.sp,
                    color: kWhite
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
