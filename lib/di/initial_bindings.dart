import 'package:get/get.dart';
import '../base/dio/dio_client.dart';
import '../helper/auth_helper.dart';
import '../main.dart';
import '../theme/theme_controller.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthHelper());
    if(pref.serverUrl != null) Get.put(DioClient());
    Get.put(ThemeController());
  }
}
