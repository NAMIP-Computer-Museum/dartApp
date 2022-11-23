import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nam_ip_museum/videos/overlay_video.dart';
import 'package:video_player/video_player.dart';

import '../utils/widgets.dart';

class Video extends StatefulWidget {

  final String url;

  const Video({Key? key, required this.url}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;

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
      ..setLooping(true)
      ..addListener(() {setState(() {});})
      ..initialize().then((_) => _controller.play());
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        PreferredSizeWidget appBar = const PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox(height: 0,));
        if (orientation == Orientation.portrait) {
          appBar = Widgets.appBar(context);
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
              child: Stack(
                fit: orientation == Orientation.portrait ? StackFit.loose : StackFit.expand,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned.fill(
                    child: OverlayVideo(
                      controller: _controller,
                      onClickedFullScreen: () {
                        if (MediaQuery.of(context).orientation == Orientation.portrait) {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.landscapeLeft,
                          ]);
                        } else {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ) : const CircularProgressIndicator(color: Colors.white),
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
