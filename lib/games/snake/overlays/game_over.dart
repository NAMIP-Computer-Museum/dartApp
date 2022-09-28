import 'package:flutter/material.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

class GameOver extends StatelessWidget {

  final SnakeGame game;

  const GameOver({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.all((GameBackground.padding / 2).toDouble()),
        child: Column(
          children: [
            Container(
              height: game.size.x - GameBackground.padding,
              width: game.size.x - GameBackground.padding,
              //color: Colors.green.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.apple, color: Colors.red, size: 50),
                            Text('Score: ${game.score}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            const Icon(Icons.emoji_events, color: Colors.yellow, size: 50),
                            Text('Record: ${MySharedPreferences.snakeHighScore}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Game Over", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
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