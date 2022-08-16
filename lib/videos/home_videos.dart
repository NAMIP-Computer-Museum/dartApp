import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({Key? key}) : super(key: key);

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller = VideoPlayerController.asset("assets/nam_ip_video.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    _youtubeController = YoutubePlayerController(
      initialVideoId: 'ZObtWtld-g0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        PreferredSizeWidget appBar = const PreferredSize(child: SizedBox(height: 0,), preferredSize: Size.fromHeight(0));
        if (orientation == Orientation.portrait) {
          appBar = AppBar(
            backgroundColor: Colors.red.shade900,
          );
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        }
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: appBar,
          body: Center(
            child: _controller.value.isInitialized
                ? GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child:
              // YoutubePlayer(
              //   controller: _youtubeController,
              //   showVideoProgressIndicator: false,
              // )
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
                : const CircularProgressIndicator(),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }
}
