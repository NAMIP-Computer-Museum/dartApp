import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/db_helper.dart';
import 'package:nam_ip_museum/models/type_component.dart';

import '../home_pages/home_page.dart';

class Datasheet extends StatefulWidget {
  final String img;
  final String title;
  final String description;
  final int id;
  final typeComponent type;

  const Datasheet({Key? key, required this.img, required this.title, required this.description, required this.id, required this.type}) : super(key: key);

  @override
  State<Datasheet> createState() => _DatasheetState();
}

class _DatasheetState extends State<Datasheet> {

  List<String> descTab = List.empty(growable: true);
  late final Map<String, Object?>? maps;

  @override
  void initState() {
    String descCopy = widget.description;
    while (descCopy.contains("MS-DOS")) {
      descTab.add(descCopy.substring(0, descCopy.indexOf("MS-DOS")));
      descCopy = descCopy.substring(descCopy.indexOf("MS-DOS") + 6);
      descTab.add("MS-DOS");
    }
    descTab.add(descCopy);

    readData();
    super.initState();
  }

  Future<void> readData() async {
    DBHelper dbHelper = DBHelper();
    maps = await dbHelper.getComponentData(widget.id, typeComponentToString(widget.type));
    print(maps);
  }

  String typeComponentToString(typeComponent type) {
    switch (type) {
      case typeComponent.micro:
        return 'MICRO';
      case typeComponent.os:
        return 'OS';
      case typeComponent.cpu:
        return 'CPU';
      case typeComponent.ihm:
        return 'IHM';
      case typeComponent.app:
        return 'APP';
      case typeComponent.error:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.red.shade600,
      appBar: AppBar(
        title: const Text('NAM IP Museum'),
        backgroundColor: Colors.red.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            const HomePage()), (Route<dynamic> route) => false),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(color: Colors.white, child: Image.asset(widget.img)),
              const SizedBox(height: 20),
              Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
              const Divider(color: Colors.white, thickness: 2),
              RichText(
                text: TextSpan(
                  children: descTab.map((e) {
                    if (descTab.indexOf(e) % 2 == 0) {
                      return TextSpan(
                        text: e,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      );
                    } else {
                      return TextSpan(
                        text: e,
                        style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 20, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () => showDialog(
                          context: context,
                          builder: (context) {
                            final double width2 = MediaQuery.of(context).size.width;
                            return SimpleDialog(
                              title: Text(e),
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("MS-DOS is a computer operating system developed by Microsoft for the IBM PC. It is the successor to the DOS operating system. It was first released in the mid-1980s, and is the most widely used operating system in the world. MS-DOS is a proprietary operating system that is licensed under the Microsoft Software License."),
                                ),
                                GestureDetector(
                                  //TODO
                                  //onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Datasheet(img: "", title: "MS-DOS", description: "MS-DOS is a computer operating system developed by Microsoft for the IBM PC. It is the successor to the DOS operating system. It was first released in the mid-1980s, and is the most widely used operating system in the world. MS-DOS is a proprietary operating system that is licensed under the Microsoft Software License."))),
                                  child: Center(
                                    child: Container(
                                      width: width2 * 0.6,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey, width: 2),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(child: Text("voirPlus".tr, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        ),
                      );
                    }
                  }).toList()
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  width: width * 0.6,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('video'.tr, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold))
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ),
    );
  }
}
