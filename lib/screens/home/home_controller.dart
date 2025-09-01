import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responder_app/base/base_map_controller.dart';
import 'package:responder_app/models/api/resource.dart';
import 'package:responder_app/models/args/args_coming_soon.dart';
import 'package:responder_app/models/map_styles.dart';
import 'package:responder_app/models/status.dart';
import 'package:responder_app/models/user.dart';
import 'package:responder_app/navigation/app_routes.dart';
import 'package:responder_app/screens/home/home_repository.dart';
import 'package:responder_app/screens/home/widgets/logout_dialog.dart';
import 'package:responder_app/sheets/availability/availability_sheet.dart';
import 'package:responder_app/sheets/map_style/map_style_sheet.dart';
import 'package:responder_app/theme/app_colors.dart';
import 'package:responder_app/theme/app_images.dart';
import 'package:responder_app/theme/theme_controller.dart';
import 'package:responder_app/screens/home/unit_danger/danger_activation_dialog.dart';
import 'package:responder_app/screens/home/unit_danger/danger_cancellation_dialog.dart';
import '../../main.dart';
import '../../models/local_enums.dart';
import '../../sheets/unit_info_sheet.dart';
import '../../utils/api_constatnts.dart';

class HomeController extends BaseGoogleMapController<HomeRepository>{
  @override
  HomeRepository get repository => Get.find(tag: tag);


  /// Data ***************************************************************************************
  Status currentStatus = Status(title: 'Available',body: 'Ready for assignment',color: kAccent,icon: Icons.check_box_rounded);
  var showDrawer = false.obs;
  var showNotification = false.obs;
  var showProfile = false.obs;
  PackageInfo? packageInfo ;

  String? version ;
  String? buildNumber ;
  MapStyles selectedStyle = MapStyles(image: AppImages.roadMap,url: ApiConstants.roadMap,name: 'Road Map');
  MapStyleView selectedView = MapStyleView.myUnit;

  // Get theme controller instance
  ThemeController get themeController => ThemeController.instance;

  var isUnitInDanger = false.obs;
  var dangerActivationTime = ''.obs;

  User? user = pref.user;
  /// LifeCycle ***************************************************************************************
  @override
  onCreate() async{
    super.onCreate();
    _fetchUserData();
    packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo?.version;
    buildNumber = packageInfo?.buildNumber;
    update();
  }

  /// Listeners ***************************************************************************************
  void onlogout() {
   Get.dialog(LogoutDialog(onOk: ()async{
     await _logout();
   },));
  }


  void onUnitInfo() {
    Get.bottomSheet(UnitInfoSheet(status: currentStatus,),
        clipBehavior: Clip.antiAlias,
        enterBottomSheetDuration: Duration(milliseconds: 300),);
  }

   Future<void> onAvailability()async{
    var res = await Get.bottomSheet(AvailabilitySheet(status: currentStatus,),isDismissible: false,enableDrag: false,
      clipBehavior: Clip.antiAlias,
      enterBottomSheetDuration: Duration(milliseconds: 300),);
    if(res == null) return;
    currentStatus = res;
    update();
  }

  Future<void> onMapStyle()async{
    var res = await Get.bottomSheet(MapStyleSheet(),isDismissible: false,enableDrag: false,
      clipBehavior: Clip.antiAlias,
      enterBottomSheetDuration: Duration(milliseconds: 300),settings: RouteSettings(arguments: selectedStyle));
    if(res == null) return;
    selectedStyle = res;
    // onMapCreated(mapController!);
    update();
  }

  void onShowHideDrawer(){
    showDrawer.value = !showDrawer.value;
    update();
  }

  void onShowHideNotification(){
    showNotification.value = !showNotification.value;
    update();
  }

  void onShowHideProfile(bool value){
    showProfile.value = value;
    update();
  }

  void onCloseDrawer(){
    showDrawer.value = false;
    update();
  }

  void onCloseNotification(){
    showNotification.value = false;
    update();
  }

  void onChangeMapView(MapStyleView view){
    selectedView = view;
    update();
  }

  void onChangeTheme(ThemeEnum theme){
    themeController.changeTheme(theme);
    update();
  }

  void onUnitProfile({MyUnitEnum? enumData})=> Get.toNamed(Routes.myUnit,arguments: enumData);
  void onInquiry()=> Get.toNamed(Routes.comingSoon,arguments: ArgsComingSoon(screenTitle: 'inquiry'));
  void onBroadcasts()=>Get.toNamed(Routes.comingSoon,arguments: ArgsComingSoon(screenTitle: 'broadcasts'));
  void onMessages()=> Get.toNamed(Routes.comingSoon,arguments: ArgsComingSoon(screenTitle: 'messages'));
  void onSettings()=> Get.toNamed(Routes.settings,);
  void onHelp()=>Get.toNamed(Routes.comingSoon,arguments: ArgsComingSoon(screenTitle: 'help'));

  Future<void> onShowUnitDangerDialog() async {
    // Add haptic feedback for emergency gesture
    HapticFeedback.heavyImpact();

    var result = await Get.dialog(DangerActivationDialog());
    if (result == null) return;
    isUnitInDanger.value = result;
    update();
  }

  Future<void> onCancelSos()async{
    var result = await Get.dialog(DangerCancellationDialog());
    if (result == null) return;
    isUnitInDanger.value = result;
    update();
  }

  void _responseUserData(Resource resource){
    stopLoading();
    if(resource.isError())return;
    user = resource.data;
    pref.user = user;
    update();
  }

/// Api & requests ***************************************************************************************
  Future<void> _logout() async {
    var resource = await repository.logout();
    if(resource.isError())return;
    doLogout();
  }
  
  Future<void> _fetchUserData() async {
    var resource = await repository.getUserInfo();
    _responseUserData(resource);
  }

}


