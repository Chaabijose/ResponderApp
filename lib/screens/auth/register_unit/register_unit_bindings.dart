import 'package:get/get.dart';
import 'package:responder_app/base/base_bindings.dart';
import 'package:responder_app/screens/auth/register_unit/register_unit_controller.dart';
import 'package:responder_app/screens/auth/register_unit/register_unit_repository.dart';

class RegisterUnitBindings extends BaseBindings{
  @override
  void dependencies() {
  Get.put(RegisterUnitRepository(),tag:tag);
  Get.put(RegisterUnitController(),tag:tag);
  }

}