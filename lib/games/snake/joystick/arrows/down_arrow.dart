import 'dart:ui';

import 'package:flame/components.dart';

import '../../snake_game.dart';

class DownArrow extends SpriteComponent with HasGameRef<SnakeGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('snake/down-arrow.png');

    final double rayon = gameRef.size.x/4;
    final Offset center = Offset(rayon, rayon);

    width = rayon / 1.5;
    height = width;
    position = Vector2(center.dx, center.dy + rayon/1.5);
    anchor = Anchor.center;

    return super.onLoad();
  }
}