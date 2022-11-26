import 'dart:ui';

import 'package:flame/components.dart';
import 'package:nam_ip_museum_web/games/tron/tron_game.dart';

class UpArrow extends SpriteComponent with HasGameRef<TronGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load('tron/up.png');

    final double rayon = gameRef.size.x/4;
    final Offset center = Offset(rayon, rayon);

    width = rayon / 1.5;
    height = width;
    position = Vector2(center.dx, center.dy - rayon/1.5);
    anchor = Anchor.center;

    return super.onLoad();
  }
}