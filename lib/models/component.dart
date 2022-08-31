import 'package:nam_ip_museum/functions.dart';
import 'package:nam_ip_museum/models/type_component.dart';

class Component {
  late int id;
  late String name;
  late String descFr;
  late String descEn;
  late String descNL;
  late String descMotFr;
  late String descMotEn;
  late String descMotNL;
  late String logo;
  late int date;
  late TypeComponent type;

  Component({required this.id, required this.name, required this.descFr, required this.descEn, required this.descNL,
    required this.logo, required this.date, required this.type});

  Component.fromMap(Map map) {
    id = map["ID"];
    name = map["Nom"];
    descFr = map["DescFR"];
    descEn = map["DescEN"];
    descNL = map["DescNL"] ?? "";
    descMotFr = map["DescMotFR"] ?? "";
    descMotEn = map["DescMotEN"] ?? "";
    descMotNL = map["DescMotNL"] ?? "";
    logo = map["logo"];
    date = map["Annee"];
    type = convertStringToTypeComponent(map["TYPE"]);
  }

  @override
  String toString() {
    return '$name, ${Functions.getStringLang(fr: descFr, en: descEn, nl: descNL)}';
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
      case 'error':

      default:
        return TypeComponent.error;
    }
  }
}