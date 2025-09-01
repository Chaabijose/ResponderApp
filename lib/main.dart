import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'db/app_pref.dart';
import 'environment/flavor_config.dart';
import 'theme/app_themes.dart';

/// Global Vars ******************************
var pref = Get.put(AppPreferences());

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// Start Main ********************************
void main() {
  FlavorConfig.appFlavor = Flavor.dev; //set flavor to development
  initApp();
}

/// init app
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await FlavorConfig.init();

  await pref.init(); // init GetStorage.
  initFonts();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set status bar color to transparent
      statusBarIconBrightness: Brightness.dark, // Default to dark, will be updated by theme controller
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  /// run app
  runApp(const App());
}
