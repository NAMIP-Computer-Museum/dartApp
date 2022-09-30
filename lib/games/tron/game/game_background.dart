import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum/games/tron/game/motorbike.dart';
import 'package:nam_ip_museum/games/tron/game/wall.dart';
import 'package:nam_ip_museum/games/tron/tron_game.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

class GameBackground extends PositionComponent with HasGameRef<TronGame> {

  static int nbCase = 15;
  static const padding = 50.0;

  // https://color.adobe.com/fr/TRON-color-theme-6970180/
  MotorBike motorbike = MotorBike(const Color(0xFFFFE64D));

  @override
  Future<void>? onLoad() {
    position = Vector2(padding, padding);
    size = Vector2(gameRef.size.x - 2 * padding, gameRef.size.x - 2 * padding);
    RectangleHitbox hitbox = RectangleHitbox(size: size);
    hitbox.debugMode = true;
    add(hitbox);
    add(motorbike);
    add(Wall(motorbike));
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {

    // Draw the background
    Paint blackPaint = Paint()..color = const Color(0xFF0C141F);
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), blackPaint);

    // Draw the grid
    Paint whitePaint = Paint()..color = const Color(0xFFE6FFFF);
    whitePaint.strokeWidth = 1;
    for (int i = 0; i < nbCase + 1; i++) {
      canvas.drawLine(Offset(0, i * height / nbCase), Offset(width, i * height / nbCase), whitePaint);
      canvas.drawLine(Offset(i * width / nbCase, 0), Offset(i * width / nbCase, height), whitePaint);
    }

    //Line between grid and joystick
    final paint = Paint()
      ..color = BasicPalette.white.color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPoints(PointMode.lines, [Offset(-padding, height + padding), Offset(width + padding, height + padding)], paint);

    super.render(canvas);
  }
}