import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:responder_app/screens/auth/server_config/server_config_controller.dart';

import '../../main.dart';

class ConfigServerDialogController extends ServerConfigController{

  /// Data *********************************************************************
  final txtController = TextEditingController();
  var editable = false.obs;

  /// Lifecycle Methods ********************************************************
  @override
  onCreate(){
    txtController.text = pref.serverUrl ?? '';
    super.onCreate();
  }


  /// Listeners ****************************************************************
  void onCanEdit(){
    editable.value = !editable.value;
    if(!editable.value) txtController.text = pref.serverUrl ?? '';
  }

  /// Logic ********************************************************************
  @override
  void navigateTo() {
    Get.back(result: url);
  }
}