import 'dart:ui';

import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class RightArrow extends SpriteComponent with HasGameRef<SnakeGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('right-arrow.png');

    final double rayon = gameRef.size.x/4;
    final Offset center = Offset(rayon, rayon);

    width = rayon / 1.5;
    height = width;
    position = Vector2(center.dx + rayon/1.5, center.dy);
    anchor = Anchor.center;
    return super.onLoad();
  }
}