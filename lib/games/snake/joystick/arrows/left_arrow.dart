import 'dart:ui';

import 'package:flame/components.dart';

import '../../snake_game.dart';

class LeftArrow extends SpriteComponent with HasGameRef<SnakeGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('left-arrow.png');

    final size = gameRef.size;
    final x = size.x;
    final y = size.y;
    final Offset center = Offset(x/2, (y+x)/2);
    final double rayon = x/4;

    width = rayon / 1.5;
    height = width;
    position = Vector2(center.dx - rayon/1.5, center.dy);
    anchor = Anchor.center;

    return super.onLoad();
  }
}