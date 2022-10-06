import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/tron/background.dart';
import 'package:nam_ip_museum/games/tron/game/my_game.dart';
import 'package:nam_ip_museum/games/tron/joystick/joystick.dart';

class TronGame extends FlameGame with HasTappables {

  List<List<bool>> isOccupied = List.generate(30, (index) => List.generate(30, (index) => false)); //TODO MySharedPreferences
  final MyGame myGame = MyGame();

  @override
  Future<void>? onLoad() {
    add(Background());
    add(Joystick());
    add(myGame);
    return super.onLoad();
  }

  void gameOver() {
    //TODO
  }

  void removeIaMotorbike() {
    myGame.remove(myGame.iaMotorbike);
    //TODO win if no iaMotorbike
  }
}