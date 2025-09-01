import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/models/unit.dart';
import 'package:responder_app/screens/auth/register_unit/register_unit_controller.dart';
import 'package:responder_app/theme/app_images.dart';
import 'package:responder_app/utils/date_time_util.dart';
import 'package:responder_app/widgets/avatar/rounded_avatar.dart';
import 'package:responder_app/widgets/buttons/base_text_button.dart';
import 'package:responder_app/widgets/buttons/loading_button.dart';
import 'package:responder_app/widgets/dropdown/drop_down.dart';
import 'package:responder_app/widgets/empty_item.dart';
import 'package:responder_app/widgets/loaders/loading_page.dart';

import '../../../local/localization_service.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/change_language_widget.dart';

class RegisterUnitScreen extends BaseView<RegisterUnitController> {
  RegisterUnitScreen({super.key});

  @override
  PageProperties get pageProperties =>
      PageProperties(showAppBar: false, showAppBarLine: false);

  @override
  List<Widget> buildAppbarActions() {
    return [
      Spacer(),
    ];
  }

  @override
  Widget? buildBody(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        color: kPrimary1F,
        gradient: LinearGradient(
          colors: [
            kPrimary1F,
            kPrimary11,
            kPrimary1F,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: GetBuilder(
        init: controller,
        builder: (_) => LoadingPage(
          controller: controller,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ChangeLanguageWidget(controller: controller),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Container(
                    width: Get.width / 2.2,
                    margin: EdgeInsetsDirectional.only(top: 20.h),
                    constraints: BoxConstraints(maxWidth: 768.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(customBorderRadius.r),
                      border: Border.all(
                        color: kGrey37,
                      ),
                      color: kPrimary1F,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Image logo ---------------------------------
                        RoundedAvatar(
                          height: 65.h,
                          width: 65.w,
                          borderRadius: 0,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        /// Welcome  ---------------------------------
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'welcome'.tr,
                              style: Get.textTheme.displayMedium?.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${controller.user?.firstName?.capitalizeFirst}',
                              style: Get.textTheme.displayLarge?.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),

                        /// Step  ---------------------------------
                        Text(
                          'step_2'.tr,
                          style: Get.textTheme.displayMedium
                              ?.copyWith(fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),

                        /// Recently units ---------------------------------
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'recently_logged_units'.tr,
                            style: Get.textTheme.headlineLarge
                                ?.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        controller.previousUnits == null ||
                                controller.previousUnits!.isEmpty
                            ? EmptyItems(
                                title: 'no_recently_units'.tr,
                              )
                            : Row(
                                spacing: 12.w,
                                children: controller.previousUnits!
                                    .map(
                                      (unit) => Expanded(
                                        child: GestureDetector(
                                          onTap: () =>
                                              controller.onSelectUnit(unit),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.h,
                                                horizontal: 16.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              border: Border.all(
                                                color:
                                                    controller.selectedUnit ==
                                                            unit
                                                        ? kAccent
                                                        : kWhite.withAlpha(10),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  AppImages.police1,
                                                  width: 40.w,
                                                ),
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                Text(
                                                  unit.agencyId ?? '',
                                                  style: Get
                                                      .textTheme.headlineLarge
                                                      ?.copyWith(
                                                          fontSize: 14.sp),
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                Text(
                                                  unit.unitId ?? '',
                                                  style: Get
                                                      .textTheme.displayMedium
                                                      ?.copyWith(
                                                          fontSize: 12.sp),
                                                ),
                                                SizedBox(
                                                  height: 4.h,
                                                ),
                                                Text(
                                                  DateTimeUtil
                                                          .toDayNameDateAndTime(
                                                              unit.lastLogin ??
                                                                  DateTime
                                                                      .now()) ??
                                                      '',
                                                  style: Get
                                                      .textTheme.labelMedium
                                                      ?.copyWith(
                                                          fontSize: 12.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                        SizedBox(
                          height: 24.h,
                        ),

                        /// OR ---------------------------------
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 2.h,
                              color: kGrey4c,
                            )),
                            Text(
                              'or'.tr,
                              style: Get.textTheme.headlineMedium
                                  ?.copyWith(fontSize: 20.sp),
                            ).paddingSymmetric(horizontal: 12.w),
                            Expanded(
                                child: Container(
                              height: 2.h,
                              color: kGrey4c,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 24.h,
                        ),

                        /// Unit ---------------------------------
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            'unit_id'.tr,
                            style: Get.textTheme.displayMedium
                                ?.copyWith(fontSize: 14.sp, color: kGreyD1),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        DropDown<Unit>(
                          controller.allUnits,
                          hint: 'select_your_unit'.tr,
                          onSave: controller.onSaveUnit,
                          onChange: controller.onSaveUnit,
                          horizontalPadding: 16.w,
                          borderColor: kGrey4B,
                        ),
                        SizedBox(
                          height: 24.h,
                        ),

                        /// Btn ---------------------------------
                        Row(
                          spacing: 12.w,
                          children: [
                            Expanded(
                                child: BaseTextButton(
                              title: 'back'.tr,
                              onPress: controller.onBack,
                            )),
                            Expanded(
                                child: RoundedLoadingButton(
                              controller: controller.btnController,
                              title: 'login'.tr,
                              onPressed: controller.onLogin,
                              color: kGreyD1,
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
