import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responder_app/theme/app_spacing.dart';
import 'package:responder_app/utils/validation.dart';
import 'package:responder_app/widgets/base_text_field.dart';
import 'package:responder_app/widgets/buttons/base_text_button.dart';

import '../../main.dart';
import '../../screens/auth/server_config/server_config_controller.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_images.dart';
import '../../theme/app_themes.dart';
import '../../utils/device_utils.dart';
import 'config_server_dialog_controller.dart';

class ConfigServerDialog extends StatefulWidget {
  const ConfigServerDialog({super.key,});

  @override
  State<ConfigServerDialog> createState() => _ConfigServerDialogState();
}

class _ConfigServerDialogState extends State<ConfigServerDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? url = pref.serverUrl;

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
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(color: Colors.black.withValues(alpha: 0.1)),
        ),
        Center(
            child: Wrap(children: [
          Material(
            color: Colors.transparent,
            child: Platform.isAndroid
                ? ScaleTransition(
                    scale: scaleAnimation!,
                    child: buildBody(context),
                  )
                : buildBody(context),
          )
        ])),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 180.h,),
      width: DeviceUtils.isLandscapeOrTablet
          ? 480 // fixed like tablet
          : Get.width,
      margin: AppSpacing.paddingHorizontalMd,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24),
      decoration: BoxDecoration(
          color: kPrimary1F,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kGrey37, width: 1)),
      child: GetBuilder<ConfigServerDialogController>(
          init: ConfigServerDialogController(),
          builder: (controller)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// title ***********************
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'admin_settings'.tr,
                    style: Get.textTheme.headlineLarge?.copyWith(
                        fontSize: 20.sp,
                        color: kWhite
                    ),
                  ),
                  InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.clear,
                        color: kGrey9C,
                        size: 22.r,
                      ))
                ],
              ),
              SizedBox(
                height: 32.h,
              ),

              /// Server *******************************************************
              Text.rich(TextSpan(
                  text:   'server_url'.tr,
                  style: Get.textTheme.headlineMedium?.copyWith(fontSize: 15.sp, color: kWhite, fontFamily: kRegular),
                  children: [
                    TextSpan(
                      text: '  *',
                      style: Get.textTheme.headlineMedium?.copyWith(fontSize: 16.sp, color: kRed, fontFamily: kRegular),
                    ),
                  ])),
              SizedBox(
                height: 8.h,
              ),
              Obx(()=>Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Form(
                      key: controller.formKey,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: BaseTextField(
                          readOnly: !controller.editable.value,
                          suffixIcon: controller.urlStatus.value == URLStatus.loading?  SizedBox(width: 8, height: 8,child: Transform.scale(scale: 0.4, child: CircularProgressIndicator(color: kGrey97,))):
                          controller.urlStatus.value == URLStatus.invalid? Icon( Icons.error_outline,color: kRedLight, size: 20,):
                          controller.urlStatus.value == URLStatus.valid? Transform.translate(
                            offset: Offset(15, 0),child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppImages.checked, width: 17, colorFilter: ColorFilter.mode(kGreen, BlendMode.srcIn),),
                            ],
                          ),
                          ): null,
                          hintTxt: 'enter_server_url'.tr,
                          verticalPadding: 18,
                          controller: controller.txtController,
                          validator: (input) => ValidationUtil.validateUrl(input),
                          fontSize: 14,
                          radius: AppSpacing.radiusMd,
                          onSave: controller.onURLChanged,
                          onChange: controller.onURLChanged,
                          focuseBorderColor: kBlueSky,
                          unFocuseBorderColor: controller.urlStatus.value == URLStatus.invalid? kRedLight: controller.urlStatus.value == URLStatus.valid? kGreen: kGrey4B,
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: controller.onCanEdit,
                    child: Container(
                      height: 58,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(color: kGrey37,width: 2),
                      ),
                      child: Row(
                        spacing: 8,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if(!controller.editable.value)
                          SvgPicture.asset(AppImages.pen, width: 18, colorFilter: ColorFilter.mode(kBlueSky2, BlendMode.srcIn),),
                          if(controller.editable.value)
                            Icon(Icons.clear, color: kBlueSky2, size: 18,),
                          if(!controller.editable.value)
                          Text('edit'.tr,style: Get.textTheme.headlineMedium?.copyWith(
                            color: kBlueSky2, fontSize: 15,
                            fontFamily: kRegular
                          ),).paddingOnly(top: 5)
                        ],
                      ),
                    ),
                  ),
                ],
              )),

              if(controller.error != null)  Container(
                padding: AppSpacing.paddingHorizontalMd,
                height: 46.h,
                margin: EdgeInsets.only(bottom: 8.h,top: 12.h),
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
              SizedBox(
                height: 20,
              ),

              /// Buttons *******************************************************
              Row(
                spacing: 12,
                children: [
                  Expanded(
                      child: BaseTextButton(
                        title: 'cancel'.tr,
                        height: 60,
                        radius: 8,
                        fontSize: 14,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: controller.loading.value?0: 4,
                          children: [

                                Text('cancel'.tr, style: Get.textTheme.headlineMedium?.copyWith(
                                  fontSize: 18,
                                  color: kWhite,
                                ),).paddingOnly(top: 5),

                          ],
                        ),
                        onPress: () => Get.back(),
                      )),
                  Expanded(
                      child: Obx(()=>BaseTextButton(
                        title: ''.tr,
                        primary: !controller.loading.value && controller.urlStatus.value == URLStatus.valid ? kGreenBtn : kGreyD1,
                        onPress:controller.onSave,
                        height: 60,
                        radius: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: controller.loading.value?0: 4,
                          children: [
                            if(controller.loading.value)
                              ...[
                                SizedBox( width: 28,height: 28,child: Transform.scale(scale: 0.5, child: CircularProgressIndicator(color: kWhite,))),
                                Expanded(

                                  child: Text('verifying_connection'.tr, style: Get.textTheme.headlineMedium?.copyWith(
                                    fontSize: 18,
                                    color: kWhite,
                                  ),maxLines: 1,overflow: TextOverflow.ellipsis,).paddingOnly(top: 5),
                                ),
                              ],
                            if(!controller.loading.value)
                              ...[
                                SvgPicture.asset(AppImages.plugin, colorFilter: ColorFilter.mode(kWhite, BlendMode.srcIn),width: 21.h,),
                                Text('connect'.tr, style: Get.textTheme.headlineMedium?.copyWith(
                                  fontSize: 18,
                                  color: kWhite,
                                ),),
                              ]

                          ],
                        ),
                      ))),
                ],
              )
            ],
          )),
    );
  }


}
