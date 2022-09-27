import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class Snake extends PositionComponent with HasGameRef<SnakeGame> {

  int snakeSize = 3;
  List<int> cases = [106, 107, 108];

  @override
  void render(Canvas canvas) {
    final Paint paint = BasicPalette.blue.paint();
    const nbCase = GameBackground.nbCase;
    final caseSize = (gameRef.size.x - GameBackground.padding) / nbCase;
    for (int i in cases) {
      int x = i % nbCase;
      int y = i ~/ nbCase;
      canvas.drawRect(Rect.fromLTWH(GameBackground.padding/2 + x * caseSize, GameBackground.padding/2 + y * caseSize, caseSize, caseSize), paint);
    }
    super.render(canvas);
  }

  void updateCases(int intCase) {
    cases.add(intCase);
    if (cases.length > snakeSize) {
      cases.removeAt(0);
    }
  }
}