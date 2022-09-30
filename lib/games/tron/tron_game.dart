import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/tron/background.dart';
import 'package:nam_ip_museum/games/tron/game/game_background.dart';
import 'package:nam_ip_museum/games/tron/joystick/joystick.dart';

import '../direction.dart';

class TronGame extends FlameGame with HasTappables, HasCollisionDetection {

  Direction motorbikeDirection = Direction.idle;
  Direction lastDirection = Direction.right;

  @override
  Future<void>? onLoad() {
    add(Background());
    add(Joystick());
    add(GameBackground());
    return super.onLoad();
  }
}