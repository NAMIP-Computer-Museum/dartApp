import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/data/db_helper.dart';
import 'package:nam_ip_museum/utils/functions.dart';
import 'package:nam_ip_museum/models/component.dart';
import 'package:nam_ip_museum/models/type_component.dart';
import 'package:nam_ip_museum/components_details/component_image.dart';
import 'package:nam_ip_museum/components_details/legendeDatasheet.dart';
import 'package:nam_ip_museum/utils/navigation_service.dart';
import 'package:nam_ip_museum/videos/video.dart';
import 'package:nam_ip_museum/utils/widgets.dart';
import 'package:video_player/video_player.dart';

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

  late VideoPlayerController _controller;

  @override
  void initState() {
    setDesc();
    readData();

    super.initState();
  }

  @override
  void dispose() {
    if (urlVideo != '') {
      _controller.dispose();
    }
    super.dispose();
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
    if (urlVideo != '') {
      _controller = VideoPlayerController.asset(urlVideo)
        ..setLooping(true)
        ..addListener(() {setState(() {});});
      await _controller.initialize();
    }
    swiper = await getSwiper();
    setState(() {detailDataLoaded = true;});
  }

  late Widget swiper;

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
                child: Text(Functions.getStringLang(fr: component.descFr, en: component.descEn, nl: component.descNL)),
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
      backgroundColor: Colors.red.shade800,
      appBar: Widgets.appBar(context),
      body: Builder(
        builder: (context) {
          if (descDataLoaded && detailDataLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    swiper,
                    // GestureDetector(
                    //   onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComponentImage(img: widget.img,))),
                    //   child: Image.asset(widget.img)
                    // ),
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

  Future<Widget> getSwiper() async {
    final List<String> imgList = [widget.img, widget.img, urlVideo != '' ? urlVideo : widget.img];
    final List<String> typeList = ['img', 'img', urlVideo != '' ? 'video' : 'img'];
    List<Size> sizes = [];
    for (int i = 0; i < imgList.length; i++) {
      if (typeList[i] == 'img') {
        sizes.add(await _calculateImageDimension(imgList[i]));
      } else {
        if (_controller.value.size != Size.zero) {
          sizes.add(_controller.value.size);
        }
      }
    }
    double maxRatio = sizes.map((e) => e.width / e.height).toList().reduce((value, element) => value > element? value: element);
    return SizedBox(
      height: (NavigationService.getContext().size?.width)! / maxRatio,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          if (typeList[index] == 'img') {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComponentImage(img: imgList[index],))),
              child: Center(child: Image.asset(imgList[index])),
            );
          } else {
            return _controller.value.isInitialized
              ? GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
              : const CircularProgressIndicator();
          }
        },
        itemCount: 3,
        pagination: const SwiperPagination(),
      ),
    );
  }

  Future<Size> _calculateImageDimension(String img) {
    Completer<Size> completer = Completer();
    Image image = Image.asset(img);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }
}
