import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responder_app/base/base_controller.dart';
import 'package:responder_app/base/base_repository.dart';
import 'package:responder_app/models/map_styles.dart';
import 'package:responder_app/theme/app_images.dart';
import 'package:responder_app/utils/api_constatnts.dart';

import '../../models/map_layers.dart';

class MapStyleController extends BaseController{
  @override
  BaseRepository? get repository => null;
  var styles = [
    MapStyles(image: AppImages.roadMap,url: ApiConstants.roadMap,name: 'Road Map'),
    MapStyles(image: AppImages.satelliteMap,url: ApiConstants.satelliteMap,name: 'Satellite Map'),
    MapStyles(image: AppImages.terrainMap,url: ApiConstants.terrainMap,name: 'Terrain Map'),
    MapStyles(image: AppImages.riyadhMap,url: ApiConstants.riyadhMap,name:'Riyadh Map'),
  ];

  MapStyles? selectedStyle = Get.arguments;
  var layers = [
    MapLayers(name: 'Show unit IDs',icon: Icons.tag,isEnabled: false),
    MapLayers(name: 'Fire Hydrants',icon: Icons.fire_hydrant_alt,isEnabled: false),
    MapLayers(name: 'Hospitals',icon: Icons.local_hospital,isEnabled: false),
    MapLayers(name: 'Hazard Zones',icon: Icons.warning,isEnabled: false),
    MapLayers(name: 'Police Stations',icon: Icons.local_police,isEnabled: false),
  ];

  @override
  onCreate() {
    // selectedStyle ??= styles.first;
  }


  void onChangeStyle(MapStyles item){
    selectedStyle = item;
    update();
  }

  void onChangeLayer(bool? value,MapLayers item,){
    layers.firstWhere((layer) => layer == item).isEnabled = value;
    update();
  }

}
