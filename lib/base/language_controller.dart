import 'package:get/get.dart';
import 'package:responder_app/base/base_repository.dart';
import '../local/localization_service.dart';
import 'base_controller.dart';

abstract class LanguageController<T extends BaseRepository> extends BaseController<T>{

  ///Language ************************************************************
  late String currentLngCode = Get.locale?.languageCode ?? LocalizationService.fallbackLocale.languageCode;
  var languageChanged = false.obs;
  String get otherLanguageName => LocalizationService.isRtl()
      ? 'english'.tr
      : 'arabic'.tr;
  final List<String> options = LocalizationService.lngsTitles;

  Future<void> onLang(String key, ) async{
    changeLanguage(key);
  }
  void changeLanguage(String lngCode) {
    currentLngCode = lngCode;
    languageChanged.value = currentLngCode != Get.locale?.languageCode;
    _submitChangeLanguage();
  }

  Future<void> _submitChangeLanguage() async {
    if (!languageChanged.value) return;
    _updateLocaleLanguage();
  }

  void _updateLocaleLanguage() {
    LocalizationService().changeLocale(currentLngCode);
    Get.rootController.restartApp();
    languageChanged.value = false;
  }
}