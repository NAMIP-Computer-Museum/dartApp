import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/data/db_helper.dart';
import 'package:nam_ip_museum/utils/functions.dart';
import 'package:nam_ip_museum/utils/navigation_service.dart';
import 'package:nam_ip_museum/timeline/proportional_timeline.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/component.dart';
import '../models/type_component.dart';
import '../components_details/datasheet.dart';
import '../utils/widgets.dart';

class TimelineMicro extends StatefulWidget {
  const TimelineMicro({Key? key}) : super(key: key);

  @override
  State<TimelineMicro> createState() => _TimelineState();
}

class _TimelineState extends State<TimelineMicro> {

  String _dropdownValue = 'Frise Entière';
  bool isChecked = false;
  bool isCheckedMicro = true;
  bool isCheckedOS = false;
  bool isCheckedCPU = false;
  bool isCheckedIHM = false;
  bool isCheckedApp = false;

  List<Component> components = List.empty(growable: true);
  List<Component> componentsSelected = List.empty();

  @override
  void initState() {
    readData();
    super.initState();
  }

  void setComponentsSelected() {
    componentsSelected = List<Component>.from(components);
    if (!isCheckedMicro) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.micro).toList();
    }
    if (!isCheckedOS) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.os).toList();
    }
    if (!isCheckedCPU) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.cpu).toList();
    }
    if (!isCheckedIHM) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.ihm).toList();
    }
    if (!isCheckedApp) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.app).toList();
    }
    switch (_dropdownValue.toLowerCase()) {
      case 'début':
        componentsSelected = componentsSelected.where((element) => (element.date) < 1973).toList();
        break;
      case 'phase 1':
        componentsSelected = componentsSelected.where((element) => (element.date) >= 1973 && (element.date) < 1977).toList();
        break;
      case 'phase 2':
        componentsSelected = componentsSelected.where((element) => (element.date) >= 1977 && (element.date) < 1992).toList();
        break;
      case 'phase 3':
        componentsSelected = componentsSelected.where((element) => (element.date) >= 1992).toList();
        break;
    }
  }

  Future<void> readData() async {
    DBHelper dbHelper = DBHelper();
    components = await dbHelper.getComponentsMicro();
    setState(() {
      components.sort((a, b) => a.date.compareTo(b.date));
      componentsSelected = components.where((element) => element.type == TypeComponent.micro).toList();
    });
  }

  Widget timelineTile(Component component, bool isFirst, bool isLast) {
    Color getIndicatorColor(int date) {
      if (date < 1973) {
        return Colors.blue;
      } else if (date < 1977) {
        return Colors.green;
      } else if (date < 1992) {
        return Colors.pink;
      } else {
        return Colors.orangeAccent;
      }
    }
    return TimelineTile(
      axis: TimelineAxis.vertical,
      alignment: TimelineAlign.manual,
      lineXY: 0.2,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(
        color: getIndicatorColor((component.date)),
      ),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.0,
        color: getIndicatorColor((component.date)),
      ),
      startChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.infinity,
          child: Text(component.date.toString(), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      endChild: GestureDetector(
        onTap: () {
          Navigator.of(NavigationService.getContext()).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(component.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  !isChecked ? Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(component.logo),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(Functions.getStringLang(fr: component.descFr, en: component.descEn, nl: component.descNL), style: const TextStyle(fontSize: 14, color: Colors.white), maxLines: 4, overflow: TextOverflow.ellipsis)
                      ),
                    ],
                  ) : Container(),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(thickness: 2, color: Colors.grey),
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        color: Colors.red.shade700,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border.symmetric(vertical: BorderSide(color: Colors.white, width: 2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(
                    underline: Container(),
                    value: _dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue!;
                        setComponentsSelected();
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'Frise Entière',
                        child: Text('friseEntiere'.tr, style: const TextStyle(color: Colors.black)),
                      ),
                      DropdownMenuItem(
                        value: 'Début',
                        child: Text('debut'.tr, style: const TextStyle(color: Colors.indigo)),
                      ),
                      DropdownMenuItem(
                        value: 'Phase 1',
                        child: Text('phase1'.tr, style: const TextStyle(color: Colors.green)),
                      ),
                      DropdownMenuItem(
                        value: 'Phase 2',
                        child: Text('phase2'.tr, style: const TextStyle(color: Colors.pink)),
                      ),
                      DropdownMenuItem(
                        value: 'Phase 3',
                        child: Text('phase3'.tr, style: const TextStyle(color: Colors.orange)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      //CheckboxListTile()
                      Checkbox(
                        value: isChecked,
                        checkColor: Colors.red,
                        fillColor: MaterialStateProperty.all<Color>(Colors.white),
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("vueCompacte".tr, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: width,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: isCheckedMicro,
                              checkColor: Colors.red,
                              fillColor: MaterialStateProperty.all<Color>(Colors.white),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedMicro = value!;
                                  setComponentsSelected();
                                });
                              },
                            ),
                            const Text("MICRO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: isCheckedOS,
                              checkColor: Colors.red,
                              fillColor: MaterialStateProperty.all<Color>(Colors.white),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedOS = value!;
                                  setComponentsSelected();
                                });
                              },
                            ),
                            const Text("OS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: isCheckedCPU,
                              checkColor: Colors.red,
                              fillColor: MaterialStateProperty.all<Color>(Colors.white),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedCPU = value!;
                                  setComponentsSelected();
                                });
                              },
                            ),
                            const Text("CPU", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: isCheckedIHM,
                              checkColor: Colors.red,
                              fillColor: MaterialStateProperty.all<Color>(Colors.white),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedIHM = value!;
                                  setComponentsSelected();
                                });
                              },
                            ),
                            const Text("IHM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: isCheckedApp,
                              checkColor: Colors.red,
                              fillColor: MaterialStateProperty.all<Color>(Colors.white),
                              onChanged: (bool? value) {
                                setState(() {
                                  isCheckedApp = value!;
                                  setComponentsSelected();
                                });
                              },
                            ),
                            const Text("APP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/binaryBackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child:
                    Column(
                      children: componentsSelected.map((e) {
                        return timelineTile(e, componentsSelected.indexOf(e) == 0, componentsSelected.indexOf(e) == componentsSelected.length - 1);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
