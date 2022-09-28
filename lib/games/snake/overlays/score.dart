import 'package:flutter/material.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class Score extends StatelessWidget {

  final SnakeGame game;

  const Score({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: GameBackground.padding / 2 - 30,
      left: GameBackground.padding / 2,
      child: Text(
        'Score: ${game.score}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
