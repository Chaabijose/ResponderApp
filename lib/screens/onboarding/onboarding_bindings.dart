import 'package:get/get.dart';
import '../../base/base_bindings.dart';
import 'onboarding_controller.dart';

class OnBoardingBindings extends BaseBindings {

  @override
  void dependencies() {
    Get.put(OnBoardingController(), tag: tag);
  }

}