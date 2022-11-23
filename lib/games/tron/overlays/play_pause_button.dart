import 'package:flutter/material.dart';

import '../../direction.dart';
import '../game/my_game.dart';
import '../tron_game.dart';

class PlayPauseButton extends StatefulWidget {

  final TronGame game;

  const PlayPauseButton({Key? key, required this.game}) : super(key: key);

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {

  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: MyGame.padding,
        top: MyGame.padding - 45,
        child: IconButton(
          onPressed: () {
            if (isPlay) {
              widget.game.myGame.motorbike.direction = Direction.idle;
              setState(() {
                isPlay = false;
              });
            } else {
              widget.game.myGame.motorbike.direction = widget.game.myGame.motorbike.lastDirection;
              setState(() {
                isPlay = true;
              });
            }
          },
          icon: Icon(
            isPlay ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
        )
    );
  }
}
