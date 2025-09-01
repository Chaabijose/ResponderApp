import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/screens/auth/auth_controller.dart';
import 'package:responder_app/theme/app_colors.dart';
import 'package:responder_app/utils/validation.dart';
import 'package:responder_app/widgets/base_text_field.dart';
import 'package:responder_app/widgets/buttons/base_text_button.dart';
import '../../local/localization_service.dart';
import '../../theme/app_images.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_themes.dart';
import '../../utils/device_utils.dart';
import '../../widgets/change_language_widget.dart';

class AuthScreen extends BaseView<AuthController> {
  AuthScreen({super.key});

  @override
  PageProperties get pageProperties => PageProperties(showAppBar: false,showAppBarLine: false);


  @override
  Widget? buildBody(BuildContext context) {
    return GetBuilder<AuthController>(
      init: controller,
      tag: tag,
      builder: (_)=> Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: Get.theme.primaryColor
        ),
        child: Column(
          children: [
            /// Lost Connection ***********************************************
            Obx(()=> controller.isServerURLValid.value? SizedBox.shrink():
            Container(
              width: Get.width,
              color: kRedDc,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SafeArea(child: Row(spacing: 10,
                children: [
                  Icon(Icons.wifi_off_rounded, color: kWhite,),
                  Text('lost_connection'.tr, style: Get.textTheme.displayMedium?.copyWith(
                      fontSize: 15.sp,
                      fontFamily: kRegular,
                      color: kWhite
                  ),).paddingOnly(top: 5),
                ],)),
            )),
            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: AppSpacing.paddingHorizontalMd,
                  child: Column(
                    children: [

                      /// Language & City ********************************************
                      SizedBox(height: 16.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: controller.onSettings,
                            child: Container(
                                width: 42.r,
                                height: 42.r,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: kGrey37),
                                  color: kPrimary1F,
                                ),
                                child: Obx(()=> Icon(
                                  Icons.settings_outlined,
                                  color: controller.isServerURLValid.value ? kGrey9C : kRedLight,
                                  size: 23.r,
                                ))),
                          ),
                          ChangeLanguageWidget(controller: controller),
                        ],
                      ),

                      SizedBox(height: 16.h,),

                      /// Body *******************************************************
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 16.h),
                          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24),
                          width: DeviceUtils.isLandscapeOrTablet
                              ? 480 // fixed like tablet
                              : Get.width,
                          decoration: BoxDecoration(
                            borderRadius: AppSpacing.borderRadiusLg,
                            border: Border.all(
                              color: kGrey37,
                            ),
                            color: kPrimary1F,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08), // soft shadow
                                blurRadius: 6, // how soft the shadow is
                                offset: const Offset(0, 3), // position of shadow
                              ),
                            ],
                          ),

                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// Logo & Stepper ***********************************
                                Stack(
                                  children: [
                                    // Centered logo
                                    Center(
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 85.h,
                                          minWidth: 50.w,
                                          maxWidth: 120.w,
                                          minHeight: 60.h
                                        ),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(pref.serverConfig!.logoUrl!,),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Sign in indicator positioned at top right
                                    Positioned.directional(
                                      textDirection: LocalizationService.isRtl() ? TextDirection.rtl : TextDirection.ltr,
                                      top: 0,
                                      end: 0,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'sign_in'.tr,
                                            style: Get.textTheme.displayMedium?.copyWith(
                                              fontSize: 15.sp,
                                              fontFamily: kRegular,
                                              color: kGrey9C
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(Icons.circle, color: kBlueSky, size: 8.r),
                                          SizedBox(width: 4),
                                          Icon(Icons.circle, color: kGrey4B, size: 8.r),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),

                                /// Titles *******************************************
                                Center(
                                  child: Text(
                                    pref.serverConfig?.name??'',
                                    textAlign: TextAlign.center,
                                    style:
                                    Get.textTheme.headlineLarge?.copyWith(fontSize: 18.sp, color: kWhite, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Center(
                                  child: Text(
                                    pref.serverConfig?.type??'',
                                    style: Get.textTheme.titleLarge?.copyWith(
                                        fontSize: 15.sp,
                                        fontFamily: kRegular,
                                        color: kGrey9C
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),


                                /// User Name ****************************************
                                Text(
                                  'user_name'.tr,
                                  style: Get.textTheme.displayMedium
                                      ?.copyWith(fontSize: 14.sp, color: kGreyD1),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                BaseTextField(
                                  hintTxt: 'enter_your_user_name'.tr,
                                  validator: (input) => ValidationUtil.validateString(input,
                                      minLength: 5, errorText: 'enter_valid_user_name'.tr),
                                  onSave: controller.onSaveUserName,
                                  onChange: controller.onSaveUserName,
                                  focuseBorderColor: kBlueSky,
                                  unFocuseBorderColor: kGrey4B,
                                  errorIcon: Icons.error_outline,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),

                                /// Password *****************************************
                                Text(
                                  'password'.tr,
                                  style: Get.textTheme.displayMedium
                                      ?.copyWith(fontSize: 14.sp, color: kWhite),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                BaseTextField(
                                  hintTxt: 'enter_your_password'.tr,
                                  validator: (input) => ValidationUtil.validateString(input,
                                      minLength: 4, errorText: 'enter_valid_password'.tr),
                                  onSave: controller.onSavePassword,
                                  onChange: controller.onSavePassword,
                                  focuseBorderColor: kBlueSky,
                                  unFocuseBorderColor: kGrey4B,
                                  password: true,
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),

                                /// Remember me ***************************************
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    InkWell(
                                        onTap: controller.onRemember,
                                        child: Obx(() => controller.isChecked.value
                                            ? Image.asset(AppImages.checkedPng, width: 18.r,)
                                            : Icon(Icons.square, color: kWhite, size: 22.r,))),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        spacing: 4.h,
                                        children: [
                                          Text(
                                            'remember_me'.tr,
                                            style: Get.textTheme.displayMedium
                                                ?.copyWith(fontSize: 15.sp, color: kWhite),
                                          ),
                                          Text(
                                            'save_user_name_for_next'.tr,
                                            style: Get.textTheme.displayMedium?.copyWith(
                                              fontSize: 13.sp,
                                              fontFamily: kRegular,
                                              color: kGrey9C
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                /// Next Button **********************************
                                Obx(()=> BaseTextButton(
                                  onPress: controller.onNext,
                                  height: 60,
                                  width: Get.width,
                                  fontSize: 17,
                                  title: 'next'.tr,
                                  primary: controller.isValidData.value && !controller.loading.value? kGreenBtn : kGreyD1,
                                  child: !controller.loading.value? null:Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: controller.loading.value?0: 4,
                                    children: [
                                          SizedBox( width: 28.r,height: 28.r,child: Transform.scale(scale: 0.5, child: CircularProgressIndicator(color: kWhite,))),
                                          Text('verifying_connection'.tr, style: Get.textTheme.headlineMedium?.copyWith(
                                            fontSize: 17,
                                            color: kWhite,
                                          ),).paddingOnly(top: 5),
                                    ],
                                  ) ,
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
