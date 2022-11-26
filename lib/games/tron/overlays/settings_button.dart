import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/games/tron/game/my_game.dart';

import '../tron_game.dart';

class SettingsButton extends StatelessWidget {

  final TronGame game;

  const SettingsButton({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MyGame.padding,
      top: MyGame.padding - 45,
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
