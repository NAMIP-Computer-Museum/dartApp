import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';


import '../../../utils/my_shared_preferences.dart';
import '../../tron/overlays/horizontal_picker.dart';
import '../game/game_background.dart';
import '../snake_game.dart';

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
  Color _snakeColor = MySharedPreferences.snakeColor;
  final FixedExtentScrollController _gridSizeController = FixedExtentScrollController(initialItem: MySharedPreferences.snakeGridSize - 8);
  final FixedExtentScrollController _appleCountController = FixedExtentScrollController(initialItem: MySharedPreferences.appleCount - 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(GameBackground.padding / 4),
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
                      Text("${"vitesse".tr}:", style: const TextStyle(fontSize: 17, color: Colors.white)),
                      Expanded(
                        child: Slider(
                          value: _snakeSpeed,
                          min: 0.4,
                          max: 0.9,
                          divisions: 20,
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
                      Text("${"taille_grille".tr}:", style: const TextStyle(fontSize: 17, color: Colors.white)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: HorizontalPicker(
                          controller: _gridSizeController,
                          height: 40,
                          itemExtent: 40,
                          onChanged: (i) => _gridSize = i + 8,
                          data: const ["8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"],
                        )
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      Text("${"nombre_pommes".tr}:", style: const TextStyle(fontSize: 17, color: Colors.white)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: HorizontalPicker(
                          controller: _appleCountController,
                          height: 40,
                          onChanged: (i) => _appleCount = i + 1,
                          items: [
                            Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                                const SizedBox(width: 3),
                                Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                                    const SizedBox(width: 3),
                                    Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                                    const SizedBox(width: 3),
                                    Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
                                    const SizedBox(width: 3),
                                    Image.asset("assets/images/snake/apple.png", height: 15, width: 15,),
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
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  _isClassicSnake = true;
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  color: Colors.white,
                                  width: _isClassicSnake ? 35 : 20,
                                  height: _isClassicSnake ? 35 : 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(() {
                                  _isClassicSnake = false;
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: _isClassicSnake ? 25 : 35,
                                  height: _isClassicSnake ? 25 : 35,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                  const Divider(color: Colors.white, thickness: 1, height: 30,),
                  Row(
                    children: [
                      Text("${"couleur".tr}:", style: const TextStyle(fontSize: 17, color: Colors.white)),
                      const SizedBox(width: 15),
                      Container(
                        width: 20,
                        height: 20,
                        color: _snakeColor,
                      ),
                      const SizedBox(width: 15),
                      FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: BlockPicker(
                                          pickerColor: _snakeColor,
                                          onColorChanged: (color) {
                                            setState(() {
                                              _snakeColor = color;
                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('DONE'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); //dismiss the color picker
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Text("Classique", style: TextStyle(color: Colors.white, fontSize: 15)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: _snakeColor,
                                          onColorChanged: (color) {
                                            setState(() {
                                              _snakeColor = color;
                                            });
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('DONE'),
                                          onPressed: () {
                                            Navigator.of(context).pop(); //dismiss the color picker
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Text("Custom", style: TextStyle(color: Colors.white, fontSize: 15)),
                                ),
                              ),
                            ),
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
                            await MySharedPreferences.updateSnakeColor(_snakeColor);
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
                            _snakeSpeed = 0.7;
                            _gridSize = 15;
                            _appleCount = 1;
                            _isClassicSnake = false;
                            _snakeColor = BasicPalette.blue.color;
                            _gridSizeController.animateToItem(7, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            _appleCountController.animateToItem(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
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
