import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/base_controller.dart';
import '../../theme/app_colors.dart';
import 'loader.dart';

class LoadingPage extends StatelessWidget {
  final BaseController controller;
  final Widget child;
  final Color loaderColor;
  const LoadingPage(
      {super.key,
      required this.controller,
      required this.child,
      this.loaderColor = kPrimary});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          child,
          if (controller.loading.value)
            Container(
              height: Get.height,
              width: Get.width,
              color: kGreyLight.withOpacity(0.5),
            ),
          if (controller.loading.value)
            Align(
                alignment: Alignment.center,
                child: Loader(
                  color: loaderColor,
                  size: LoaderSize.large,
                )),
        ],
      ),
    );
  }
}
