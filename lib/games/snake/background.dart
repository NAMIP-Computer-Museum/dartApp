import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class Background extends SpriteComponent with HasGameRef<SnakeGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("snake/binaryBackground.png");
    width = gameRef.size.x;
    height = gameRef.size.y;
    return super.onLoad();
  }
}
