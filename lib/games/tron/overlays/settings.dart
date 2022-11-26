import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/games/tron/game/my_game.dart';
import 'package:nam_ip_museum_web/games/tron/tron_game.dart';

import '../../../utils/my_shared_preferences.dart';
import 'horizontal_picker.dart';

class Settings extends StatefulWidget {

  final TronGame game;

  const Settings({Key? key, required this.game}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final List<String> difficulties = ['Easy', 'Medium', 'Hard'];
  final List<int> gridSizes = List.generate(21, (index) => index + 10);

  int _tronSpeed = MySharedPreferences.tronSpeed;
  int _gridSize = MySharedPreferences.tronGridSize;
  int _playerCount = MySharedPreferences.tronPlayerCount;
  String _difficulty = MySharedPreferences.tronDifficulty;
  late final FixedExtentScrollController _gridSizeController = FixedExtentScrollController(initialItem: gridSizes.indexOf(MySharedPreferences.tronGridSize));
  final FixedExtentScrollController _playerCountController = FixedExtentScrollController(initialItem: MySharedPreferences.tronPlayerCount - 1);
  late final FixedExtentScrollController _difficultyController = FixedExtentScrollController(initialItem: difficulties.indexOf(MySharedPreferences.tronDifficulty));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(MyGame.padding / 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/binaryBackground.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text("Speed:", style: TextStyle(fontSize: 17, color: Colors.white)),
                      Expanded(
                        child: Slider(
                          value: _tronSpeed.toDouble(),
                          min: 30,
                          max: 70,
                          divisions: 40,
                          onChanged: (double value) {
                            setState(() {
                              _tronSpeed = value.toInt();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      const Text("IA :", style: TextStyle(color: Colors.white, fontSize: 17)),
                      Expanded(
                        child: HorizontalPicker(
                          data: difficulties,
                          controller: _difficultyController,
                          height: 40,
                          itemExtent: 80,
                          onChanged: (index) {
                            _difficulty = difficulties[index];
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      const Text("Grid Size :", style: TextStyle(color: Colors.white, fontSize: 17)),
                      Expanded(
                        child: HorizontalPicker(
                          data: gridSizes,
                          controller: _gridSizeController,
                          height: 40,
                          onChanged: (index) {
                            _gridSize = gridSizes[index];
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      const Text("Players :", style: TextStyle(color: Colors.white, fontSize: 17)),
                      Expanded(
                        child: HorizontalPicker(
                          data: const [1, 2, 3],
                          controller: _playerCountController,
                          height: 40,
                          onChanged: (index) {
                            _playerCount = index + 1;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await MySharedPreferences.updateTronSpeed(_tronSpeed);
                            await MySharedPreferences.updateTronGridSize(_gridSize);
                            await MySharedPreferences.updateTronPlayerCount(_playerCount);
                            await MySharedPreferences.updateTronDifficulty(_difficulty);
                            widget.game.overlays.remove("Settings");
                            widget.game.reset();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.play_circle, color: Colors.white),
                                SizedBox(width: 5),
                                Text("Jouer", style: TextStyle(fontSize: 17, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _tronSpeed = 40;
                            _gridSize = 20;
                            _playerCount = 1;
                            _difficulty = 'Medium';
                            _difficultyController.animateToItem(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            _gridSizeController.animateToItem(gridSizes.indexOf(20), duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            _playerCountController.animateToItem(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.red.shade700,
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Icon(Icons.refresh, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
