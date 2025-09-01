import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/models/local_enums.dart';
import 'package:responder_app/screens/settings/settings_controller.dart';

import '../../local/localization_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_images.dart';
import '../../utils/constants.dart';
import '../../widgets/switch_widget.dart';

class SettingsScreen extends BaseView<SettingsController> {
  SettingsScreen({super.key});

  @override
  PageProperties get pageProperties => PageProperties(title: 'settings'.tr);

  @override
  Widget? buildBody(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) => SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(customBorderRadius.r),
              color: kPrimary),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Left Panel
              Container(
                width: 320.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                color: kPrimaryLight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: controller.clearSelectedSettings,
                      child: Row(
                        spacing: 8.w,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: kAccent00),
                            child: Icon(
                              Icons.settings,
                              color: kWhite,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'settings'.tr,
                                style: Get.textTheme.headlineLarge?.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                'configure_your_preferences'.tr,
                                style: Get.textTheme.displayMedium?.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 70.h,
                    ),

                    /// list
                    Column(
                      spacing: 20.h,
                      children: SettingsEnum.values
                          .map((item) => InkWell(
                                onTap: () => controller.onSelectSetting(item),
                                child: Container(
                                  // padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: controller.selectedSetting != null &&
                                            controller.selectedSetting! == item
                                        ? kGrey1c
                                        : Colors.transparent,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: _settingItem(
                                                icon: item.icon,
                                                title: item.title,
                                                body: item.body)
                                            .paddingSymmetric(
                                                horizontal: 8.w, vertical: 8.h),
                                      ),
                                      if (controller.selectedSetting != null &&
                                          controller.selectedSetting == item)
                                        Container(
                                          height: 60.h,
                                          width: 2.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            color: kAccent,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),

              /// Title & Body
              Expanded(
                child: Column(
                  children: [
                    /// Title
                    Container(
                      height: 100.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      color: kPrimaryLight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8.w,
                        children: [
                          Icon(
                            controller.selectedSetting == null
                                ? Icons.settings
                                : controller.selectedSetting!.icon,
                            color: kBlueSky,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.selectedSetting == null
                                    ? 'settings'.tr
                                    : controller.selectedSetting!.title.tr,
                                style: Get.textTheme.headlineLarge?.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                controller.selectedSetting == null
                                    ? 'configure_your_preferences'.tr
                                    : controller.selectedSetting!.body.tr,
                                style: Get.textTheme.displayMedium?.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    /// Body -------------
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding.w,
                              vertical: verticalPadding.h),
                          color: kPrimary,
                          child: controller.selectedSetting == null
                              ? _empty()
                              : controller.selectedSetting ==
                                      SettingsEnum.general
                                  ? _general()
                                  : controller.selectedSetting ==
                                          SettingsEnum.mapNavigation
                                      ? _mapAndNavigation()
                                      : _emergency(),
                        ),
                      ),
                    ),

                    /// Divider
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: kGrey9C,
                      thickness: 0.3.h,
                    ).paddingSymmetric(horizontal: horizontalPadding.w),
                    Row(
                      spacing: 12.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          color: kAccent,
                        ),
                        Text(
                          'all_preference_are_saved'.tr,
                          style: Get.textTheme.headlineMedium
                              ?.copyWith(fontSize: 16.sp),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingItem({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Row(
      spacing: 8.w,
      children: [
        Container(
            padding: EdgeInsets.all(5.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r), color: kGrey38),
            child: Icon(
              icon,
              color: kBlueSky,
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                title.tr,
                style: Get.textTheme.headlineMedium?.copyWith(fontSize: 18.sp),
              ),
              Text(
                body.tr,
                style: Get.textTheme.labelMedium?.copyWith(fontSize: 16.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: kGrey9C,
        ),
      ],
    );
  }

  Widget _empty() {
    return Column(
      spacing: 20.h,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Icon(
          Icons.settings_outlined,
          color: kGrey9C,
          size: 50.sp,
        ),
        Text(
          'select_setting_section'.tr,
          style: Get.textTheme.headlineLarge?.copyWith(
            fontSize: 18.sp,
          ),
        ),
        Text(
          'choose_section_from_side_bar'.tr,
          style: Get.textTheme.headlineMedium?.copyWith(
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }

  Widget _general() {
    return Column(
      spacing: 25.h,
      children: [
        /// Language
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.w, vertical: verticalPadding.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
            border: Border.all(color: kGrey9C, width: 0.3.h),
          ),
          child: Column(
            spacing: 16.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: kGrey38),
                    child: Icon(
                      Icons.translate,
                      color: kBlueSky,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      Text(
                        'app_language'.tr,
                        style: Get.textTheme.headlineLarge
                            ?.copyWith(fontSize: 18.sp),
                      ),
                      Text(
                        'choose_your_default_app_language'.tr,
                        style: Get.textTheme.displayMedium
                            ?.copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: kGrey38,
                ),
                child: Row(
                  children: LanguageEnum.values
                      .map((item) => Expanded(
                            child: GestureDetector(
                              onTap: () => controller.onChangeLanuage(item),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: controller.selectedLanguage == item
                                      ? kAccent00
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    item.title.tr,
                                    style: Get.textTheme.headlineLarge
                                        ?.copyWith(
                                            fontSize: 18.sp,
                                            color:
                                                controller.selectedLanguage ==
                                                        item
                                                    ? kWhite
                                                    : kGrey9C),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),

        /// Theme
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.w, vertical: verticalPadding.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
            border: Border.all(color: kGrey9C, width: 0.3.h),
          ),
          child: Column(
            spacing: 16.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: kGrey38),
                    child: Icon(
                      Icons.desktop_windows_outlined,
                      color: kBlueSky,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      Text(
                        'app_theme'.tr,
                        style: Get.textTheme.headlineLarge
                            ?.copyWith(fontSize: 18.sp),
                      ),
                      Text(
                        'choose_between_light_dark'.tr,
                        style: Get.textTheme.displayMedium
                            ?.copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: kGrey38,
                ),
                child: Row(
                  children: ThemeEnum.values
                      .map((item) => Expanded(
                            child: GestureDetector(
                              onTap: () => controller.onChangeTheme(item),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: controller.selectedTheme == item
                                      ? kGrey4c
                                      : Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    '${item.title.tr} ${'theme'.tr}',
                                    style: Get.textTheme.headlineLarge
                                        ?.copyWith(
                                            fontSize: 18.sp,
                                            color:
                                                controller.selectedTheme == item
                                                    ? kWhite
                                                    : kGrey9C),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _mapAndNavigation() {
    return Column(
      spacing: 24.h,
      children: [
        /// Map preference
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.w, vertical: verticalPadding.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
            border: Border.all(color: kGrey9C, width: 0.3.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: kGrey38),
                    child: Icon(
                      Icons.map_outlined,
                      color: kBlueSky,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      Text(
                        'map_preference'.tr,
                        style: Get.textTheme.headlineLarge
                            ?.copyWith(fontSize: 18.sp),
                      ),
                      Text(
                        'configure_default_map_behavior'.tr,
                        style: Get.textTheme.displayMedium
                            ?.copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                'default_map_view'.tr,
                style: Get.textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
              ),
              Text(
                'choose_what_you_see_when_you_first_open_map'.tr,
                style: Get.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: kGrey38,
                ),
                child: Row(
                  children: MapStyleView.values
                      .map((item) => Expanded(
                            child: GestureDetector(
                              onTap: () => controller.onChangeMapView(item),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: controller.selectedView == item
                                      ? kAccent00
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  spacing: 8.w,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppImages.police1,
                                      width: 40.w,
                                    ),
                                    if (item == MapStyleView.nearby)
                                      Image.asset(
                                        AppImages.fire,
                                        width: 30.w,
                                      ),
                                    Text(
                                      item.title.tr,
                                      style:
                                          Get.textTheme.headlineLarge?.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),

        /// Map Layers
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding.w, vertical: verticalPadding.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
            border: Border.all(color: kGrey9C, width: 0.3.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: kGrey38),
                    child: Icon(
                      Icons.language_outlined,
                      color: kBlueSky,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8.h,
                    children: [
                      Text(
                        'map_layers'.tr,
                        style: Get.textTheme.headlineLarge
                            ?.copyWith(fontSize: 18.sp),
                      ),
                      Text(
                        'configure_default_map_layer'.tr,
                        style: Get.textTheme.displayMedium
                            ?.copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),

              Text(
                'default_base_view'.tr,
                style: Get.textTheme.headlineMedium?.copyWith(fontSize: 16.sp),
              ),
              Text(
                'choose_which_map_types_loads'.tr,
                style: Get.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
              ),

              /// styles
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding.w,
                ),
                child: Row(
                  spacing: 12.w,
                  children: controller.styles
                      .map((item) => GestureDetector(
                            onTap: () => controller.onChangeStyle(item),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: item == controller.selectedStyle
                                        ? kAccent
                                        : kGrey9C,
                                    width: 2.w),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.asset(
                                      item.image ?? AppImages.comingSoon,
                                      fit: BoxFit.fill,
                                      width: Get.width / 9.3,
                                      height: 100.h,
                                    ),
                                  ),
                                  if (item == controller.selectedStyle)
                                    Positioned.directional(
                                      top: 8.h,
                                      end: 10.w,
                                      textDirection: LocalizationService.isRtl()
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      child: Container(
                                        padding: EdgeInsets.all(2.r),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kAccent00,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: kWhite,
                                          size: 15.sp,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),

              /// layers
              SizedBox(),
              Column(
                spacing: 16.h,
                children: controller.layers
                    .map((item) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 8.w,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: kGrey38,
                                  ),
                                  child: Icon(
                                    item.icon!,
                                    color: kBlueSky,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name ?? '',
                                      style:
                                          Get.textTheme.headlineLarge?.copyWith(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    Text(
                                      'display_unit_name'.tr,
                                      style: Get.textTheme.displayMedium
                                          ?.copyWith(fontSize: 16.sp),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SwitchWidget(
                                value: item.isEnabled ?? false,
                                onChanged: (value) =>
                                    controller.onShowUnit(value, item),
                                activeColor: kAccent00)
                          ],
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emergency() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.w, vertical: verticalPadding.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(customBorderRadius.r),
        color: kPrimaryLight,
        border: Border.all(color: kRed, width: 1.5.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          Row(
            spacing: 12.w,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r), color: kGrey38),
                child: Icon(
                  Icons.front_hand,
                  color: kBlueSky,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Text(
                    'emergency_gesture'.tr,
                    style:
                        Get.textTheme.headlineLarge?.copyWith(fontSize: 18.sp),
                  ),
                  Text(
                    'critical_safety_feature_for_urgent_distress'.tr,
                    style: Get.textTheme.headlineMedium
                        ?.copyWith(fontSize: 14.sp, color: kRed),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'tow_finger_emergency_gesture'.tr,
                    style:
                        Get.textTheme.headlineLarge?.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    'long_press_with_two_finger_ta_active_sos'.tr,
                    style:
                        Get.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SwitchWidget(
                value: controller.gestureEnabled.value,
                onChanged: (value) => controller.onChangeGesture(
                  value,
                ),
                activeColor: kRed,
                activeBorderColor: kRed,
              )
            ],
          ),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding.w, vertical: verticalPadding.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(customBorderRadius.r),
              color: kRed.withAlpha(10),
              border: Border.all(color: kRed, width: 1.h),
            ),
            child: Text(
              """How it works:

• Place two fingers anywhere on the screen
• Hold for 1.0 seconds without moving them
• This will trigger the SOS confirmation dialog
• Use only in genuine emergency situations""",
              style: Get.textTheme.headlineLarge
                  ?.copyWith(fontSize: 16.sp, color: kRedFE),
            ),
          ),
        ],
      ),
    );
  }
}
