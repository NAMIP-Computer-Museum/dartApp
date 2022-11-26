import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/models/video.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../utils/widgets.dart';

class Video extends StatefulWidget {
  final VideoData videoData;

  const Video({Key? key, required this.videoData}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    const params = YoutubePlayerParams(
      strictRelatedVideos: true,
    );
    _controller =
        YoutubePlayerController.fromVideoId(videoId: widget.videoData.id, params: params); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: Widgets.appBar(context),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
        )
      ),
    );
  }
}
