import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OverlayVideo extends StatelessWidget {

  final VideoPlayerController controller;

  const OverlayVideo({Key? key, required this.controller}) : super(key: key);

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

        ]
      ),
    );
  }
}
