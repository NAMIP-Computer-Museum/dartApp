import 'dart:ui';

import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class DownArrow extends SpriteComponent with HasGameRef<SnakeGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('down-arrow.png');

    final size = gameRef.size;
    final x = size.x;
    final y = size.y;
    final Offset center = Offset(x/2, (y+x)/2);
    final double rayon = x/4;

    width = rayon / 1.5;
    height = width;
    position = Vector2(center.dx, center.dy + rayon/1.5);
    anchor = Anchor.center;

    return super.onLoad();
  }
}