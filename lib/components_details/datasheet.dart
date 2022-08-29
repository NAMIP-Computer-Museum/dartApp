import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/db_helper.dart';
import 'package:nam_ip_museum/functions.dart';
import 'package:nam_ip_museum/models/component.dart';
import 'package:nam_ip_museum/models/type_component.dart';
import 'package:nam_ip_museum/components_details/component_image.dart';
import 'package:nam_ip_museum/components_details/legendeDatasheet.dart';
import 'package:nam_ip_museum/videos/video.dart';
import 'package:nam_ip_museum/widgets.dart';

class Datasheet extends StatefulWidget {
  late final String img;
  late final String title;
  late final String description;
  late final int id;
  late final TypeComponent type;
  late final int annee;

  Datasheet.fromComponent({Key? key, required Component component}) : super(key: key) {
    img = component.logo;
    title = component.name;
    description = Functions.getStringLang(fr: component.descMotFr, en: component.descMotEn, nl: component.descMotNL);
    id = component.id;
    type = component.type;
    annee = component.date;
  }

  @override
  State<Datasheet> createState() => _DatasheetState();
}

class _DatasheetState extends State<Datasheet> {

  List<TextSpan> descTab = List.empty(growable: true);
  Map<String, Object?> componentData = {};
  String urlVideo = '';
  bool detailDataLoaded = false;
  bool descDataLoaded = false;

  @override
  void initState() {
    setDesc();
    readData();

    super.initState();
  }

  Future<void> readData() async {
    if (['micro', 'os', 'cpu', 'ihm', 'app'].contains(widget.type.toString().substring(14))) {
      DBHelper dbHelper = DBHelper();
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
    setState(() {detailDataLoaded = true;});
  }

  Future<void> setDesc() async {
    List<String> descCopy = widget.description.split('|');
    for (String k in descCopy) {
      try {
        int id = int.parse(k);
        DBHelper dbHelper = DBHelper();
        Component? component = await dbHelper.getComponentByID(id);
        descTab.add(clickableComponent(component!));
      } catch (e) {
        descTab.add(
          TextSpan(
            text: k,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )
        );
      }
    }
    setState(() {descDataLoaded = true;});
  }

  TextSpan clickableComponent(Component component) {
    return TextSpan(
      text: component.name,
      style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 20, decoration: TextDecoration.underline),
      recognizer: TapGestureRecognizer()..onTap = () => showDialog(
        context: context,
        builder: (context) {
          final double width2 = MediaQuery.of(context).size.width;
          return SimpleDialog(
            title: Text(component.name),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(component.descFr),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Datasheet.fromComponent(component: component)));
                },
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
      appBar: Widgets.appBar(context),
      body: Builder(
        builder: (context) {
          if (descDataLoaded && detailDataLoaded) {
            return SingleChildScrollView(
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
                        children: descTab,
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
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }
        }
      ),
    );
  }
}
