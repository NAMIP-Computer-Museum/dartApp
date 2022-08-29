import 'package:get/get.dart';

class Functions {

  static String getStringLang({required String fr, required String en, required String nl}) {
    if (Get.locale?.languageCode == 'fr') {
      return fr;
    } else if (Get.locale?.languageCode == 'nl') {
      return nl;
    } else {
      return en;
    }
  }
}