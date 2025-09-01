import 'package:get/get.dart';
import 'package:responder_app/base/base_bindings.dart';
import 'package:responder_app/screens/my_unit/my_unit_controller.dart';
import 'package:responder_app/screens/my_unit/my_unit_repository.dart';

class MyUnitBindings extends BaseBindings{
  @override
  void dependencies() {
  Get.put(MyUnitRepository(),tag: tag);
  Get.put(MyUnitController(),tag: tag);
  }

}