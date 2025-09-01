import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responder_app/utils/constants.dart';
import 'di/initial_bindings.dart';
import 'local/localization_service.dart';
import 'navigation/app_pages.dart';
import 'theme/app_themes.dart';
import 'theme/theme_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

int kNumOfNav = 0;
var navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Constants.designSizeMinWidth, Constants.designSizeMinHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      enableScaleWH: ()=>true,
      enableScaleText: ()=>true,
      fontSizeResolver: FontSizeResolvers.height,
      rebuildFactor: RebuildFactors.orientation,
      builder: (_, __) => GetBuilder<ThemeController>(
        init: ThemeController(),
        builder: (themeController) => GetMaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ar')],
          title: LocalizationService.isRtl() ? 'المستجيب الاول' : 'First Responder',
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: themeController.themeMode,
          locale: LocalizationService.getCurrentLocale(),
          fallbackLocale: LocalizationService.fallbackLocale,
          home: null,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          initialBinding: InitialBindings(),
          translations: LocalizationService(),
          routingCallback: (Routing? route) => route == null ||
              route.isBlank! ||
              route.isBottomSheet! ||
              route.isDialog!
              ? kNumOfNav
              : route.isBack!
              ? kNumOfNav--
              : kNumOfNav++,
        ),
      ),
    );
  }
}
