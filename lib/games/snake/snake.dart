import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/games/snake/overlays/settings.dart';
import 'package:nam_ip_museum_web/utils/widgets.dart';

import 'overlays/game_over.dart';
import 'overlays/play_pause_button.dart';
import 'overlays/score.dart';
import 'overlays/settings_button.dart';
import 'snake_game.dart';

class Snake extends StatelessWidget {
  const Snake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.height * 0.6,
            child: GameWidget(
              game: SnakeGame(),
              overlayBuilderMap: {
                'GameOver': (BuildContext context, SnakeGame game) {
                  return GameOver(game: game,);
                },
                'Score': (BuildContext context, SnakeGame game) {
                  return Score(game: game,);
                },
                'Settings': (BuildContext context, SnakeGame game) {
                  return Settings(game: game,);
                },
                'SettingsButton': (BuildContext context, SnakeGame game) {
                  return SettingsButton(game: game,);
                },
                'PlayPauseButton': (BuildContext context, SnakeGame game) {
                  return PlayPauseButton(game: game,);
                },
              },
            ),
          ),
        ),
      ),
    );
  }
}
