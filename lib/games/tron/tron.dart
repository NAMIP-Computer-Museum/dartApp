import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:nam_ip_museum/games/tron/tron_game.dart';
import 'package:nam_ip_museum/utils/widgets.dart';

class Tron extends StatelessWidget {
  const Tron({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: GameWidget(
        game: TronGame(),
      ),
    );
  }
}
