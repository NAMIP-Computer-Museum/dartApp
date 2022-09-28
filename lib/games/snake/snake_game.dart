import 'dart:math';

import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/snake/direction.dart';
import 'package:nam_ip_museum/games/snake/game/apple.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/background.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game/snake.dart';
import 'joystick/joystick.dart';

class SnakeGame extends FlameGame with HasTappables {

  Direction snakeDirection = Direction.idle;
  int score = 0;
  late Apple apple = getRandomApple();
  List<int> casesWithNotSnakePart = List.generate(GameBackground.nbCase * GameBackground.nbCase - 3, (index) {
    if (index < 106) {
      return index;
    } else {
      return index + 3;
    }
  });
  Snake snake = Snake();

  @override
  Future<void>? onLoad() async {
    await add(Background());
    await add(GameBackground());
    await add(apple);
    await add(snake);
    await add(Joystick());
    overlays.add('Score');
    return super.onLoad();
  }

  Apple getRandomApple() {
    int random = Random().nextInt(casesWithNotSnakePart.length);
    return Apple(appleCase: casesWithNotSnakePart[random]);
  }

  void changeApple() {
    remove(apple);
    apple = getRandomApple();
    add(apple);
  }

  void gameOver() async {
    snakeDirection = Direction.idle;
    overlays.add('GameOver');
    if (score > MySharedPreferences.snakeHighScore) {
      await MySharedPreferences.updateSnakeHighScore(score);
    }
  }

  void reset() {
    overlays.remove('GameOver');
    score = 0;
    snakeDirection = Direction.idle;
    casesWithNotSnakePart = List.generate(GameBackground.nbCase * GameBackground.nbCase - 3, (index) {
      if (index < 106) {
        return index;
      } else {
        return index + 3;
      }
    });
    remove(apple);
    apple = getRandomApple();
    add(apple);
    remove(snake);
    snake = Snake();
    add(snake);
  }

  void scoreUpdate() {
    score += 1;
    // if (score % 5 == 0) {
    //   snake.snakeSpeed -= 0.05;
    // } //TODO
    overlays.remove('Score');
    overlays.add('Score');
  }
}