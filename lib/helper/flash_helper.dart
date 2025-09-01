import 'package:flutter/material.dart';
import 'package:flash/flash.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_themes.dart';

class FlashHelper {
  static void showTopFlash(String? msg,
      {bool persistent = true,
      Color bckColor = kWarning,
      String title = "",
      bool showDismiss = false}) {
    showFlash(
      context: Get.context!,
      duration: const Duration(seconds: 5),
      persistent: persistent,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          // brightness: Brightness.light,
          // boxShadows: const [BoxShadow(blurRadius: 0)],
          // barrierBlur: 0.0,
          // barrierColor: Colors.black38,
          // barrierDismissible: true,
          child: FlashBar(
            title: title.isEmpty
                ? null
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kWhite,
                        height: 1.5,
                        fontFamily: kBold,
                        fontSize: 16),
                  ),
            content: Center(
              child: Text(msg != null && msg.isNotEmpty ? msg : 'Server Error'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.5,
                      color: kWhite,
                      fontFamily: kBold,
                      fontSize: 14)),
            ),
            elevation: 6,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(12),
                    bottomStart: Radius.circular(12))),
            behavior: FlashBehavior.fixed,
            position: FlashPosition.top,
            showProgressIndicator: false,
            shadowColor: Colors.black38,
            backgroundColor: bckColor,
            primaryAction: null,
            controller: controller,
          ),
        );
      },
    );
  }
}
