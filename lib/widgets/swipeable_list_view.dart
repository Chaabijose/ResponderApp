import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../base/swipable_refresh.dart';
import '../base/swipeable_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_images.dart';

class SwipeableListView extends StatelessWidget {
  ///Data - Constructor *****************
  final SwipeableController controller;
  final int itemsCount;
  final IndexedWidgetBuilder? itemBuilder;
  final double headerTrigger;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final String? emptyPlaceholder;
  final String? emptyText;
  final Widget? emptyWidget;
  final Widget? separator;

  const SwipeableListView(
      {super.key,
      required this.controller,
      this.emptyWidget,
      this.separator,
      required this.itemsCount,
      this.itemBuilder,
      this.child,
      this.emptyPlaceholder,
      this.emptyText,
      this.headerTrigger = 5,
      this.padding});

  ///Build ******************************
  @override
  Widget build(BuildContext context) {
    controller.setRefreshListeners();
    return FRefresh(
        header: SizedBox(
          height: 5,
          child: LinearProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
              backgroundColor: kPrimary.withOpacity(0.7)),
        ),
        controller: controller.refreshController,
        shouldLoad: controller.footerEnabled,
        headerHeight: 5,
        headerTrigger: headerTrigger,
        headerBuilder: (__, ___) => SizedBox(
              height: 5,
              width: Get.width,
              child: LinearProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
                  backgroundColor: kPrimary.withOpacity(0.7)),
            ),
        footerHeight: controller.footerEnabled ? 5 : 0,
        footer: SizedBox(
          height: 5,
          child: LinearProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimary),
              backgroundColor: kPrimary.withOpacity(0.7)),
        ),
        child: itemsCount == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emptyWidget ??
                      Column(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              emptyPlaceholder ?? AppImages.empty,
                              width: 150,
                              height: 300,
                            ),
                          ),
                          Text(
                            emptyText ?? 'no_data'.tr,
                            style: Get.textTheme.titleMedium
                                ?.copyWith(color: kGreyHint, fontSize: 18.sp),
                          ),
                        ],
                      ),
                ],
              )
            : child ??
                ListView.separated(
                    separatorBuilder: (_, index) =>
                        separator ?? const SizedBox(),
                    itemCount: itemsCount,
                    padding: padding,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: itemBuilder ?? (_, __) => const SizedBox()));
  }
}
