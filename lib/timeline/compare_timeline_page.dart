import 'package:flutter/material.dart';
import 'package:nam_ip_museum/timeline/compare_timeline.dart';
import 'package:nam_ip_museum/widgets.dart';

import '../db_helper.dart';
import '../models/component.dart';
import '../models/type_component.dart';

class CompareTimelinePage extends StatefulWidget {
  const CompareTimelinePage({Key? key}) : super(key: key);

  @override
  State<CompareTimelinePage> createState() => _CompareTimelinePageState();
}

class _CompareTimelinePageState extends State<CompareTimelinePage> {

  bool isCheckedMicro1 = true;
  bool isCheckedOS1 = false;
  bool isCheckedCPU1 = false;
  bool isCheckedIHM1 = false;
  bool isCheckedApp1 = false;

  bool isCheckedMicro2 = true;
  bool isCheckedOS2 = false;
  bool isCheckedCPU2 = false;
  bool isCheckedIHM2 = false;
  bool isCheckedApp2 = false;

  List<Component> components = List.empty(growable: true);
  List<Component> componentsSelected1 = List.empty();
  List<Component> componentsSelected2 = List.empty();

  Future<void> readData() async {
    DBHelper dbHelper = DBHelper();
    components = await dbHelper.getComponentsMicro();
    setState(() {
      components.sort((a, b) => a.date.compareTo(b.date));
      componentsSelected1 = components.where((element) => element.type == TypeComponent.micro).toList();
      componentsSelected2 = components.where((element) => element.type == TypeComponent.micro).toList();
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Column(
        children: [
          Container(
            color: Colors.red.shade700,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.white, width: 2),
                        right: BorderSide(color: Colors.white, width: 2),
                        bottom: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            checkbox('MICRO', 0, 1),
                            checkbox('OS', 1, 1),
                          ],
                        ),
                        Row(
                          children: [
                            checkbox('CPU', 2, 1),
                            checkbox('IHM', 3, 1),
                            checkbox('APP', 4, 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                        right: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            checkbox('MICRO', 5, 2),
                            checkbox('OS', 6, 2),
                          ],
                        ),
                        Row(
                          children: [
                            checkbox('CPU', 7, 2),
                            checkbox('IHM', 8, 2),
                            checkbox('APP', 9, 2),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Widgets.containerWithBinaryBackground(
              child: CompareTimeline(firstComponents: componentsSelected1, secondComponents: componentsSelected2,)
            )
          )
        ],
      ),
    );
  }

  Widget checkbox(String text, int value, int nb) {
    List<bool> checkboxValues = [isCheckedMicro1, isCheckedOS1, isCheckedCPU1, isCheckedIHM1, isCheckedApp1, isCheckedMicro2, isCheckedOS2, isCheckedCPU2, isCheckedIHM2, isCheckedApp2];
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: checkboxValues[value],
          checkColor: Colors.red,
          fillColor: MaterialStateProperty.all<Color>(Colors.white),
          onChanged: (bool? v) {
            setState(() {
              setCheckboxValue(value, v!);
              setComponentsSelected(nb);
            });
          },
        ),
        Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  void setCheckboxValue(int checkbox, bool value) {
    switch (checkbox) {
      case 0:
        isCheckedMicro1 = value;
        break;
      case 1:
        isCheckedOS1 = value;
        break;
      case 2:
        isCheckedCPU1 = value;
        break;
      case 3:
        isCheckedIHM1 = value;
        break;
      case 4:
        isCheckedApp1 = value;
        break;
      case 5:
        isCheckedMicro2 = value;
        break;
      case 6:
        isCheckedOS2 = value;
        break;
      case 7:
        isCheckedCPU2 = value;
        break;
      case 8:
        isCheckedIHM2 = value;
        break;
      case 9:
        isCheckedApp2 = value;
        break;
    }
  }

  void setComponentsSelected(int nb) {
    if (nb == 1) {
      componentsSelected1 = List<Component>.from(components);
      if (!isCheckedMicro1) {
        componentsSelected1 = componentsSelected1.where((element) => element.type != TypeComponent.micro).toList();
      }
      if (!isCheckedOS1) {
        componentsSelected1 = componentsSelected1.where((element) => element.type != TypeComponent.os).toList();
      }
      if (!isCheckedCPU1) {
        componentsSelected1 = componentsSelected1.where((element) => element.type != TypeComponent.cpu).toList();
      }
      if (!isCheckedIHM1) {
        componentsSelected1 = componentsSelected1.where((element) => element.type != TypeComponent.ihm).toList();
      }
      if (!isCheckedApp1) {
        componentsSelected1 = componentsSelected1.where((element) => element.type != TypeComponent.app).toList();
      }
    } else {
      componentsSelected2 = List<Component>.from(components);
      if (!isCheckedMicro2) {
        componentsSelected2 = componentsSelected2.where((element) => element.type != TypeComponent.micro).toList();
      }
      if (!isCheckedOS2) {
        componentsSelected2 = componentsSelected2.where((element) => element.type != TypeComponent.os).toList();
      }
      if (!isCheckedCPU2) {
        componentsSelected2 = componentsSelected2.where((element) => element.type != TypeComponent.cpu).toList();
      }
      if (!isCheckedIHM2) {
        componentsSelected2 = componentsSelected2.where((element) => element.type != TypeComponent.ihm).toList();
      }
      if (!isCheckedApp2) {
        componentsSelected2 = componentsSelected2.where((element) => element.type != TypeComponent.app).toList();
      }
    }
  }
}
