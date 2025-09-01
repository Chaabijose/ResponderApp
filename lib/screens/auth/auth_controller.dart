import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/language_controller.dart';
import 'package:responder_app/main.dart';
import 'package:responder_app/models/api/resource.dart';
import 'package:responder_app/models/user.dart';
import 'package:responder_app/navigation/app_routes.dart';
import 'package:responder_app/screens/auth/auth_repository.dart';
import 'package:responder_app/dialogs/config_server/config_srever_dialog.dart';

User? user;

class AuthController extends LanguageController<AuthRepository>{
  @override
  AuthRepository get repository => Get.find(tag: tag);

  /// Data  **************************************
  String? userName, password;
  var isChecked = false.obs;
  var isServerURLValid = true.obs; // use it after check health in edit (settings icon)

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isValidData = false.obs;
  /// LifeCycle **************************************

  /// Listeners **************************************
  void onSavePassword(String?value) {
    password = value;
    _allEntered();
  }

  void onSaveUserName(String? value) {
    userName = value;
    _allEntered();
  }

  void onRemember(){
    isChecked.value = !isChecked.value;
    _allEntered();
  }

   Future<void> onSettings()async{
    var res = await Get.dialog(ConfigServerDialog());
    if(res == null) return;
    pref.serverUrl = res;
  }

  Future<void> onNext()async{
    if(!isValidData.value || !(formKey.currentState?.validate() ?? false)) return;
    if(password == null || userName ==null)return;
      formKey.currentState!.save();
      loading.value = true;
      _login();
  }

  /// Logic **************************************
    void _allEntered(){
      isValidData.value = isChecked.value && (password?.isNotEmpty ?? false) && (userName?.isNotEmpty ?? false);
    }

    void _responseLogin(Resource resource){
      stopLoading();
    if(resource.isError()) {
      showErrorMessage(resource.successMessage??'Failed'.tr);
   return;
    }
    user = resource.data;
    if(isChecked.value){
      pref.user = user;
    }
    Get.toNamed(Routes.registerUnit,arguments: user);
    }
  /// ApiResponse **************************************

  Future<void> _login()async{
    var resource = await repository.login(userName:userName!,password:password!);
    await delay();
    _responseLogin(resource);
  }
}