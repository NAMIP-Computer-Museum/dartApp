import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/games/tron/game/my_game.dart';

import '../tron_game.dart';

class GameFinished extends StatelessWidget {

  final TronGame game;
  final String result;

  const GameFinished({Key? key, required this.game, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.all((MyGame.padding).toDouble()),
        child: Column(
          children: [
            SizedBox(
              height: game.size.x - MyGame.padding * 2,
              width: game.size.x - MyGame.padding * 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(result, style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        game.reset();
                      },
                      child: const Text('Restart'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
