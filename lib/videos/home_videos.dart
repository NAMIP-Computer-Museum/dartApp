import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum_web/models/video.dart';
import 'package:nam_ip_museum_web/videos/video.dart';
import 'package:http/http.dart' as http;

import '../utils/widgets.dart';

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
    Uri url = Uri.https("www.googleapis.com", "youtube/v3/search", {
      "channelId": "UCB55_N6erztUDx1b3dVz8sg",
      "key": "AIzaSyCxHWje4V4JOJp1-DEaKwpCQ7gyTOffe0E",
      "part": "snippet",
      "type": "video",
      "maxResults": "50",
    });
    var res = await http.get(url);
    var data = json.decode(res.body);
    List youtubeVideos = data['items'];
    for (final video in youtubeVideos) {
      videos.add(VideoData(
        title: video['snippet']['title'].replaceAll('&#39;', "'"),
        id: video['id']['videoId'],
        description: video['snippet']['description'],
        img: video['snippet']['thumbnails']['high']['url'] ?? video['snippet']['thumbnails']['default']['url'],
      ));
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
              border: const Border(bottom: BorderSide(color: Colors.white, width: 2)),
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
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Video(videoData: e,))),
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: 75,
                            child: Row(
                              children: [
                                Image.network(e.img),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(e.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 5),
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
