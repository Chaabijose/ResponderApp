import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../local/localization_service.dart';
import '../theme/app_colors.dart';

class ExpansionWidget extends StatefulWidget {
  final bool showIcon;
  final bool isDate;
  final bool isOpen;
  final String? title;
  final String? label1;
  final String? label2;
  final TextStyle? textStyle;
  final Widget contentWidget;
  final Widget? customTitle;

  const ExpansionWidget(
      {super.key,
      this.showIcon = true,
      this.isOpen = true,
      this.customTitle,
      this.title,
      this.label1,
      this.label2,
      this.textStyle,
      required this.contentWidget,
      this.isDate = false});

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  late bool isOpen;
  IconData currentIcon = Icons.remove;

  @override
  void initState() {
    setState(() {
      isOpen = widget.isOpen;
      if (isOpen) {
        currentIcon = Icons.keyboard_arrow_up;
      } else {
        currentIcon = Icons.keyboard_arrow_down;
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      isOpen = widget.isOpen;
      if (isOpen) {
        currentIcon = Icons.keyboard_arrow_up;
      } else {
        currentIcon = Icons.keyboard_arrow_down;
      }
    });
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ExpansionWidget oldWidget) {
    setState(() {
      isOpen = widget.isOpen;
      if (isOpen) {
        currentIcon = Icons.keyboard_arrow_up;
      } else {
        currentIcon = Icons.keyboard_arrow_down;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only( bottom: isOpen ? 12.h : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title and label
          widget.customTitle ??
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.title != null)
                        Text(
                          widget.title ?? 'not_specified'.tr,
                          style: widget.textStyle ??
                              Get.textTheme.headlineLarge?.copyWith(
                                fontSize: 14.sp,
                              ),
                          textDirection:
                              widget.isDate && LocalizationService.isRtl()
                                  ? TextDirection.ltr
                                  : null,
                        ).marginOnly(bottom: 8.h),
                      if (widget.label1 != null && widget.label2 != null)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${widget.label1}. ',
                                style: widget.textStyle ??
                                    Get.textTheme.displayMedium?.copyWith(
                                        fontSize: 12.sp, color: kAccent),
                              ),
                              TextSpan(
                                text: widget.label2,
                                style: widget.textStyle ??
                                    Get.textTheme.labelMedium?.copyWith(
                                      fontSize: 12.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (widget.showIcon) iconAction(),
                ],
              ).paddingSymmetric(horizontal: 16.w),

          if (isOpen && widget.showIcon)
            widget.contentWidget.paddingSymmetric(horizontal: 16.w),
          if (!widget.showIcon)
            widget.contentWidget.paddingSymmetric(horizontal: 16.w),
        ],
      ),
    );
  }

  Widget iconAction() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 8.w),
      child: InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
              if (isOpen) {
                currentIcon = Icons.keyboard_arrow_up;
              } else {
                currentIcon = Icons.keyboard_arrow_down;
              }
            });
          },
          child: Icon(
            currentIcon,
            color: kWhite,
            size: 18.r,
          )),
    );
  }
}
