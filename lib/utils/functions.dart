import 'package:get/get.dart';

import '../models/component.dart';

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

  static String getDescComponent({required Component component}) {
    if (Get.locale?.languageCode == 'fr') {
      return component.descFr;
    } else if (Get.locale?.languageCode == 'nl') {
      return component.descNL;
    } else {
      return component.descEn;
    }
  }
}