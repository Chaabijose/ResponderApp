import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_view.dart';
import 'package:responder_app/models/api/page_properties.dart';
import 'package:responder_app/screens/my_unit/my_unit_controller.dart';

import '../../models/local_enums.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_images.dart';
import '../../utils/constants.dart';

class MyUnitScreen extends BaseView<MyUnitController> {
  MyUnitScreen({super.key});

  @override
  PageProperties get pageProperties => PageProperties(title: 'my_unit'.tr);

  @override
  Widget? buildBody(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (cont) => SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(customBorderRadius.r),
              color: kPrimary),
          child: Column(
            spacing: 24.h,
            children: [
              /// Tabs
              Row(
                children: MyUnitEnum.values
                    .map((item) => Expanded(
                          child: InkWell(
                            onTap: () => controller.onTabChanged(item),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                spacing: 16.h,
                                children: [
                                  Center(
                                    child: Text(
                                      item.title.tr,
                                      style: Get.textTheme.displayMedium
                                          ?.copyWith(
                                              fontSize: 14.sp,
                                              color:
                                                  controller.selectedTab == item
                                                      ? kBlueSky
                                                      : kGrey9C),
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    height: 1.5.h,
                                    color: controller.selectedTab == item
                                        ? kBlueSky
                                        : kGrey9C.withAlpha(15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),

              /// Body
              Expanded(
                  child: SingleChildScrollView(
                child: controller.selectedTab == MyUnitEnum.unitDetails
                    ? _unitDetails()
                    : _shiftHistory(),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _unitDetails() {
    return Column(
      spacing: 16.h,
      children: [
        /// car
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
          ),
          child: Column(
            spacing: 20.h,
            children: [
              /// car info
              Row(
                spacing: 16.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGrey17,
                    ),
                    child: Image.asset(
                      AppImages.police1,
                      width: 35.w,
                    ),
                  ),
                  Column(
                    spacing: 6.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Riyadh 1',
                        style: Get.textTheme.headlineLarge?.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        'Police unit',
                        style: Get.textTheme.displayMedium?.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              /// status & Zone
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: [
                      Text(
                        'status'.tr,
                        style: Get.textTheme.displayMedium?.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        'Available',
                        style: Get.textTheme.displayMedium
                            ?.copyWith(fontSize: 16.sp, color: kAccent),
                      ),
                    ],
                  ),

                  /// Zone
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.h,
                    children: [
                      Text(
                        'zone'.tr,
                        style: Get.textTheme.displayMedium?.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        'Central District',
                        style: Get.textTheme.displayLarge?.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              )
            ],
          ),
        ),

        /// Officer info
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
          ),
          child: Column(
            spacing: 12.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: kBlueSky,
                    size: 20.r,
                  ),
                  Text(
                    'officer_information'.tr,
                    style: Get.textTheme.headlineLarge?.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.h,
              ),
              _infoItem(title: 'name', value: 'Officer Mohamed'),
              _infoItem(title: 'badge', value: '#1234'),
              _infoItem(title: 'shift_start', value: '08:00'),
              _infoItem(title: 'shift_end', value: '20:00'),
            ],
          ),
        ),

        /// Vehicle Details
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
          ),
          child: Column(
            spacing: 12.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Icon(
                    Icons.directions_car_filled,
                    color: kBlueSky,
                    size: 20.r,
                  ),
                  Text(
                    'vehicle_details'.tr,
                    style: Get.textTheme.headlineLarge?.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.h,
              ),
              _infoItem(title: 'vehicle_id', value: 'P-2024-007'),
              _infoItem(title: 'license_plate', value: 'RYD 1234'),
              Column(
                spacing: 8.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8.w,
                        children: [
                          Icon(
                            Icons.local_gas_station_outlined,
                            color: kGrey9C,
                          ),
                          Text(
                            '${'fuel_level'.tr}:',
                            style: Get.textTheme.displayMedium?.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '78%',
                        style: Get.textTheme.displayLarge?.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: 0.8,
                    color: kAccent,
                    backgroundColor: kGrey38,
                    minHeight: 5.h,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ],
              ),
              _infoItem(title: 'mileage', value: '45,230 km'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      Icon(
                        Icons.build,
                        color: kGrey9C,
                        size: 15.sp,
                      ),
                      Text(
                        '${'last_maintenance'.tr}:',
                        style: Get.textTheme.displayMedium?.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Dec 15, 2024',
                    style: Get.textTheme.displayLarge?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// Location
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(customBorderRadius.r),
            color: kPrimaryLight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: kBlueSky,
                    size: 20.r,
                  ),
                  Text(
                    'current_location'.tr,
                    style: Get.textTheme.headlineLarge?.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.h,
              ),
              Text(
                'Al Olaya District, Northern Patrol Route',
                style: Get.textTheme.displayMedium?.copyWith(fontSize: 18.sp),
              ),
              Text(
                'Last updated: 2 minutes ago',
                style: Get.textTheme.labelMedium?.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoItem({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${title.tr}:',
          style: Get.textTheme.displayMedium?.copyWith(
            fontSize: 16.sp,
          ),
        ),
        Text(
          value.tr,
          style: Get.textTheme.displayLarge?.copyWith(
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  Widget _shiftHistory() {
    return Column(
      spacing: 20.h,
      children: [
        /// tabs info
        Row(
          spacing: 12.w,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(customBorderRadius.r),
                  color: kAccent.withAlpha(30),
                ),
                child: Column(
                  children: [
                    Text(
                      '3',
                      style: Get.textTheme.headlineSmall?.copyWith(
                        fontSize: 22.sp,
                        color: kAccent,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: kAccent,
                        ),
                        Text(
                          'cleared_events'.tr,
                          style: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: 22.sp,
                            color: kAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(customBorderRadius.r),
                  color: kOrangeFd.withAlpha(40),
                ),
                child: Column(
                  children: [
                    Text(
                      '1',
                      style: Get.textTheme.headlineSmall?.copyWith(
                        fontSize: 22.sp,
                        color: kOrangeFd,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.warning_amber,
                          color: kOrangeFd,
                        ),
                        Text(
                          'preempted_events'.tr,
                          style: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: 22.sp,
                            color: kOrangeFd,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(customBorderRadius.r),
                  color: kBlue61.withAlpha(40),
                ),
                child: Column(
                  children: [
                    Text(
                      '3',
                      style: Get.textTheme.headlineSmall?.copyWith(
                        fontSize: 22.sp,
                        color: kBlue61,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.refresh,
                          color: kBlue61,
                        ),
                        Text(
                          'in_progress'.tr,
                          style: Get.textTheme.headlineSmall?.copyWith(
                            fontSize: 22.sp,
                            color: kBlue61,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        /// filter
        Row(
          spacing: 12.w,
          children: ShiftHistoryFilter.values
              .map((item) => InkWell(
                    onTap: () => controller.onFilterChanged(item),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(customBorderRadius.r),
                          color: controller.selectedFilter == item
                              ? kAccent00
                              : kGrey38),
                      child: Text(
                        item.title.tr,
                        style: Get.textTheme.displayLarge?.copyWith(
                            fontSize: 16.sp,
                            color: controller.selectedFilter == item
                                ? kWhite
                                : kGrey9C),
                      ),
                    ),
                  ))
              .toList(),
        ),

        /// Data
        Column(
          spacing: 12.h,
          children: [
            _historyItem(
                icon: Icons.check_box_rounded,
                iconColor: kAccent,
                title: 'Traffic Violation',
                value: '16:30 . King fahd Road & Olaya St',
                priority: 'MEDIUM',
                priorityColor: kOrangeFd,
                time: '45 min'),
            _historyItem(
                icon: Icons.check_box_rounded,
                iconColor: kAccent,
                title: 'Noise Complaint',
                value: '15:15 . Al Malaz District',
                priority: 'LOW',
                priorityColor: kAccent,
                time: '20 min'),
            _historyItem(
                icon: Icons.warning,
                iconColor: kOrangeFF,
                title: 'Suspicious Activity',
                value: '15:15 . Al Malaz District',
                priority: 'HIGH',
                priorityColor: kRed.withAlpha(150),
                time: '10 min'),
            _historyItem(
                icon: Icons.check_box_rounded,
                iconColor: kAccent,
                title: 'Welfare Check',
                value: '12:45 . Diplomatic Quarter',
                priority: 'MEDIUM',
                priorityColor: kOrangeFd,
                time: '20 min'),
          ],
        )
      ],
    );
  }

  Widget _historyItem(
      {required IconData icon,
      required Color iconColor,
      required String title,
      required String value,
      required String priority,
      required Color priorityColor,
      required String time}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(customBorderRadius.r),
          border: Border.all(color: kGrey9C.withAlpha(40)),
          color: kPrimaryLight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8.w,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.tr,
                    style: Get.textTheme.displayLarge?.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    value.tr,
                    style: Get.textTheme.displayMedium?.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            spacing: 6.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                priority,
                style: Get.textTheme.displayLarge?.copyWith(
                  fontSize: 18.sp,
                  color: priorityColor,
                ),
              ),
              Text(
                time,
                style: Get.textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
