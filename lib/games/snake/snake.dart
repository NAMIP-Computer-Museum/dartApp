import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../../utils/widgets.dart';
import 'overlays/game_over.dart';
import 'overlays/play_pause_button.dart';
import 'overlays/score.dart';
import 'overlays/settings.dart';
import 'overlays/settings_button.dart';
import 'snake_game.dart';

class Snake extends StatelessWidget {
  const Snake({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Center(
        child: SizedBox(
          width: kIsWeb ? MediaQuery.of(context).size.height * 0.6 : double.infinity,
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
    );
  }
}
