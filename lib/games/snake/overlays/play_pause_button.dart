import 'package:flutter/material.dart';

import '../direction.dart';
import '../game/game_background.dart';
import '../snake_game.dart';

class PlayPauseButton extends StatefulWidget {

  final SnakeGame game;

  const PlayPauseButton({Key? key, required this.game}) : super(key: key);

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {

  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: GameBackground.padding/2,
      top: GameBackground.padding/2 - 45,
      child: IconButton(
        onPressed: () {
          if (isPlay) {
            widget.game.snakeDirection = Direction.idle;
            setState(() {
              isPlay = false;
            });
          } else {
            widget.game.snakeDirection = widget.game.snake.lastDirection;
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
