import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

class Apple extends SpriteComponent with HasGameRef<SnakeGame> {

  final int appleCase;

  Apple({required this.appleCase});

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("snake/apple.png");
    width = (gameRef.size.x - GameBackground.padding) / GameBackground.nbCase;
    height = width;

    final int nbCase = GameBackground.nbCase;
    const int padding = GameBackground.padding;
    final caseSize = (gameRef.size.x - padding) / nbCase;
    int x = appleCase % nbCase;
    int y = appleCase ~/ nbCase;
    Offset position = Offset(padding/2 + x * caseSize, padding/2 + y * caseSize);
    super.position = position.toVector2();
    return super.onLoad();
  }
}