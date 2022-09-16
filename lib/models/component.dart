import 'package:nam_ip_museum/models/perma_period.dart';
import 'package:nam_ip_museum/models/type_component.dart';

import '../functions.dart';

class Component {
  int id;
  String name;
  String descFr;
  String descEn;
  String descNL;
  String descMotFr;
  String descMotEn;
  String descMotNL;
  String logo;
  int date;
  TypeComponent type;
  PermaPeriod? period;

  Component.fromMap(Map map) :
    id = map["ID"],
    name = map["Nom"],
    descFr = map["DescFR"],
    descEn = map["DescEN"],
    descNL = map["DescNL"] ?? "",
    descMotFr = map["DescMotFR"] ?? "",
    descMotEn = map["DescMotEN"] ?? "",
    descMotNL = map["DescMotNL"] ?? "",
    logo = map["logo"],
    date = map["Annee"],
    type = convertStringToTypeComponent(map["TYPE"]),
    period = convertStringToPermaPeriod(map["PERIODE"]);


  @override
  String toString() {
    return '$name, ${Functions.getStringLang(fr: descFr, en: descEn, nl: descNL)}'; // TODO à voir
  }

  static TypeComponent convertStringToTypeComponent(String type) {
    switch (type.toLowerCase()) {
      case 'micro':
        return TypeComponent.micro;
      case 'os':
        return TypeComponent.os;
      case 'cpu':
        return TypeComponent.cpu;
      case 'ihm':
        return TypeComponent.ihm;
      case 'app':
        return TypeComponent.app;
      case 'machine':
        return TypeComponent.machine;
      case 'org':
        return TypeComponent.org;
      case 'event':
        return TypeComponent.event;
      case 'error':

      default:
        return TypeComponent.error;
    }
  }

  static PermaPeriod? convertStringToPermaPeriod(String? period) {
    switch (period?.toLowerCase()) {
      case 'micro':
        return PermaPeriod.micro;
      case 'meca':
        return PermaPeriod.meca;
      case 'mainframe':
        return PermaPeriod.mainframe;
      case 'mini':
        return PermaPeriod.mini;
      case 'moderne':
        return PermaPeriod.moderne;
      default:
        return null;
    }
  }
}