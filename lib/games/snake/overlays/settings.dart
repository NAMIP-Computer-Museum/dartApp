import 'package:flutter/material.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../utils/my_shared_preferences.dart';
import '../game/game_background.dart';

class Settings extends StatefulWidget {

  final SnakeGame game;


  const Settings({Key? key, required this.game}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  double _snakeSpeed = MySharedPreferences.snakeSpeed;
  int _gridSize = MySharedPreferences.snakeGridSize;
  int _appleCount = MySharedPreferences.appleCount;
  bool _isClassicSnake = MySharedPreferences.isClassicSnake;
  final FixedExtentScrollController _gridSizeController = FixedExtentScrollController(initialItem: MySharedPreferences.snakeGridSize - 8);
  final FixedExtentScrollController _appleCountController = FixedExtentScrollController(initialItem: MySharedPreferences.appleCount - 1);
  final FixedExtentScrollController _isClassicSnakeController = FixedExtentScrollController(initialItem: (MySharedPreferences.isClassicSnake) ? 0 : 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(GameBackground.padding / 2),
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
                          value: _snakeSpeed,
                          min: 0.1,
                          max: 1,
                          divisions: 9,
                          onChanged: (double value) {
                            setState(() {
                              _snakeSpeed = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      const Text("Grid Size:", style: TextStyle(fontSize: 17, color: Colors.white)),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 40,
                        width: 150, // TODO: Make this responsive
                        child: WheelChooser.integer(
                          controller: _gridSizeController,
                          horizontal: true,
                          onValueChanged: (i) => _gridSize = i,
                          maxValue: 20,
                          minValue: 8,
                          step: 1,
                          unSelectTextStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          selectTextStyle: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      const Text("Apple count:", style: TextStyle(fontSize: 17, color: Colors.white)),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 40,
                        width: 130, //TODO: make this dynamic
                        child: WheelChooser.custom(
                          startPosition: null,
                          controller: _appleCountController,
                          horizontal: true,
                          onValueChanged: (i) => _appleCount = i + 1,
                          children: [
                            Image.asset("assets/images/apple.png", height: 15, width: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                const SizedBox(width: 3),
                                Image.asset("assets/images/apple.png", height: 15, width: 15,),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                    const SizedBox(width: 3),
                                    Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Image.asset("assets/images/apple.png", height: 15, width: 15,),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                    const SizedBox(width: 3),
                                    Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                    const SizedBox(width: 3),
                                    Image.asset("assets/images/apple.png", height: 15, width: 15,),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      const Text("Design:", style: TextStyle(fontSize: 17, color: Colors.white)),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 40,
                        width: 150, // TODO: Make this responsive
                        child: WheelChooser.custom(
                          startPosition: null,
                          controller: _isClassicSnakeController,
                          horizontal: true,
                          onValueChanged: (i) => _isClassicSnake = (i == 0),
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                color: Colors.white,
                                width: 30,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await MySharedPreferences.updateSnakeSpeed(_snakeSpeed);
                            await MySharedPreferences.updateSnakeGridSize(_gridSize);
                            await MySharedPreferences.updateAppleCount(_appleCount);
                            await MySharedPreferences.updateIsClassicSnake(_isClassicSnake);
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
                            _snakeSpeed = 0.5;
                            _gridSize = 15;
                            _appleCount = 1;
                            _isClassicSnake = false;
                            _gridSizeController.animateToItem(7, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            _appleCountController.animateToItem(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            _isClassicSnakeController.animateToItem(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
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
