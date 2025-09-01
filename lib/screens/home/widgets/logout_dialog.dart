import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/widgets/buttons/base_text_button.dart';

import '../../../theme/app_colors.dart';

class LogoutDialog extends StatefulWidget {
  final Function onOk;
  const LogoutDialog({super.key, required this.onOk});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog>
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
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(color: Colors.black.withOpacity(0.1)),
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
      constraints: BoxConstraints(minHeight: 180.h, maxWidth: 380.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
          color: kPrimaryLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kGreen.withOpacity(0.1), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// title ---------------------------
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.clear,
                  color: kGrey9C,
                )),
          ),
          SizedBox(
            height: 12.h,
          ),

          Icon(
            Icons.logout,
            color: kRed,
            size: 30.r,
          ),
          SizedBox(
            height: 20.h,
          ),

          /// Server -----------------------------------
          Text(
            'confirm_logout'.tr,
            style: Get.textTheme.headlineLarge?.copyWith(fontSize: 20.sp),
          ),

          SizedBox(
            height: 16.h,
          ),

          Text(
            'confirm_logout_body'.tr,
            style: Get.textTheme.displayMedium?.copyWith(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: 20.h,
          ),

          /// btn -----------------------------------
          Row(
            spacing: 12.w,
            children: [
              Expanded(
                  child: BaseTextButton(
                title: 'cancel'.tr,
                onPress: () => Get.back(),
                height: 45.h,
              )),
              Expanded(
                  child: BaseTextButton(
                title: 'logout'.tr,
                primary: kRed,
                height: 45.h,
                onPress: () => widget.onOk.call(),
              )),
            ],
          )
        ],
      ),
    );
  }
}
