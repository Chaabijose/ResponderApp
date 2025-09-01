import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_controller.dart';
import 'package:responder_app/local/localization_service.dart';
import 'package:responder_app/models/local_enums.dart';
import 'package:responder_app/screens/settings/settings_repository.dart';

import '../../models/map_layers.dart';
import '../../models/map_styles.dart';
import '../../theme/app_images.dart';
import '../../utils/api_constatnts.dart';

class SettingsController extends BaseController<SettingsRepository>{
  @override
  SettingsRepository get repository => Get.find(tag:tag);

  /// Data ********************************************************
  SettingsEnum? selectedSetting ;
  ThemeEnum? selectedTheme =  ThemeEnum.dark;
  LanguageEnum selectedLanguage = LocalizationService.isRtl() ? LanguageEnum.arabic : LanguageEnum.english;
  MapStyleView selectedView = MapStyleView.myUnit;
  var styles = [
    MapStyles(image: AppImages.roadMap,url: ApiConstants.roadMap,name: 'Road Map'),
    MapStyles(image: AppImages.satelliteMap,url: ApiConstants.satelliteMap,name: 'Satellite Map'),
    MapStyles(image: AppImages.terrainMap,url: ApiConstants.terrainMap,name: 'Terrain Map'),
    MapStyles(image: AppImages.riyadhMap,url: ApiConstants.riyadhMap,name:'Riyadh Map'),
  ];
  MapStyles? selectedStyle = Get.arguments;
  var layers = [
    MapLayers(name: 'Show unit IDs',icon: Icons.tag,isEnabled: false),
  ];
  var gestureEnabled = false.obs;
  /// Lifecycle ********************************************************

  /// Listeners ********************************************************
  void onSelectSetting(SettingsEnum value){
    selectedSetting = value;
    update();
  }

  void clearSelectedSettings(){
    selectedSetting = null;
    update();
  }

  void onChangeLanuage(LanguageEnum value){
    selectedLanguage = value;
    update();
  }
  void onChangeTheme(ThemeEnum value){
    selectedTheme = value;
    update();
  }
  void onChangeMapView(MapStyleView view){
    selectedView = view;
    update();
  }

  void onChangeStyle(MapStyles item){
    selectedStyle = item;
    update();
  }


  void onShowUnit(bool? value,MapLayers item,){
    layers.firstWhere((layer) => layer == item).isEnabled = value;
    showSuccessMessage('${item.name} ${value != null && value ? 'enabled'.tr : 'disabled'.tr}');
    update();
  }

  void onChangeGesture(bool? value){
    gestureEnabled.value = value??false;
    update();
  }

/// Logic ********************************************************
  /// Api & Requests ********************************************************

}