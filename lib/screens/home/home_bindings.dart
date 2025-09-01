import 'package:get/get.dart';
import 'package:responder_app/base/base_bindings.dart';
import 'package:responder_app/screens/home/home_controller.dart';
import 'package:responder_app/screens/home/home_repository.dart';

class HomeBindings extends BaseBindings{


  @override
  void dependencies() {
  Get.put(HomeRepository(),tag: tag);
  Get.put(HomeController(),tag: tag);
  }

}