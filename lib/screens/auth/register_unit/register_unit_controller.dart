import 'package:get/get.dart';
import 'package:responder_app/base/base_controller.dart';
import 'package:responder_app/base/language_controller.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/unit.dart';
import 'package:responder_app/screens/auth/register_unit/register_unit_repository.dart';
import 'package:responder_app/widgets/buttons/loading_button.dart';

import '../../../models/api/resource.dart';
import '../../../models/user.dart';
import '../../../navigation/app_routes.dart';

class RegisterUnitController extends LanguageController<RegisterUnitRepository>{
  @override
  RegisterUnitRepository get repository => Get.find(tag:tag);

  /// Data **************************************
  User? user = Get.arguments;
  List<Unit>? previousUnits = pref.previousUnits;
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  Unit? selectedUnit;
  List<Unit> allUnits = [];

  /// LifeCycle **************************************
  @override
  void onCreate() {
    loading.value = true;
    _fetchUnits();
  }
  /// Listeners **************************************
  void onSaveUnit(Unit? unit){
   previousUnits ??= [];
   if(previousUnits!.firstWhereOrNull((item)=>item.unitId == unit!.unitId) != null) return;
   if(previousUnits!.length >= 2){
     previousUnits!.removeAt(0);
   }
   previousUnits!.add(unit!);
    update();
  }

  Future<void> onLogin() async {
    if(selectedUnit == null){
      showErrorMessage('you_must_select_unit'.tr);
      return;
  }
    btnController.start();
    savePref();
    Get.offAllNamed(Routes.home);
    update();
  }

  void onBack(){
  Get.back();
  }

  void onSelectUnit(unit){
    selectedUnit = unit;
    onLogin();
    update();
  }

  /// Logic **************************************
  void savePref(){
    if(pref.previousUnits != null && pref.previousUnits!.length > 2){
      pref.previousUnits!.removeAt(0);
      pref.previousUnits!.add(selectedUnit!);
    }
    if(pref.previousUnits == null){
      pref.previousUnits ??= [];
      pref.previousUnits = [selectedUnit!];
    }
    if(pref.previousUnits != null){
      pref.previousUnits = previousUnits;
    }
    selectedUnit!.lastLogin = DateTime.now();
    pref.myUnit = selectedUnit;
    update();
  }

  void _responseUnit(Resource resource){
    stopLoading();
    if(resource.isError())return;
    allUnits.addAll(resource.data);
    update();
  }

/// Api & Requests **************************************
  Future<void> _fetchUnits()async{
    var resource = await repository.fetchUnits();
    _responseUnit(resource);
  }
}