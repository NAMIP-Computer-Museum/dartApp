import 'package:flutter/material.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class Score extends StatelessWidget {

  final SnakeGame game;

  const Score({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: GameBackground.padding/2,
        right: GameBackground.padding/2,
        top: GameBackground.padding/2 - 45,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Score: ${game.score}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              game.overlays.add('Settings');
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
