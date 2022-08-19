import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'advanced_overlay_widget.dart';

class Video extends StatefulWidget {

  final String url;

  const Video({Key? key, required this.url}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;
  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });

    _youtubeController = YoutubePlayerController(
      initialVideoId: 'ZObtWtld-g0',
    );

    _flickManager = FlickManager(
     videoPlayerController: _controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        FlickVideoPlayer videoPlayer = FlickVideoPlayer(
          flickManager: _flickManager,
        );
        PreferredSizeWidget appBar = const PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox(height: 0,));
        if (orientation == Orientation.portrait) {
          appBar = AppBar(
            backgroundColor: Colors.red.shade900,
          );
          //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        } else {
          //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
              // AspectRatio(
              //   aspectRatio: _controller.value.aspectRatio,
              //   child: videoPlayer
              // ),
              // YoutubePlayer(
              //   controller: _youtubeController,
              //   showVideoProgressIndicator: false,
              // )
              Stack(
                fit: orientation == Orientation.portrait ? StackFit.loose : StackFit.expand,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned.fill(
                    child: AdvancedOverlayWidget(
                      controller: _controller,
                      onClickedFullScreen: () {
                        if (orientation == Orientation.portrait) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
                        } else {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                          ]);
                          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
                : const CircularProgressIndicator(color: Colors.white),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _youtubeController.dispose();
    _flickManager.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }
}
