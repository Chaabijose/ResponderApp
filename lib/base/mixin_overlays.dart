import 'dart:ui';
import 'package:get/get.dart';
import '../dialogs/confirmation_dialog.dart';

mixin Overlays {
  void showConfirmationDialog(
      {required String title,
      String? body,
      String? iconSvg,
      String? lottie,
      Color? primary,
      required Function okCallback,
      Function? cancelCallback,
      String? cancelTxt,
      String? okText}) {
    Get.dialog(
      ConfirmationDialog(
        title: title,
        body: body,
        primary: primary,
        cancelTxt: cancelTxt,
        okText: okText,
        onOkClick: () {
          Get.back();
          okCallback.call();
        },
        onCancelClick: () {
          Get.back();
          cancelCallback?.call();
        },
        iconSvg: iconSvg,
        lottie: lottie,
      ),
    );
  }


}
