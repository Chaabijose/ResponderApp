import 'package:get/get.dart';
import 'package:responder_app/models/server_config.dart';

import '../../main.dart';
import '../../base/base_controller.dart';
import '../../models/api/resource.dart';
import '../../navigation/app_routes.dart';
import 'splash_repository.dart';

bool splashLoaded = false;

class SplashController extends BaseController<SplashRepository>
    with GetSingleTickerProviderStateMixin {
  @override
  SplashRepository get repository => Get.find(tag: tag);

  /// Data *********************************************************************
  var logoOpacity = 0.0.obs; //widget opacity observable
  Worker? _worker;
  ServerConfig? serverConfig = Get.arguments ?? pref.serverConfig;

  /// Lifecycle methods ********************************************************
 @override
  void onCreate() {
   fetchServerConfig();
  }

  @override
  onResume() {
    pref.tookUserGuide = true;
    _startTimer();
    logoOpacity.value += 1;
  }

  @override
  onDestroy() {
    _worker?.dispose();
  }

  /// Logic ********************************************************************

  //Wait 2 seconds then navigate to next page
  void _startTimer() {
    _worker = debounce(logoOpacity, (_) => finishSplash(),
        time: const Duration(seconds: 2));
  }

  Future<void> finishSplash() async {
    _navigateTo();
  }

  void _navigateTo() {
   splashLoaded = true;
    if (isLoggedIn()) {
      // if user not select previous unit
      if(pref.myUnit == null){
        Get.offAllNamed(Routes.registerUnit,arguments: pref.user);
        return;
      }
      Get.offAllNamed(Routes.home);
      return;
    }

    if(pref.serverUrl != null) {
      Get.offAllNamed(Routes.auth);
      return;
    }

  }

  void _responseServerConfig(Resource resource) {
    stopLoading();
    if(resource.isError()) return;
    serverConfig = resource.data;
    pref.serverConfig = serverConfig;
    update();
  }

  /// Api & requests ********************************************************************
  Future<void> fetchServerConfig() async {
    var resource = await repository.fetchServerConfig();
    _responseServerConfig(resource);
  }
}
