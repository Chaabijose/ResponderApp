import 'package:get/get.dart';

import '../../local/localization_service.dart';
import 'title_model.dart';

class Language{

  final String? en,ar;

  const Language({
    this.en,
    this.ar,
  });


  @override
  String toString() {
    return 'Language{en: $en, ar: $ar}';
  }

  String get value =>
      Get.locale?.languageCode == "ar" && ar != null ? ar ?? 'not_specified'.tr
          :Get.locale?.languageCode == "en" && en != null ? en ?? 'not_specified'.tr
          : LocalizationService.isRtl() ? ar ?? en ?? ar??'' : 'not_specified'.tr;

  factory Language.fromMap(Map<String, dynamic> map) {

    return Language(
      en: map['en'] ,
      ar: map['ar'] ,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}

class LanguageDropDown extends TitleModel{
  String name;
  String code;

  LanguageDropDown({
    required this.name,
    required this.code,
  });

  @override
  String get title => name;


}