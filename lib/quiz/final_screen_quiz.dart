import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/quiz/quiz.dart';

import '../home_pages/home_page.dart';

class FinalScreenQuiz extends StatelessWidget {
  final int score;
  final String? difficulty;

  const FinalScreenQuiz({Key? key, required this.score, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FittedBox(
            child: Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text("scoreQuiz".tr, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text("$score / 10", style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 5),
                    score > 4 ? Text("felicitations".tr, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                      : Text("reessaye".tr, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Quiz(difficulty: difficulty)));
                      },
                      child: FittedBox(
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("reessayer".tr, style: const TextStyle(fontSize: 30, color: Colors.white)),
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        const HomePage()), (Route<dynamic> route) => false),
                      child: FittedBox(
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text("accueil".tr, style: const TextStyle(fontSize: 30, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
