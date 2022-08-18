import 'package:nam_ip_museum/models/type_component.dart';

class Component {
  String name;
  String desc;
  String logo;
  String date;
  typeComponent type;

  Component({required this.name, required this.desc, required this.logo, required this.date, required this.type});

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