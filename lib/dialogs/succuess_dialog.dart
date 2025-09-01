import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/base_text_button.dart';

class SuccessDialog extends StatefulWidget {
  final String? animation;
  final String? body;
  final String? okText;
  final GestureTapCallback onOkClick;

  const SuccessDialog(
      {super.key,
      this.animation,
      this.body,
      this.okText,
      required this.onOkClick});

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog>
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
    ]));
  }

  Widget buildBody(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints(minHeight: 180),
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGreen.withOpacity(0.1), width: 1)),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Lottie.asset(widget.animation ?? AppAnimation.success,
                      width: 150, height: 150),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (widget.body != null)
                    Text(
                      widget.body ?? '',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.labelLarge!.copyWith(
                          color: kBlack, fontSize: 20.sp, height: 1.6),
                    ),
                  if (widget.body != null)
                    SizedBox(
                      height: 32.h,
                    ),
                  BaseTextButton(
                    title: widget.okText ?? 'home'.tr,
                    onPress: () => widget.onOkClick.call(),
                  ),
                ])));
  }
}
