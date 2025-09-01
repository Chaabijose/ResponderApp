import 'package:get/get.dart';
import 'package:responder_app/base/base_bindings.dart';
import 'package:responder_app/screens/auth/auth_controller.dart';
import 'package:responder_app/screens/auth/auth_repository.dart';

class AuthBindings extends BaseBindings{
  @override
  void dependencies() {
  Get.put(AuthRepository(),tag: tag);
  Get.put(AuthController(),tag: tag);
  }

}