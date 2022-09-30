import 'package:flutter/material.dart';

import '../game/game_background.dart';
import '../snake_game.dart';

class SettingsButton extends StatelessWidget {

  final SnakeGame game;

  const SettingsButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: GameBackground.padding/2,
      top: GameBackground.padding/2 - 45,
      child: IconButton(
        onPressed: () {
          game.overlays.add('Settings');
        },
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
    );
  }
}
