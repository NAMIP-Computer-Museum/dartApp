import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OverlayVideo extends StatelessWidget {

  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;

  const OverlayVideo({Key? key, required this.controller, required this.onClickedFullScreen}) : super(key: key);

  String getPosition() {
    final duration = Duration(
        milliseconds: controller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.value.isPlaying ? controller.pause() : controller.play(),
      child: Stack(
        children: [
          videoProgressIndicator(),
          videoAdvancement(),
          fullScreen(context),
          buildPlay(),
        ]
      ),
    );
  }

  Widget videoProgressIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: VideoProgressIndicator(
        controller,
        allowScrubbing: true,
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  Widget videoAdvancement() {
    return Positioned(
      left: 8,
      bottom: 28,
      child: Text(getPosition())
    );
  }

  Widget buildPlay() =>
      controller.value.isPlaying
      ? Container()
      : Container(
    color: Colors.black26,
    child: Center(
      child: Icon(
        Icons.play_arrow,
        color: Colors.white.withOpacity(0.5),
        size: 70,
      ),
    ),
  );

  Widget fullScreen(BuildContext context) {
    return Positioned(
      bottom: 28,
      right: 8,
      child: GestureDetector(
        onTap: onClickedFullScreen,
        child: Icon(
          MediaQuery.of(context).orientation == Orientation.portrait ? Icons.fullscreen : Icons.fullscreen_exit,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
