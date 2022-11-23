import 'package:flame/game.dart';
import 'package:nam_ip_museum/games/tron/background.dart';
import 'package:nam_ip_museum/games/tron/game/ia_motorbike.dart';
import 'package:nam_ip_museum/games/tron/game/my_game.dart';
import 'package:nam_ip_museum/games/tron/joystick/joystick.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

import '../direction.dart';

class TronGame extends FlameGame with HasTappables {

  List<List<bool>> isOccupied = List.generate(MySharedPreferences.tronGridSize, (index) => List.generate(MySharedPreferences.tronGridSize, (index) => false));
  MyGame myGame = MyGame();

  @override
  Future<void>? onLoad() {
    add(Background());
    add(Joystick());
    add(myGame);
    overlays.add("SettingsButton");
    return super.onLoad();
  }

  void gameOver() {
    overlays.remove('PlayPauseButton');
    overlays.add('SettingsButton');
    overlays.add('GameOver');
  }

  void win() {
    myGame.motorbike.direction = Direction.idle;
    overlays.remove('PlayPauseButton');
    overlays.add('SettingsButton');
    overlays.add('Win');
  }

  void reset() {
    isOccupied = List.generate(MySharedPreferences.tronGridSize, (index) => List.generate(MySharedPreferences.tronGridSize, (index) => false));
    remove(myGame);
    myGame = MyGame();
    add(myGame);
    overlays.remove('GameOver');
    overlays.remove('Win');
  }

  void removeIaMotorbike(IaMotorbike iaMotorbike) {
    int index = myGame.iaMotorbikes.indexOf(iaMotorbike);
    myGame.remove(myGame.iaMotorbikes[index]);
    myGame.iaMotorbikes.removeAt(index);
    for (List<int> i in iaMotorbike.cases) {
      isOccupied[i[0]][i[1]] = false;
    }
    if (myGame.iaMotorbikes.isEmpty) {
      win();
    }
  }
}