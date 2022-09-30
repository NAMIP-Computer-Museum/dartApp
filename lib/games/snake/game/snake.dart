import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum/games/snake/direction.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/game/snake_lang.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {

  int snakeSize = 3;
  List<int> cases = [GameBackground.nbCase * (GameBackground.nbCase~/2) + 1, GameBackground.nbCase * (GameBackground.nbCase~/2) + 2, GameBackground.nbCase * (GameBackground.nbCase~/2) + 3];
  double snakeSpeed = 1 - MySharedPreferences.snakeSpeed;
  final bool isFirstRender = MySharedPreferences.isClassicSnake;
  Direction lastDirection = Direction.right; // only use for canvas in render method

  @override
  void render(Canvas canvas) {

    final nbCase = GameBackground.nbCase;
    final caseSize = (gameRef.size.x - GameBackground.padding) / nbCase;

    final Paint paint = Paint()..color = MySharedPreferences.snakeColor;

    if (isFirstRender) { //first render
      for (int i in cases) {
        int x = i % nbCase;
        int y = i ~/ nbCase;
        Rect rect = Rect.fromLTWH(GameBackground.padding/2 + x * caseSize, GameBackground.padding/2 + y * caseSize, caseSize, caseSize);
        canvas.drawRect(rect, paint);
        canvas.drawRect(rect, BasicPalette.white.paint()..style = PaintingStyle.stroke..strokeWidth = 2);
      }
    } else { //second render
      // Paint paint = Paint();
      // const int firstColorGradient = 0xff4286f4;
      // const int lastColorGradient = 0xff373B44;
      // final int stepColor = (lastColorGradient - firstColorGradient).abs() ~/ snakeSize;
      for (int k = 0; k < cases.length; k++) {
        int? lastCase = k == 0 ? null : cases[cases.length - k];
        int? nextCase = k == cases.length - 1 ? null : cases[cases.length - k - 2];

        int i = cases[cases.length - 1 - k];
        int x = i % nbCase;
        int y = i ~/ nbCase;
        Rect rect = Rect.fromLTWH(GameBackground.padding/2 + x * caseSize, GameBackground.padding/2 + y * caseSize, caseSize, caseSize);
        //paint.shader = Gradient.radial(rect.center, rect.width, [Color(firstColorGradient + stepColor * k), Color(firstColorGradient + stepColor * (k + 1))]);
        if (lastCase == null) { // snake head
          final double p = caseSize/2;
          final double q = caseSize/4.5;
          final double r = caseSize/5.5;
          final Paint whitePaint = BasicPalette.white.paint();
          final Paint blackPaint = BasicPalette.black.paint();
          final Paint redPaint = BasicPalette.red.paint();
          switch (lastDirection) {
            case Direction.right:
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: const Radius.circular(8.0), bottomRight: const Radius.circular(8.0)), paint);
              //eyes
              canvas.drawCircle(Offset(rect.right - p, rect.top + q), r, whitePaint);
              canvas.drawCircle(Offset(rect.right - p, rect.bottom - q), r, whitePaint);
              canvas.drawCircle(Offset(rect.right - p+1, rect.top + q), r/2, blackPaint);
              canvas.drawCircle(Offset(rect.right - p+1, rect.bottom - q), r/2, blackPaint);
              break;
            case Direction.left:
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(8.0), bottomLeft: const Radius.circular(8.0)), paint);
              canvas.drawCircle(Offset(rect.left + p, rect.top + q), r, whitePaint);
              canvas.drawCircle(Offset(rect.left + p, rect.bottom - q), r, whitePaint);
              canvas.drawCircle(Offset(rect.left + p-1, rect.top + q), r/2, blackPaint);
              canvas.drawCircle(Offset(rect.left + p-1, rect.bottom - q), r/2, blackPaint);
              break;
            case Direction.up:
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(8.0), topRight: const Radius.circular(8.0)), paint);
              canvas.drawCircle(Offset(rect.left + q, rect.top + p), r, whitePaint);
              canvas.drawCircle(Offset(rect.right - q, rect.top + p), r, whitePaint);
              canvas.drawCircle(Offset(rect.left + q, rect.top + p-1), r/2, blackPaint);
              canvas.drawCircle(Offset(rect.right - q, rect.top + p-1), r/2, blackPaint);
              break;
            case Direction.down:
              canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomLeft: const Radius.circular(8.0), bottomRight: const Radius.circular(8.0)), paint);
              canvas.drawCircle(Offset(rect.left + q, rect.bottom - p), r, whitePaint);
              canvas.drawCircle(Offset(rect.right - q, rect.bottom - p), r, whitePaint);
              canvas.drawCircle(Offset(rect.left + q, rect.bottom - p+1), r/2, blackPaint);
              canvas.drawCircle(Offset(rect.right - q, rect.bottom - p+1), r/2, blackPaint);
              break;
            case Direction.idle:
              canvas.drawRect(rect, paint);
              break;
          }
        } else {
          if (nextCase == null) { // snake tail
            if (lastCase - i == 1) { // right
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(8.0), bottomLeft: const Radius.circular(8.0)), paint);
            } else if (lastCase - i == -1) { // left
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: const Radius.circular(8.0), bottomRight: const Radius.circular(8.0)), paint);
            } else if (lastCase - i == nbCase) { // down
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(8.0), topRight: const Radius.circular(8.0)), paint);
            } else if (lastCase - i == -nbCase) { // up
              canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomLeft: const Radius.circular(8.0), bottomRight: const Radius.circular(8.0)), paint);
            }
          } else { // snake body
            if (lastCase == i + 1 && nextCase == i - 1) { // right to left
              canvas.drawRect(rect, paint);
            } else if (lastCase == i - 1 && nextCase == i + 1) { // left to right
              canvas.drawRect(rect, paint);
            } else if (lastCase == i + nbCase && nextCase == i - nbCase) { // down to up
              canvas.drawRect(rect, paint);
            } else if (lastCase == i - nbCase && nextCase == i + nbCase) { // up to down
              canvas.drawRect(rect, paint);
            } else if (lastCase == i + 1 && nextCase == i + nbCase) { // right to down
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(14.0)), paint);
            } else if (lastCase == i + nbCase && nextCase == i + 1) { // down to right
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(14.0)), paint);
            } else if (lastCase == i + 1 && nextCase == i - nbCase) { // right to up
              canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomLeft: const Radius.circular(14.0)), paint);
            } else if (lastCase == i - nbCase && nextCase == i + 1) { // up to right
              canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomLeft: const Radius.circular(14.0)), paint);
            } else if (lastCase == i - 1 && nextCase == i + nbCase) { // left to down
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: const Radius.circular(14.0)), paint);
            } else if (lastCase == i + nbCase && nextCase == i - 1) { // down to left
              canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: const Radius.circular(14.0)), paint);
            } else if (lastCase == i - 1 && nextCase == i - nbCase) { // left to up
              canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomRight: const Radius.circular(14.0)), paint);
            } else if (lastCase == i - nbCase && nextCase == i - 1) { // up to left
              canvas.drawRRect(RRect.fromRectAndCorners(rect, bottomRight: const Radius.circular(14.0)), paint);
            }
          }
        }
      }
    }
    super.render(canvas);
  }

  double updateTick = 0;
  double clock = 0;
  int random = Random().nextInt(10);

  @override
  void update(double dt) {
    updateTick += dt;
    if (updateTick > snakeSpeed) {
      moveSnake();
      updateTick = 0;
    }
    clock++;
    if (clock >= 100 * random) {
      // render lang
      clock = 0;
      random = Random().nextInt(10);
    }
    super.update(dt);
  }

  void moveSnake() {
    int lastCase = cases[cases.length - 1];
    switch (gameRef.snakeDirection) {
      case Direction.down:
        if (lastCase ~/ GameBackground.nbCase == GameBackground.nbCase - 1) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase + GameBackground.nbCase);
        }
        break;
      case Direction.up:
        if (lastCase ~/ GameBackground.nbCase == 0) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase - GameBackground.nbCase);
        }
        break;
      case Direction.left:
        if (lastCase % GameBackground.nbCase == 0) {
          gameRef.gameOver();
        } else {
          updateCases(lastCase - 1);
        }
        break;
      case Direction.right:
        if (lastCase % GameBackground.nbCase == GameBackground.nbCase - 1) {
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
    if (gameRef.snakeDirection != Direction.idle) lastDirection = gameRef.snakeDirection;
    //verifie si la pomme est mangée
    if (gameRef.apples.where((element) => element.appleCase == intCase).isNotEmpty) {
      snakeSize++;
      gameRef.changeApple(intCase);
      gameRef.scoreUpdate();
    }
    //enlèves la dernière case du serpent s'il n'a pas mangé la pomme
    if (cases.length > snakeSize) {
      gameRef.casesWithNotSnakePart.add(cases[0]);
      cases.removeAt(0);
    }
  }


  void langRender(Canvas canvas) {
  }

  // //lang
  // Path path = Path();
  // path.addPolygon([
  // Offset(rect.right, rect.center.dy - r/1.5),
  // Offset(rect.right, rect.center.dy + r/1.5),
  // Offset(rect.right + rect.width / 1.5, rect.center.dy + r),
  // Offset(rect.right + rect.width / 2, rect.center.dy),
  // Offset(rect.right + rect.width / 1.5, rect.center.dy - r),
  // ], true);
  // canvas.drawPath(path, redPaint);
}