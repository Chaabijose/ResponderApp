import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/models/status.dart';
import 'package:responder_app/sheets/availability/availability_sheet_controller.dart';

import '../../theme/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/expansion_widget.dart';

class AvailabilitySheet extends StatefulWidget {
  final Status status;

  const AvailabilitySheet({super.key, required this.status});

  @override
  State<AvailabilitySheet> createState() => _AvailabilitySheetState();
}

class _AvailabilitySheetState extends State<AvailabilitySheet>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

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
    return Center(
      child: Wrap(
        children: [
          Material(
            color: Colors.transparent,
            child: Platform.isAndroid
                ? ScaleTransition(
                    scale: scaleAnimation!,
                    child: _body(),
                  )
                : _body(),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return GetBuilder(
      init: Get.put(AvailabilitySheetController()),
      didChangeDependencies: (c) =>
          c.controller?.selectedStatus = widget.status,
      builder: (controller) => Container(
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
        ),
        child: SafeArea(
            child: Column(
          children: [
            /// Title & close *********************************
            SizedBox(height: verticalPadding.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'update_unit_state'.tr,
                  style: Get.textTheme.headlineLarge?.copyWith(
                    fontSize: 22.sp,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Get.back(result: controller.selectedStatus);
                    },
                    child: Icon(
                      Icons.clear,
                      color: kGrey9C,
                    )),
              ],
            ).paddingSymmetric(
              horizontal: horizontalPadding.w,
            ),
            SizedBox(
              height: 16.h,
            ),
            Divider(
              color: kGrey9C,
              thickness: 2.h,
            ),
            SizedBox(
              height: 16.h,
            ),

            /// Status *********************************
            SizedBox(
              width: Get.width,
              height: 300.h,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16.h,
                  children: [
                    _statusItem(
                        status: controller.otherStatus.first,
                        controller: controller),
                    _statusItem(
                      status: controller.otherStatus[1],
                      controller: controller,
                    ),
                    Divider(
                      color: kGrey9C,
                      thickness: 0.5.h,
                    ),
                    ExpansionWidget(
                      customTitle: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding.w,
                            vertical: verticalPadding.h),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(customBorderRadius.r),
                          color: kGrey2B,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 12.w,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(customBorderRadius.r),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kGrey24,
                                  ),
                                  child: Icon(Icons.settings, color: kWhite),
                                ),
                                Column(
                                  spacing: 6.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'other_status_options'.tr,
                                      style: Get.textTheme.headlineLarge
                                          ?.copyWith(fontSize: 18.sp),
                                    ),
                                    Text(
                                      '${controller.otherStatus.length - 2} ${'additional_status'.tr}'
                                          .tr,
                                      style: Get.textTheme.displayMedium
                                          ?.copyWith(fontSize: 16.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Obx(
                              () => GestureDetector(
                                  onTap: controller.openCloseStatus,
                                  child: Icon(
                                    controller.isOpen.value
                                        ? Icons.keyboard_arrow_down
                                        : Icons.keyboard_arrow_right,
                                    color: kGrey9C,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      contentWidget: Column(
                        spacing: 16.h,
                        children: controller.otherStatus
                            .map((item) =>
                                controller.otherStatus.indexOf(item) == 0 ||
                                        controller.otherStatus.indexOf(item) ==
                                            1
                                    ? SizedBox()
                                    : _statusItem(
                                        status: item, controller: controller))
                            .toList(),
                      ),
                      showIcon: true,
                      isOpen: controller.isOpen.value,
                    )
                  ],
                ).paddingSymmetric(
                  horizontal: horizontalPadding.w,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget _statusItem(
      {required Status status,
      required AvailabilitySheetController controller}) {
    return GestureDetector(
      onTap: () => controller.onSelectStatus(status),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(customBorderRadius.r),
          color: controller.selectedStatus == status
              ? kGrey2c
              : Colors.transparent,
        ),
        child: Row(
          spacing: 12.w,
          children: [
            Container(
              padding: EdgeInsets.all(customBorderRadius.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: status.color ?? kAccent,
              ),
              child: Icon(
                status.icon ?? Icons.check_box_rounded,
                color: kWhite,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  '${status.title} ${controller.selectedStatus == status ? '(${'current'.tr})' : ''}' ??
                      '',
                  style: Get.textTheme.headlineLarge?.copyWith(
                      fontSize: 18.sp,
                      color: controller.selectedStatus == status
                          ? kGrey8F
                          : kWhite),
                ),
                Text(
                  status.body ?? '',
                  style: Get.textTheme.displayMedium?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
