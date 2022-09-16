import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/db_helper.dart';
import 'package:nam_ip_museum/models/perma_period.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../models/component.dart';
import '../models/type_component.dart';
import '../components_details/datasheet.dart';
import '../widgets.dart';

class TimelinePerma extends StatefulWidget {
  const TimelinePerma({Key? key}) : super(key: key);

  @override
  State<TimelinePerma> createState() => _TimelineState2();
}

class _TimelineState2 extends State<TimelinePerma> {

  String _dropdownValue = 'Frise Entière';
  bool isChecked = false;
  bool isCheckedMachine = true;
  bool isCheckedORG = false;
  bool isCheckedEvent = false;

  List<Component> components = List.empty(growable: true);
  List<Component> componentsSelected = List.empty();

  @override
  void initState() {
    readData();
    super.initState();
  }

  void setComponentsSelected() {
    componentsSelected = List<Component>.from(components);
    if (!isCheckedMachine) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.machine).toList();
    }
    if (!isCheckedORG) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.org).toList();
    }
    if (!isCheckedEvent) {
      componentsSelected = componentsSelected.where((element) => element.type != TypeComponent.event).toList();
    }
    switch (_dropdownValue.toLowerCase()) { // TODO
      case 'micro':
        componentsSelected = componentsSelected.where((element) => (element.date) < 9999).toList();
        break;
      case 'meca':
        componentsSelected = componentsSelected.where((element) => (element.date) >= 1973 && (element.date) < 1977).toList();
        break;
      case 'mainframe':
        componentsSelected = componentsSelected.where((element) => (element.date) >= 1977 && (element.date) < 1992).toList();
        break;
      case 'mini':
        componentsSelected = componentsSelected.where((element) => (element.date) >= 1992).toList();
        break;
      case 'moderne':
        break;
    }
  }

  Future<void> readData() async {
    DBHelper dbHelper = DBHelper();
    components = await dbHelper.getComponentsPerma();
    setState(() {
      components.sort((a, b) => a.date.compareTo(b.date));
      componentsSelected = components.where((element) => element.type == TypeComponent.machine).toList();
    });
  }

  Widget timelineTile(Component component, bool isFirst, bool isLast) {
    Color color; // TODO
    switch (component.period) {
      case PermaPeriod.micro:
        color = Colors.blueAccent;
        break;
      case PermaPeriod.meca:
        color = Colors.green;
        break;
      case PermaPeriod.mainframe:
        color = Colors.pinkAccent;
        break;
      case PermaPeriod.mini:
        color = Colors.orange;
        break;
      case PermaPeriod.moderne:
        color = Colors.orange;
        break;
      default:
        color = Colors.transparent;
        break;
    }
    return TimelineTile(
        axis: TimelineAxis.vertical,
        alignment: TimelineAlign.manual,
        lineXY: 0.2,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: color,
        ),
        indicatorStyle: IndicatorStyle(
          indicatorXY: 0.0,
          color: color,
        ),
        startChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: double.infinity,
              child: Text(component.date.toString(), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold))),
        ),
        endChild: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component)));
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
                            child: Text(component.descFr, style: const TextStyle(fontSize: 14, color: Colors.white), maxLines: 4, overflow: TextOverflow.ellipsis)
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
                          value: 'Micro',
                          child: Text('micro'.tr, style: const TextStyle(color: Colors.indigo)),
                        ),
                        DropdownMenuItem(
                          value: 'Meca',
                          child: Text('meca'.tr, style: const TextStyle(color: Colors.green)),
                        ),
                        DropdownMenuItem(
                          value: 'Mainframe',
                          child: Text('mainframe'.tr, style: const TextStyle(color: Colors.pink)),
                        ),
                        DropdownMenuItem(
                          value: 'Mini',
                          child: Text('mini'.tr, style: const TextStyle(color: Colors.orange)),
                        ),
                        DropdownMenuItem(
                          value: 'Moderne',
                          child: Text('moderne'.tr, style: const TextStyle(color: Colors.orange)),
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
                                value: isCheckedMachine,
                                checkColor: Colors.red,
                                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedMachine = value!;
                                    setComponentsSelected();
                                  });
                                },
                              ),
                              const Text("MACHINE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: isCheckedORG,
                                checkColor: Colors.red,
                                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedORG = value!;
                                    setComponentsSelected();
                                  });
                                },
                              ),
                              const Text("ORG", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: isCheckedEvent,
                                checkColor: Colors.red,
                                fillColor: MaterialStateProperty.all<Color>(Colors.white),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedEvent = value!;
                                    setComponentsSelected();
                                  });
                                },
                              ),
                              const Text("EVENT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
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
                          String desc;
                          switch (Get.locale?.languageCode) {
                            case 'fr':
                              desc = e.descFr;
                              break;
                            case 'nl':
                              desc = e.descNL;
                              break;
                            default:
                              desc = e.descEn;
                              break;
                          }
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
