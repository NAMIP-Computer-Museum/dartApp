import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/snake/direction.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';
import 'package:nam_ip_museum/games/snake/background.dart';

import 'game/snake.dart';
import 'joystick/joystick.dart';

class SnakeGame extends FlameGame with HasTappables {

  Direction snakeDirection = Direction.idle;

  @override
  Future<void>? onLoad() async {
    await add(Background());
    await add(GameBackground());
    await add(Snake());
    await add(Joystick());
    return super.onLoad();
  }
}