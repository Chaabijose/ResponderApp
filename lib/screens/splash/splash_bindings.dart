import 'package:get/get.dart';
import '../../base/base_bindings.dart';
import 'splash_controller.dart';
import 'splash_repository.dart';

class SplashBindings extends BaseBindings {
  @override
  void dependencies() {
    Get.put(SplashRepository(), tag: tag);
    Get.put(SplashController(), tag: tag);
  }
}
