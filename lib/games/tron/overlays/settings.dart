import 'package:flutter/material.dart';
import 'package:nam_ip_museum/games/tron/game/my_game.dart';
import 'package:nam_ip_museum/games/tron/tron_game.dart';

import 'horizontal_picker.dart';

class Settings extends StatefulWidget {

  final TronGame game;

  const Settings({Key? key, required this.game}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

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
                      const Text("IA :", style: TextStyle(color: Colors.white, fontSize: 17)),
                      Expanded(
                        child: HorizontalPicker(
                          data: const ["Facile", "Moyen", "Difficile"],
                          controller: FixedExtentScrollController(initialItem: 0),
                          height: 60,
                          activeItemTextColor: Colors.white,
                          passiveItemsTextColor: Colors.amber,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
