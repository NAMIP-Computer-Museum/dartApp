import 'package:nam_ip_museum/models/type_component.dart';

class Component {
  late int id;
  late String name;
  late String descFr;
  late String descEn;
  late String descNL;
  late String logo;
  late int date;
  late typeComponent type;

  Component({required this.id, required this.name, required this.descFr, required this.descEn, required this.descNL,
    required this.logo, required this.date, required this.type});

  Component.fromMap(Map map) {
    id = map["ID"];
    name = map["Nom"];
    descFr = map["DescFR"];
    descEn = map["DescEN"];
    descNL = map["DescNL"];
    logo = map["logo"];
    date = map["Annee"];
    type = convertStringToTypeComponent(map["TYPE"]);
  }

  static typeComponent convertStringToTypeComponent(String type) {
    switch (type.toLowerCase()) {
      case 'micro':
        return typeComponent.micro;
      case 'os':
        return typeComponent.os;
      case 'cpu':
        return typeComponent.cpu;
      case 'ihm':
        return typeComponent.ihm;
      case 'app':
        return typeComponent.app;
      default:
        return typeComponent.error;
    }
  }
}