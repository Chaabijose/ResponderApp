import 'package:get/get.dart';
import 'package:responder_app/screens/auth/auth_bindings.dart';
import 'package:responder_app/screens/auth/auth_screen.dart';
import 'package:responder_app/screens/auth/register_unit/register_unit_bindings.dart';
import 'package:responder_app/screens/auth/register_unit/register_unit_screen.dart';
import 'package:responder_app/screens/home/home_bindings.dart';
import 'package:responder_app/screens/home/home_screen.dart';
import 'package:responder_app/screens/my_unit/my_unit_bindings.dart';
import 'package:responder_app/screens/my_unit/my_unit_screen.dart';
import 'package:responder_app/screens/settings/settings_bindings.dart';
import 'package:responder_app/screens/settings/settings_screen.dart';
import '../screens/auth/server_config/server_config_bindings.dart';
import '../screens/auth/server_config/server_config_screen.dart';
import '../screens/coming_soon/coming_soon.dart';
import '../screens/image_viewer/image_viewer.dart';
import '../screens/onboarding/onboarding_bindings.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/splash/splash_bindings.dart';
import '../screens/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.serverConfig;

  static final routes = <GetPage>[
    /// Default *******************
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: Routes.onBoarding,
      page: () => OnBoardingScreen(),
      binding: OnBoardingBindings(),
    ),
    GetPage(
      name: Routes.auth,
      page: () => AuthScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: Routes.serverConfig,
      page: () => ServerConfigScreen(),
      binding: ServerConfigBindings(),
    ),
    GetPage(
      name: Routes.registerUnit,
      page: () => RegisterUnitScreen(),
      binding: RegisterUnitBindings(),
    ),
    GetPage(
      name: Routes.imageViewer,
      page: () => const ImageViewer(),
    ),
    GetPage(
      name: Routes.comingSoon,
      page: () =>  ComingSoon(),
    ),
    GetPage(
      name: Routes.home,
      page: () =>  HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.myUnit,
      page: () =>  MyUnitScreen(),
      binding: MyUnitBindings(),
    ),
    GetPage(
      name: Routes.settings,
      page: () =>  SettingsScreen(),
      binding: SettingsBindings(),
    ),
  ];
}
