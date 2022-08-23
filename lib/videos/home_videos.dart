import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/videos/video.dart';

import '../models/video.dart';
import '../widgets.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({Key? key}) : super(key: key);

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  List<VideoData> videos = List.empty(growable: true);

  @override
  void initState() {
    readData();
    super.initState();
  }

  Future<void> readData() async {
    String location;
    if(Get.locale?.languageCode == 'fr') {
      location = 'assets/data/videosFrData.json';
    } else {
      location = 'assets/data/videosEnData.json';
    }
    final String response = await rootBundle.loadString(location);
    final List data = await json.decode(response);
    for (int i = 0; i < data.length; i++) {
      videos.add(VideoData.fromMap(data[i]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              border: const Border.symmetric(horizontal: BorderSide(color: Colors.white, width: 2)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Liste de Vidéos'.tr, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              )),
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
                child: Column(
                  children: videos.map((e) {
                    Widget divider;
                    if(videos.indexOf(e) != videos.length - 1) {
                      divider = const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(color: Colors.white, thickness: 2),
                      );
                    } else {
                      divider = const SizedBox(height: 0);
                    }
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Video(url: e.url,))),
                          child: SizedBox(
                            width: double.infinity,
                            height: 75,
                            child: Row(
                              children: [
                                const Icon(Icons.play_circle_outline, size: 50, color: Colors.white),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Flexible(
                                          child: Text(e.description,
                                            style: const TextStyle(color: Colors.grey, fontSize: 15),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                        divider
                      ]
                    );
                  }).toList(),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}
