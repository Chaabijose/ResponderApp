import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responder_app/navigation/app_routes.dart';
import 'package:responder_app/screens/auth/server_config/server_config_repository.dart';
import 'package:responder_app/screens/splash/splash_controller.dart';
import 'package:responder_app/utils/validation.dart';
import '../../../base/language_controller.dart';
import '../../../main.dart';
import '../../../models/api/resource.dart';
import '../../../models/server_config.dart';
import '../../../models/server_health.dart';
import '../../../theme/app_colors.dart';

class ServerConfigController extends LanguageController<ServerConfigRepository>{

@override
  void injectRepository() {
  super.injectRepository();
  if(!Get.isRegistered<ServerConfigRepository>(tag: tag)) Get.put(ServerConfigRepository(),tag: tag);
}

  @override
  ServerConfigRepository get repository => Get.find(tag: tag);

  /// Data ********************************************************************
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? url = pref.serverUrl;
  String? error;
  Color btnColor = kGreyD1;
  ServerConfig? serverConfig;
  ServerHealth? serverHealth;
  var urlStatus = URLStatus.idle.obs;

  /// LifeCycle ********************************************************************

  @override
  void onResume() {
    if(pref.serverConfig != null && pref.serverUrl != null && !splashLoaded){
      Get.offNamed(Routes.splash,arguments: pref.serverConfig);
    }
  }

  /// Listeners ****************************************************************
  void onURLChanged(String? input)async{
    urlStatus = URLStatus.loading.obs;
    update();
    await Future.delayed(Duration(milliseconds: 500));
    if(input == null || input.isEmpty){
      error = null;
      urlStatus.value = URLStatus.idle;
      update();
      return;
    }
    error = ValidationUtil.validateUrl(input);
    urlStatus.value = error == null ? URLStatus.valid : URLStatus.invalid;
    url = input;
    update();
  }

  void onSave() {
    if(urlStatus.value != URLStatus.valid || !(formKey.currentState?.validate() ?? false)) return;
      formKey.currentState!.save();
      loading.value = true;
      _checkHealth();

  }

  /// Logic ********************************************************************
  void _saveData() {
    pref.serverConfig = serverConfig;
    pref.serverUrl = url;
    update();
    navigateTo();
  }

  void navigateTo(){
   if(!splashLoaded) Get.offNamed(Routes.splash,arguments: pref.serverConfig);
  Get.back();
  }

  void _responseCheckHealth(Resource resource) {
    if(resource.isError()) {
      error = resource.errorData?.message;
      update();
      stopLoading();
      return;
    }
    showSuccessMessage('${resource.successMessage!}.... ${'getting_server_data'.tr}');
    serverHealth = resource.data;
    update();
     fetchServerConfig();
  }

  void _responseServerConfig(Resource resource) {
    stopLoading();
    if(resource.isError()) return;
    serverConfig = resource.data;
    update();
    _saveData();
  }

  /// Api & requests ********************************************************************
  Future<void> _checkHealth() async {
    if(url == null) {
      stopLoading();
      return;
    }
    var resource = await repository.checkHealth(serverUrl: url!);
    _responseCheckHealth(resource);
  }

  Future<void> fetchServerConfig() async {
    var resource = await repository.fetchServerConfig();
    _responseServerConfig(resource);
  }
}

enum URLStatus{
  idle,
  loading,
  valid,
  invalid,
}
