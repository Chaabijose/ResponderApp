import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_animation.dart';
import '../theme/app_colors.dart';
import '../widgets/buttons/base_text_button.dart';

class ConfirmationDialog extends StatefulWidget {
  final String title;
  final String? iconSvg;
  final String? lottie;
  final String? body;
  final String? okText;
  final String? cancelTxt;
  final GestureTapCallback onOkClick;
  final GestureTapCallback? onCancelClick;
  final Color? primary;

  const ConfirmationDialog(
      {super.key,
      required this.title,
      this.body,
      this.iconSvg,
      this.lottie,
      required this.onOkClick,
      this.onCancelClick,
      this.cancelTxt,
      this.primary = kPrimary,
      this.okText});

  @override
  ConfirmationDialogState createState() => ConfirmationDialogState();
}

class ConfirmationDialogState extends State<ConfirmationDialog>
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
            color: kPrimary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kGreen.withOpacity(0.1), width: 1)),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.lottie != null ?  Lottie.asset(widget.lottie!) :
                  widget.iconSvg != null ? SvgPicture.asset(
                    widget.iconSvg!,
                  ) : Lottie.asset(AppAnimation.success) ,
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.displayMedium!
                        .copyWith(fontSize: 18.sp, height: 1.6),
                  ),
                  SizedBox(
                    height: widget.body != null ? 6.h : 32.h,
                  ),
                  if (widget.body != null)
                    Text(
                      widget.body ?? '',
                      textAlign: TextAlign.start,
                      style: Get.textTheme.displayLarge!.copyWith(
                          fontSize: 15.sp, height: 1.6),
                    ),
                  if (widget.body != null)
                    SizedBox(
                      height: 32.h,
                    ),
                  BaseTextButton(
                    title: widget.okText ?? 'ok'.tr,
                    primary: widget.primary ?? kPrimary,
                    borderColor: widget.primary,
                    onPress: () => widget.onOkClick.call(),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BaseTextButton(
                    title: widget.cancelTxt ?? 'cancel'.tr,
                    primary: kGreen.withOpacity(0.1),
                    borderColor: kGreen.withOpacity(0.1),
                    txtColor: kPrimary,
                    onPress: () => widget.onCancelClick == null
                        ? Get.back()
                        : widget.onCancelClick!.call(),
                  ),
                ])));
  }
}
