import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/language_controller.dart';
import 'package:responder_app/theme/app_spacing.dart';
import '../local/localization_service.dart';
import '../theme/app_colors.dart';

class ChangeLanguageWidget extends StatelessWidget {
  final LanguageController controller;
  const ChangeLanguageWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          height: 45.h,
          padding: AppSpacing.paddingHorizontalSm,
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusSm,
            border: Border.all(color: kGrey37),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08), // soft shadow
                blurRadius: 6, // how soft the shadow is
                offset: const Offset(0, 3), // position of shadow
              ),
            ],
            color: kPrimaryLight,
          ),
          child: Row(
            spacing: 8,
            children: [
              Icon(
                Icons.language_outlined,
                color: kGrey9C,
                size: 20.r,
              ),
              InkWell(
                onTap: () => controller.onLang(LocalizationService.isRtl() ? 'en' : 'ar'),
                child: Text(
                  controller.otherLanguageName,
                  style: Get.textTheme.labelLarge?.copyWith(
                    fontSize: 14.sp,
                    color: kGreyD1,
                  ),
                ).paddingOnly(top: 5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
