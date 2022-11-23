import 'package:flutter/material.dart';

import '../game/game_background.dart';
import '../snake_game.dart';


class Score extends StatefulWidget {

  final SnakeGame game;

  const Score({Key? key, required this.game}) : super(key: key);

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  bool isPlay = true;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: GameBackground.padding/2,
      top: GameBackground.padding/2 - 32,
      child: Text(
        'Score: ${widget.game.score}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
