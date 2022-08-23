import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/db_helper.dart';
import 'package:nam_ip_museum/models/component.dart';
import 'package:nam_ip_museum/models/type_component.dart';
import 'package:nam_ip_museum/components_details/component_image.dart';
import 'package:nam_ip_museum/components_details/legendeDatasheet.dart';
import 'package:nam_ip_museum/videos/video.dart';

import '../home_pages/home_page.dart';

class Datasheet extends StatefulWidget {
  late final String img;
  late final String title;
  late final String description;
  late final int id;
  late final TypeComponent type;
  late final int annee;

  Datasheet({Key? key, required this.img, required this.title, required this.description, required this.id, required this.type, required this.annee}) : super(key: key);

  Datasheet.fromComponent({Key? key, required Component component}) : super(key: key) {
    img = component.logo;
    title = component.name;
    description = component.descFr;
    id = component.id;
    type = component.type;
    annee = component.date;
  }

  @override
  State<Datasheet> createState() => _DatasheetState();
}

class _DatasheetState extends State<Datasheet> {

  List<String> descTab = List.empty(growable: true);
  late final Map<String, Object?> componentData;
  String urlVideo = '';

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
    if (['micro', 'os', 'cpu', 'ihm', 'app'].contains(widget.type.toString().substring(14))) {
      DBHelper dbHelper = DBHelper();
      dbHelper.getKeywords(widget.id);
      componentData = (await dbHelper.getComponentData(widget.id, typeComponentToString(widget.type), widget.annee))!;
    } else {
      componentData = {};
    }
    String location;
    if(Get.locale?.languageCode == 'fr') {
      location = 'assets/data/videosFrData.json';
    } else {
      location = 'assets/data/videosEnData.json';
    }
    final String response = await rootBundle.loadString(location);
    final List data = await json.decode(response);
    urlVideo = data.firstWhere((element) => element['id'] == widget.id, orElse: () => {'videoURL': ''})['videoURL'];
    setState(() {});
  }

  String typeComponentToString(TypeComponent type) {
    switch (type) {
      case TypeComponent.micro:
        return 'MICRO';
      case TypeComponent.os:
        return 'OS';
      case TypeComponent.cpu:
        return 'CPU';
      case TypeComponent.ihm:
        return 'IHM';
      case TypeComponent.app:
        return 'APP';
      default:
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
      body: Builder(
        builder: (context) {
          Widget returnWidget = const SizedBox(height: 0, width: 0);
          try {
            returnWidget = SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComponentImage(img: widget.img,))),
                      child: Image.asset(widget.img)
                    ),
                    const SizedBox(height: 20),
                    Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                    const Divider(color: Colors.white, thickness: 2),
                    DatasheetLegend(type: widget.type, data: componentData),
                    componentData.isEmpty ? const SizedBox(height: 0, width: 0) : const Divider(color: Colors.white, thickness: 2),
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
                    urlVideo.isNotEmpty ? GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Video(url: urlVideo,))),
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
                    ) : const SizedBox(height: 0, width: 0),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            );
          } catch (e) {
            returnWidget = const Center(child: CircularProgressIndicator(color: Colors.white));
          }
          return returnWidget;
        }
      ),
    );
  }
}
