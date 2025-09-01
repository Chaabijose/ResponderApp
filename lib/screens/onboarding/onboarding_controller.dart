import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../base/base_controller.dart';
import '../../base/base_repository.dart';
import '../../main.dart';
import '../../models/on_boarding.dart';
import '../../navigation/app_routes.dart';

class OnBoardingController extends BaseController {
  @override
  BaseRepository? get repository => null;

  /// Data *********************************************************************
  var currentPosition = 0.obs;
  final PageController pageController = PageController(keepPage: true);
  var userGuides = [
    OnBoarding(
      title: 'guide1_title'.tr,
      description: 'sample_text'.tr,
      // image: AppImages.userGuide1,
    ),
    OnBoarding(
      title: 'guide2_title'.tr,
      description: 'guide2_description'.tr,
      // image: AppImages.userGuide2,
    ),
    OnBoarding(
      title: 'guide3_title'.tr,
      description: 'guide3_description'.tr,
      // image: AppImages.userGuide3,
    ),
  ];

  /// Lifecycle methods ********************************************************
  @override
  onCreate() {}

  @override
  onDestroy() {
    pageController.dispose();
  }

  /// Listeners ********************************************
  void finish() {
    // pref.setTookUserGuide(true);
    // navigateTo();
  }

  void onSignInAccount() {
    pref.tookUserGuide = true;
    Get.offAllNamed(Routes.auth);
  }

  void onSignUpAccount() {
    pref.tookUserGuide = true;
    Get.offAllNamed(Routes.home);
  }

  /// Logic *************************************************
  bool isLastPage() => userGuides.length - 1 == currentPosition.value;
}
