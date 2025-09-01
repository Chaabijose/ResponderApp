import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/screens/auth/server_config/server_config_controller.dart';
import 'package:responder_app/theme/app_spacing.dart';
import 'package:responder_app/theme/app_themes.dart';
import 'package:responder_app/utils/device_utils.dart';
import 'package:responder_app/widgets/change_language_widget.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_images.dart';
import '../../../utils/validation.dart';
import '../../../widgets/base_text_field.dart';
import '../../../widgets/buttons/base_text_button.dart';

class ServerConfigScreen extends BaseView<ServerConfigController>{
  ServerConfigScreen({super.key});

  @override
  PageProperties get pageProperties => PageProperties(showAppBarLine: false,showAppBar: false);


  @override
  Widget? buildBody(BuildContext context) {
    return GetBuilder<ServerConfigController>(
      init: controller,
      tag: tag,
      builder: (_)=> Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingHorizontalMd,
          child: Column(
            children: [
              SizedBox(height: 30.h,),
              ChangeLanguageWidget(controller: controller),
              SizedBox(height: 32.h,),
              Center(child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// WIFI Icons ******************************************************
                    Container(width: 58.r, height: 58.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGreenOpacity,
                    ), child: SvgPicture.asset(AppImages.wifi, width: 25.r, colorFilter: ColorFilter.mode(kBlueSky, BlendMode.srcIn),)),
                    SizedBox(height: 16.h,),

                    /// Titles ***********************************************************
                    Text(
                      'configure_server_connection'.tr,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headlineLarge?.copyWith(
                        fontSize: 20.sp,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: kWhite
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      'configure_server_connection_sub_title'.tr,
                      style: Get.textTheme.titleLarge?.copyWith(
                        fontSize: 15.sp,
                        fontFamily: kRegular,
                        color: kGrey9C
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h,),

                    /// Server URL TextField *************************************************
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text.rich(TextSpan(
                        text:   'server_url'.tr,
                        style: Get.textTheme.headlineMedium?.copyWith(fontSize: 15.sp, color: kWhite, fontFamily: kRegular),
                      children: [
                        TextSpan(
                          text: '  *',
                          style: Get.textTheme.headlineMedium?.copyWith(fontSize: 16.sp, color: kRed, fontFamily: kRegular),
                        ),
                      ])),
                    ),
                    SizedBox(height: 8.h,),
                    Form(
                      key: controller.formKey,
                      child: Obx(()=>Directionality(
                        textDirection: TextDirection.ltr,
                        child: BaseTextField(
                          suffixIcon: controller.urlStatus.value == URLStatus.loading?  SizedBox(width: 8.r, height: 8.r,child: Transform.scale(scale: 0.4, child: CircularProgressIndicator(color: kGrey97,))):
                          controller.urlStatus.value == URLStatus.invalid? Icon( Icons.error_outline,color: kRedLight, size: 20.r,):
                          controller.urlStatus.value == URLStatus.valid? Transform.translate(
                            offset: Offset(10, 0),child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppImages.checked, width: 17.r, colorFilter: ColorFilter.mode(kGreen, BlendMode.srcIn),),
                              ],
                            ),
                          ): null,
                          hintTxt: 'enter_server_url'.tr,
                          verticalPadding: 18,
                          initialValue: 'https://',
                          validator: (input) => ValidationUtil.validateUrl(input),
                          fontSize: 14.sp,
                          radius: AppSpacing.radiusMd,
                          onSave: controller.onURLChanged,
                          onChange: controller.onURLChanged,
                          focuseBorderColor: kBlueSky,
                          unFocuseBorderColor: controller.urlStatus.value == URLStatus.invalid? kRedLight: controller.urlStatus.value == URLStatus.valid? kGreen: kGrey4B,
                        ),
                      )),
                    ),

                    /// Error  Widget ************************************
                    SizedBox(height:  10.h,),
                    if(controller.error != null)  Container(
                      padding: AppSpacing.paddingHorizontalMd,
                      height: 46.h,
                      margin: EdgeInsets.only(bottom: 8.h),
                      decoration: BoxDecoration(
                        borderRadius: AppSpacing.borderRadiusMd,
                        color: redOpacity,
                        border: Border.all(color: redBorder),
                      ),
                      child: Row(
                        spacing: 8.w,
                        children: [
                          Icon(Icons.error_outline,color: kRedLight, size: 20.r,),
                          Expanded(
                            child: Text(controller.error ?? '', textAlign: TextAlign.start,
                              style: Get.textTheme.displayMedium?.copyWith(
                              fontSize: 15.sp,
                              fontFamily: kRegular,
                              color: kRedLight,
                            ),).paddingOnly(top: 5.h),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    /// Save Button ***************************************************
                    Obx(()=>BaseTextButton(
                      title: ''.tr,
                      primary: !controller.loading.value && controller.urlStatus.value == URLStatus.valid ? kGreenBtn : kGreyD1,
                      onPress:controller.onSave,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: controller.loading.value?0: 4,
                        children: [
                          if(controller.loading.value)
                            ...[
                              SizedBox( width: 28.r,height: 28.r,child: Transform.scale(scale: 0.5, child: CircularProgressIndicator(color: kWhite,))),
                              Text('verifying_connection'.tr, style: Get.textTheme.headlineMedium?.copyWith(
                                fontSize: 17,
                                color: kWhite,
                              ),).paddingOnly(top: 5),
                            ],
                          if(!controller.loading.value)
                            ...[
                              SvgPicture.asset(AppImages.plugin, colorFilter: ColorFilter.mode(kWhite, BlendMode.srcIn),width: 22.h,),
                              Text('connect'.tr, style: Get.textTheme.headlineMedium?.copyWith(
                                fontSize: 17,
                                color: kWhite,
                              ),).paddingOnly(top: 5),
                            ]

                        ],
                      ),
                    )),
                  ],
                ),
              ),),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
    ),);
  }


}