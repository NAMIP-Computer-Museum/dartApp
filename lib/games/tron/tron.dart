import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/games/tron/overlays/game_finished.dart';
import 'package:nam_ip_museum_web/games/tron/overlays/play_pause_button.dart';
import 'package:nam_ip_museum_web/games/tron/overlays/settings.dart';
import 'package:nam_ip_museum_web/games/tron/overlays/settings_button.dart';
import 'package:nam_ip_museum_web/games/tron/tron_game.dart';
import 'package:nam_ip_museum_web/utils/widgets.dart';

class Tron extends StatelessWidget {
  const Tron({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6FC3DF),
              Color(0xFF0C141F),
            ],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.height * 0.6,
            child: GameWidget(
              game: TronGame(),
              overlayBuilderMap: {
                'GameOver': (BuildContext context, TronGame game) {
                  return GameFinished(game: game, result: 'Game Over');
                },
                'Win': (BuildContext context, TronGame game) {
                  return GameFinished(game: game, result: 'You Win');
                },
                'Settings': (BuildContext context, TronGame game) {
                  return Settings(game: game,);
                },
                'SettingsButton': (BuildContext context, TronGame game) {
                  return SettingsButton(game: game,);
                },
                'PlayPauseButton': (BuildContext context, TronGame game) {
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
