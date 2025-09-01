import 'package:get/get.dart';
import 'package:responder_app/base/base_controller.dart';
import 'package:responder_app/models/local_enums.dart';
import 'package:responder_app/screens/my_unit/my_unit_repository.dart';

class MyUnitController extends BaseController<MyUnitRepository>{
  @override
  MyUnitRepository get repository => Get.find(tag: tag);

  /// Data ************************************************************
  MyUnitEnum selectedTab = Get.arguments ?? MyUnitEnum.unitDetails;
  ShiftHistoryFilter selectedFilter = ShiftHistoryFilter.today;
  /// Lifecycle ************************************************************

  /// Listeners ************************************************************
  void onTabChanged(MyUnitEnum value){
    selectedTab = value;
    update();
  }

  void onFilterChanged(ShiftHistoryFilter value){
    selectedFilter = value;
    update();
  }
  /// Logic ************************************************************

  /// Api Requests ************************************************************
}