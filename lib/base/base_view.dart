import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../app.dart';
import 'base_controller.dart';
import 'view_mixin.dart';

abstract class BaseView<C extends BaseController> extends GetView<C>
    with ViewMixin {
  @override
  final String? tag = Get.currentRoute + kNumOfNav.toString();

  BaseView({super.key});

  @override

  Widget build(BuildContext context) {
    return buildPage(context);
  }
}
