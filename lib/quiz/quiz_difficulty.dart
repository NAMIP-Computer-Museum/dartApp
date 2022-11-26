import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum_web/quiz/quiz.dart';
import 'package:nam_ip_museum_web/quiz/quiz_with_generator_questions.dart';

import '../utils/widgets.dart';

class QuizDifficulty extends StatelessWidget {
  const QuizDifficulty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Widgets.containerWithBinaryBackground(
        child: Center(
          child: FittedBox(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 40.0,
              ),
              width: 0.4 * width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: FittedBox(
                      child: Text("choixDuNiveau".tr, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Quiz(difficulty: 'easy',))),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(child: Text("facile".tr, style: const TextStyle(fontSize: 20, color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizWithGeneratorQuestions(difficulty: 'difficult',))),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(child: Text("difficile".tr, style: const TextStyle(fontSize: 20, color: Colors.white))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
