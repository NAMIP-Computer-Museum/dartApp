import 'package:flutter/cupertino.dart';

class FormQuestion {

  int id;
  String question;
  int type;
  bool isForce;
  dynamic value;
  List? params;
  String? min;
  String? max;
  TextEditingController? controllerForOtherInType2;

  FormQuestion({
    required this.id,
    required this.question,
    required this.type,
    required this.isForce,
    required this.value,
    this.params,
    this.min,
    this.max,
  }) : assert(type != 2 || params != null),
       assert(type != 5 || (params != null && min != null && max != null));

  String? answer() {
    switch (type) {
      case 0:
      case 1:
        TextEditingController controller = value as TextEditingController;
        return controller.text;
      case 2:
        return value == "" ? controllerForOtherInType2?.text : value;
      case 5:
        return value;
      default:
        print("error");
        return '';
    }
  }

  void dispose() {
    switch (type) {
      case 0:
      case 1:
        TextEditingController controller = value as TextEditingController;
        controller.dispose();
        break;
      case 2:
        controllerForOtherInType2?.dispose();
        break;
      case 5:
        break;
      default:
        print("error");
    }
  }
}