import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum_web/games/direction.dart';
import 'package:nam_ip_museum_web/games/snake/game/game_background.dart';
import 'package:nam_ip_museum_web/games/snake/snake_game.dart';

class SnakeLang extends PositionComponent with HasGameRef<SnakeGame> {

  int headPosition;

  int index = 0;
  double clock = 0;

  SnakeLang({required this.headPosition});

  @override
  Future<void>? onLoad() {
    final double caseSize = (gameRef.size.x - GameBackground.padding) / GameBackground.nbCase;
    width = caseSize;
    height = caseSize;
    changePosition();
    return super.onLoad();
  }

  void changePosition() {
    final double caseSize = (gameRef.size.x - GameBackground.padding) / GameBackground.nbCase;
    int x = headPosition % GameBackground.nbCase;
    int y = headPosition ~/ GameBackground.nbCase;
    position = Vector2(
      GameBackground.padding/2 + x * caseSize,
      GameBackground.padding/2 + y * caseSize,
    );
    switch (gameRef.snakeDirection) {
      case Direction.up:
        position.y -= caseSize;
        break;
      case Direction.down:
        position.y += caseSize;
        break;
      case Direction.left:
        position.x -= caseSize;
        break;
      case Direction.right:
        position.x += caseSize;
        break;
      case Direction.idle:
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    final double caseSize = (gameRef.size.x - GameBackground.padding) / GameBackground.nbCase;
    final double r = caseSize/5.5;
    final Paint redPaint = BasicPalette.red.paint();
    switch(gameRef.snakeDirection) {
      case Direction.right:
        Path path = Path();
        path.addPolygon([
          Offset(0, (width / 2) - r/1.5),
          Offset(0, (width / 2) + r/1.5),
          Offset(0 + width / 1.5, (width / 2) + r),
          Offset(0 + width / 2, (width / 2)),
          Offset(0 + width / 1.5, (width / 2) - r),
        ], true);
        canvas.drawPath(path, redPaint);
        break;
      case Direction.up:
        Path path = Path();
        path.addPolygon([
          Offset((width / 2) - r/1.5, width),
          Offset((width / 2) + r/1.5, width),
          Offset((width / 2) + r, width - height / 1.5),
          Offset((width / 2), width - height / 2),
          Offset((width / 2) - r, width - height / 1.5),
        ], true);
        canvas.drawPath(path, redPaint);
        break;
      case Direction.down:
        Path path = Path();
        path.addPolygon([
          Offset((width / 2) - r/1.5, 0),
          Offset((width / 2) + r/1.5, 0),
          Offset((width / 2) + r, height / 1.5),
          Offset((width / 2), height / 2),
          Offset((width / 2) - r, height / 1.5),
        ], true);
        canvas.drawPath(path, redPaint);
        break;
      case Direction.left:
        Path path = Path();
        path.addPolygon([
          Offset(0 + width, (width / 2) - r/1.5),
          Offset(0 + width, (width / 2) + r/1.5),
          Offset(0 + width - width / 1.5, (width / 2) + r),
          Offset(0 + width - width / 2, (width / 2)),
          Offset(0 + width - width / 1.5, (width / 2) - r),
        ], true);
        canvas.drawPath(path, redPaint);
        break;
      case Direction.idle:
        break;
    }
    super.render(canvas);
  }

  @override
  void update(double dt) {
    clock += dt;
    if (clock >= 0.5) {
      clock = 0;
      index = (index + 1) % 3;
    }
    super.update(dt);
  }
}