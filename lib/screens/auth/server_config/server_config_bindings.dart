import 'package:get/get.dart';
import 'package:responder_app/base/base_bindings.dart';
import 'package:responder_app/screens/auth/server_config/server_config_controller.dart';
import 'package:responder_app/screens/auth/server_config/server_config_repository.dart';

class ServerConfigBindings extends BaseBindings{
  @override
  void dependencies() {
  Get.put(ServerConfigRepository(),tag: tag);
  Get.put(ServerConfigController(),tag: tag);
  }

}