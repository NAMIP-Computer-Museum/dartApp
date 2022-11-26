import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum_web/games/snake/snake_game.dart';
import 'package:nam_ip_museum_web/utils/my_shared_preferences.dart';

class GameBackground extends Component with HasGameRef<SnakeGame> {

  static int nbCase = MySharedPreferences.snakeGridSize;
  static const padding = 100;

  GameBackground() {
    nbCase = MySharedPreferences.snakeGridSize;
  }

  @override
  void render(Canvas canvas) {
    final x = gameRef.size.x;
    final gameSize = x - padding;

    //wall
    final Paint wallPaint = BasicPalette.white.paint();
    wallPaint.style = PaintingStyle.stroke;
    wallPaint.strokeWidth = 3;
    canvas.drawRect(Rect.fromLTWH(padding/2, padding/2, gameSize, gameSize), wallPaint);

    //grid
    final caseSize = gameSize / nbCase;
    final Paint lightGreenPaint = Paint()..color = const Color.fromRGBO(170, 215, 81, 1);
    final Paint darkGreenPaint = Paint()..color = const Color.fromRGBO(162, 209, 73, 1);
    Paint paint = lightGreenPaint;
    for (int i = 0 ; i < nbCase ; i++) {
      for (int j = 0 ; j < nbCase ; j++) {
        canvas.drawRect(Rect.fromLTWH(padding/2 + i * caseSize, padding/2 + j * caseSize, caseSize, caseSize), paint);
        paint = paint == lightGreenPaint ? darkGreenPaint : lightGreenPaint;
      }
      if (nbCase % 2 == 0) {
        paint = paint == lightGreenPaint ? darkGreenPaint : lightGreenPaint;
      }
    }
    super.render(canvas);
  }
}