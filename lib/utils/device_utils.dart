import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responder_app/utils/constants.dart';

class DeviceUtils{

  /// Data ******************************************************


  static bool isLandscape(){
    return Get.context?.orientation == Orientation.landscape;
  }

  static bool isTablet(){
    return Get.size.width > Constants.tabletMinWidth;
  }

  static bool get isLandscapeOrTablet => isLandscape() || isTablet();
}