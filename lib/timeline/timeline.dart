import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/component.dart';
import '../models/type_component.dart';
import 'datasheet.dart';

class MyTimeline extends StatefulWidget {
  const MyTimeline({Key? key}) : super(key: key);

  @override
  State<MyTimeline> createState() => _TimelineState2();
}

class _TimelineState2 extends State<MyTimeline> {

  String _dropdownValue = 'Frise Entière';
  bool isChecked = false;
  bool isCheckedMicro = true;
  bool isCheckedOS = false;
  bool isCheckedCPU = false;
  bool isCheckedIHM = false;
  bool isCheckedApp = false;

  final List<Component> components = List.empty(growable: true);
  List<Component> componentsSelected = List.empty();

  @override
  void initState() {
    readData();
    super.initState();
  }

  void setComponentsSelected() {
    componentsSelected = List<Component>.from(components);
    if (!isCheckedMicro) {
      componentsSelected = componentsSelected.where((element) => element.type != typeComponent.micro).toList();
    }
    if (!isCheckedOS) {
      componentsSelected = componentsSelected.where((element) => element.type != typeComponent.os).toList();
    }
    if (!isCheckedCPU) {
      componentsSelected = componentsSelected.where((element) => element.type != typeComponent.cpu).toList();
    }
    if (!isCheckedIHM) {
      componentsSelected = componentsSelected.where((element) => element.type != typeComponent.ihm).toList();
    }
    if (!isCheckedApp) {
      componentsSelected = componentsSelected.where((element) => element.type != typeComponent.app).toList();
    }
    switch (_dropdownValue.toLowerCase()) {
      case 'début':
        componentsSelected = componentsSelected.where((element) => int.parse(element.date) < 1973).toList();
        break;
      case 'phase 1':
        componentsSelected = componentsSelected.where((element) => int.parse(element.date) >= 1973 && int.parse(element.date) < 1977).toList();
        break;
      case 'phase 2':
        componentsSelected = componentsSelected.where((element) => int.parse(element.date) >= 1977 && int.parse(element.date) < 1992).toList();
        break;
      case 'phase 3':
        componentsSelected = componentsSelected.where((element) => int.parse(element.date) >= 1992).toList();
        break;
    }
  }

  Future<void> readData() async {
    final String response = await rootBundle.loadString("data/componentsData.json");
    final List<dynamic> data = await json.decode(response);
    setState(() {
      for (int i = 0; i < data.length; i++) {
        components.add(Component(
          name: data[i]['name'],
          desc: data[i]['desc'],
          logo: data[i]['img'],
          date: data[i]['date'],
          type: Component.convertStringToTypeComponent(data[i]['type']),
        ));
      }
      components.sort((a, b) => a.date.compareTo(b.date));
      componentsSelected = components.where((element) => element.type == typeComponent.micro).toList();
    });
  }

  Widget timelineTile(String title, String description, String icon, String date, bool isFirst, bool isLast) {
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
        color: getIndicatorColor(int.parse(date)),
      ),
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0.0,
        color: getIndicatorColor(int.parse(date)),
      ),
      startChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.infinity,
          child: Text(date, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      endChild: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Datasheet(
            img: icon,
            title: title,
            description: description,
          )));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  !isChecked ? Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(icon),
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(description, style: const TextStyle(fontSize: 14, color: Colors.white), maxLines: 4, overflow: TextOverflow.ellipsis)
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
      appBar: AppBar(
        title: const Text('NAM IP Museum'),
        backgroundColor: Colors.red.shade900,
      ),
      body: Container(
        color: Colors.red.shade700,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
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
                    items: [ // TODO couleur à changer surement
                      DropdownMenuItem(
                        child: Text('friseEntiere'.tr, style: const TextStyle(color: Colors.black)),
                        value: 'Frise Entière',
                      ),
                      DropdownMenuItem(
                        child: Text('debut'.tr, style: const TextStyle(color: Colors.indigo)),
                        value: 'Début',
                      ),
                      DropdownMenuItem(
                        child: Text('phase1'.tr, style: const TextStyle(color: Colors.green)),
                        value: 'Phase 1',
                      ),
                      DropdownMenuItem(
                        child: Text('phase2'.tr, style: const TextStyle(color: Colors.pink)),
                        value: 'Phase 2',
                      ),
                      DropdownMenuItem(
                        child: Text('phase3'.tr, style: const TextStyle(color: Colors.orange)),
                        value: 'Phase 3',
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                  left: BorderSide(color: Colors.white, width: 2),
                  right: BorderSide(color: Colors.white, width: 2),
                ),
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
                    child: Column(
                      children: componentsSelected.map((e) {
                        return timelineTile(e.name, e.desc, e.logo, e.date, componentsSelected.indexOf(e) == 0, componentsSelected.indexOf(e) == componentsSelected.length - 1);
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
