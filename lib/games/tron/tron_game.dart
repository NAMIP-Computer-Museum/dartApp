import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/tron/background.dart';
import 'package:nam_ip_museum/games/tron/game/my_game.dart';
import 'package:nam_ip_museum/games/tron/joystick/joystick.dart';

import '../direction.dart';

class TronGame extends FlameGame with HasTappables {

  Direction motorbikeDirection = Direction.idle;
  Direction lastDirection = Direction.right;

  List<List<bool>> isOccupied = List.generate(30, (index) => List.generate(30, (index) => false)); //TODO MySharedPreferences

  @override
  Future<void>? onLoad() {
    add(Background());
    add(Joystick());
    add(MyGame());
    return super.onLoad();
  }
}