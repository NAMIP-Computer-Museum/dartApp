import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/games/quiz/quiz.dart';
import 'package:nam_ip_museum/games/snake/snake.dart';
import 'package:nam_ip_museum/games/tron/tron.dart';

import '../utils/widgets.dart';

class Games extends StatelessWidget {
  const Games({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = MediaQuery.of(context).size.height * 0.6;
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Widgets.containerWithBinaryBackground(
        child: Center(
            child: FittedBox(
              child: Container(
                width: 0.8 * width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: FittedBox(
                            child: Text("jeux".tr, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Quiz(difficulty: "easy"))),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(child: Text("quiz_facile".tr, style: const TextStyle(fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Quiz(difficulty: "difficult"))),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(child: Text("quiz_difficile".tr, style: const TextStyle(fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Snake())),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(child: Text("Snake", style: TextStyle(fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Tron())),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(child: Text("Tron", style: TextStyle(fontSize: 20, color: Colors.white))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }
}
