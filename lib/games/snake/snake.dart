import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:nam_ip_museum/utils/widgets.dart';

import 'overlays/game_over.dart';
import 'overlays/score.dart';
import 'snake_game.dart';

class Snake extends StatelessWidget {
  const Snake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: GameWidget(
        game: SnakeGame(),
        overlayBuilderMap: {
          'GameOver': (BuildContext context, SnakeGame game) {
            return GameOver(game: game,);
          },
          'Score': (BuildContext context, SnakeGame game) {
            return Score(game: game,);
          },
        },
      ),
    );
  }
}
