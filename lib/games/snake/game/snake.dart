import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum/games/snake/direction.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {

  int snakeSize = 3;
  List<int> cases = [106, 107, 108];
  double snakeSpeed = 0.3;

  @override
  void render(Canvas canvas) {
    final Paint paint = BasicPalette.blue.paint();
    const nbCase = GameBackground.nbCase;
    final caseSize = (gameRef.size.x - GameBackground.padding) / nbCase;
    for (int i in cases) {
      int x = i % nbCase;
      int y = i ~/ nbCase;
      Rect rect = Rect.fromLTWH(GameBackground.padding/2 + x * caseSize, GameBackground.padding/2 + y * caseSize, caseSize, caseSize);
      canvas.drawRect(rect, paint);
      canvas.drawRect(rect, BasicPalette.white.paint()..style = PaintingStyle.stroke..strokeWidth = 2);
    }
    super.render(canvas);
  }

  double updateTick = 0;

  @override
  void update(double dt) {
    updateTick += dt;
    if (updateTick > snakeSpeed) {
      moveSnake();
      updateTick = 0;
    }
    super.update(dt);
  }

  void moveSnake() {
    int lastCase = cases[cases.length - 1];
    switch (gameRef.snakeDirection) {
      case Direction.down:
        if (lastCase ~/ 15 == 14) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase + GameBackground.nbCase);
        }
        break;
      case Direction.up:
        if (lastCase ~/ 15 == 0) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase - GameBackground.nbCase);
        }
        break;
      case Direction.left:
        if (lastCase % 15 == 0) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase - 1);
        }
        break;
      case Direction.right:
        if (lastCase % 15 == 14) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase + 1);
        }
        break;
      case Direction.idle:
        break;
    }
  }

  void updateCases(int intCase) {
    //verifie si le serpent n'est pas déjà sur cette case
    List<int> copy = List.from(cases);
    copy.removeAt(0);
    if (copy.contains(intCase)) {
      gameRef.gameOver();
      gameRef.snakeDirection = Direction.idle;
      return;
    }


    cases.add(intCase);
    gameRef.casesWithNotSnakePart.remove(intCase);
    //verifie si la pomme est mangée
    if (intCase == gameRef.apple.appleCase) {
      snakeSize++;
      gameRef.changeApple();
      gameRef.scoreUpdate();
    }
    //enlèves la dernière case du serpent s'il n'a pas mangé la pomme
    if (cases.length > snakeSize) {
      gameRef.casesWithNotSnakePart.add(cases[0]);
      cases.removeAt(0);
    }
  }
}