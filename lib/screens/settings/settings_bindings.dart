import 'package:get/get.dart';
import 'package:responder_app/base/base_bindings.dart';
import 'package:responder_app/screens/settings/settings_controller.dart';
import 'package:responder_app/screens/settings/settings_repository.dart';

class SettingsBindings extends BaseBindings{
  @override
  void dependencies() {
  Get.put(SettingsRepository(),tag:tag);
  Get.put(SettingsController(),tag:tag);
  }

}