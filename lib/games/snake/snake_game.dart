import 'dart:math';

import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/snake/direction.dart';
import 'package:nam_ip_museum/games/snake/game/apple.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/background.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

import 'game/snake.dart';
import 'joystick/joystick.dart';

class SnakeGame extends FlameGame with HasTappables {

  Direction snakeDirection = Direction.idle;
  int score = 0;
  late List<Apple> apples = List.generate(MySharedPreferences.appleCount, (index) => getRandomApple());
  List<int> casesWithNotSnakePart = List.generate(GameBackground.nbCase * GameBackground.nbCase - 3, (index) {
    if (index < 106) {
      return index;
    } else {
      return index + 3;
    }
  });
  Snake snake = Snake();
  GameBackground gameBackground = GameBackground();

  @override
  Future<void>? onLoad() async {
    await add(Background());
    await add(gameBackground);
    for (Apple apple in apples) {
      await add(apple);
    }
    await add(snake);
    await add(Joystick());
    overlays.add('Score');
    overlays.add('SettingsButton');
    return super.onLoad();
  }

  Apple getRandomApple() {
    int random = Random().nextInt(casesWithNotSnakePart.length);
    return Apple(appleCase: casesWithNotSnakePart[random]);
  }

  void changeApple(int appleCase) {
    int index = apples.indexWhere((element) => element.appleCase == appleCase);
    remove(apples[index]);
    apples[index] = getRandomApple();
    add(apples[index]);
  }

  void gameOver() async {
    snakeDirection = Direction.idle;
    overlays.remove('PlayPauseButton');
    overlays.add('SettingsButton');
    overlays.add('GameOver');
    if (score > MySharedPreferences.snakeHighScore) {
      await MySharedPreferences.updateSnakeHighScore(score);
    }
  }

  void reset() {
    overlays.remove('GameOver');
    score = 0;
    snakeDirection = Direction.idle;
    remove(gameBackground);
    gameBackground = GameBackground();
    add(gameBackground);
    casesWithNotSnakePart = List.generate(GameBackground.nbCase * GameBackground.nbCase - 3, (index) {
      if (index < 106) {
        return index;
      } else {
        return index + 3;
      }
    });
    for (Apple apple in apples) {
      remove(apple);
    }
    apples = List.generate(MySharedPreferences.appleCount, (index) => getRandomApple());
    for (Apple apple in apples) {
      add(apple);
    }
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