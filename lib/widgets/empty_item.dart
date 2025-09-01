import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_colors.dart';
import '../theme/app_images.dart';
import 'buttons/loading_button.dart';

class EmptyItems extends StatelessWidget {
  final String? svgImage;
  final String? lottie;
  final String? title;
  final Color? titleColor;
  final String? subTitle;
  final String? btnTitle;
  final VoidCallback? btnPress;
  final double? height;
  final double? width;
  const EmptyItems({super.key, this.title, this.svgImage, this.lottie, this.subTitle, this.titleColor, this.btnTitle, this.btnPress, this.height, this.width = 100});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        svgImage != null
            ? SvgPicture.asset(
                svgImage!,
                height: height,
                width: width,
              )
            : lottie != null
                ? Lottie.asset(
                    lottie!,
                    height: height,
                    width: width,
                  )
                : Opacity(
                    opacity: 0.4,
                    child: Image.asset(
                      AppImages.empty,
                      height: height,
                      width: width,
                    ),
                  ),
        SizedBox(height: 16.h),
        Text(
          title ?? 'no_data'.tr,
          style: Get.textTheme.displayMedium?.copyWith(
            fontSize: 16.sp,
            color: titleColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        subTitle == null
            ? const SizedBox()
            : Text(
                subTitle ?? 'no_data'.tr,
                style: Get.textTheme.titleMedium?.copyWith(fontSize: 14.sp, color: kGrey75),
                textAlign: TextAlign.center,
              ),
        SizedBox(height: btnTitle == null ? 0 : 16),
        btnTitle == null
            ? const SizedBox()
            : RoundedLoadingButton(
                title: btnTitle,
                onPressed: btnPress,
                height: 55.h,
                fontSize: 20.sp,
                // progressColor: kWhite,
                // textColor: kWhite,
                color: kPrimary,
              )
      ],
    ).marginOnly(top: 10.h);
  }
}
