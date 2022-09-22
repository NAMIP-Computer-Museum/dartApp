import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/quiz/final_screen_quiz.dart';

import '../models/quiz_infos.dart';
import '../utils/widgets.dart';

class Quiz extends StatefulWidget {
  final String difficulty;

  const Quiz({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  int avancement = 0;
  bool isCorrect = false;
  int pointQuiz = 0;

  List<QuizInfos> quiz = List.empty(growable: true);
  List<int> quizAnswers = List.empty(growable: true);

  void setQuizAnswers() {
    quizAnswers = List.empty(growable: true);
    for (int i = 0; i < quiz[avancement].answers.length ; i++) {
      quizAnswers.add(0);
    }
  }

  Future<void> readJson() async {
    String stringData = "";
    String stringImagesData = "";
    switch (widget.difficulty) {
      case "easy":
        stringData = "assets/data/quizDataForKids.json";
        stringImagesData = "assets/data/quizImagesDataForKids.json";
        break;
      case "difficult":
        stringData = "assets/data/quizData.json";
        stringImagesData = "assets/data/quizImagesData.json";
        break;
      default :
        break;
    }
    final String response = await rootBundle.loadString(stringData);
    final List<dynamic> data = await json.decode(response);
    data.shuffle();
    final String imagesDataResponse = await rootBundle.loadString(stringImagesData);
    final Map<String, dynamic> imagesData = await json.decode(imagesDataResponse);
    setState(() {
      for (int i = 0; i < 10; i++) {
        quiz.add(QuizInfos(
          question: data[i]['question'],
          img: imagesData[data[i]['idImage'].toString()],
          answers: data[i]['allChoices'],
          answer: data[i]['answer'],
        ));
      }
      setQuizAnswers();
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Builder(
        builder: (context) {
          if (quiz.isNotEmpty) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/binaryBackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: (avancement + 1) / 10,
                            color: Colors.yellow,
                            backgroundColor: Colors.black,
                            minHeight: 15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("${avancement + 1} / 10", style: const TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(quiz[avancement].question, textAlign: TextAlign.center ,style: const TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.7, maxHeight: height * 0.25),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(quiz[avancement].img))
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (!isCorrect) {
                                setState(() {
                                  if (quiz[avancement].answer == quiz[avancement].answers[index]) {
                                    isCorrect = true;
                                    quizAnswers[index] = 1;
                                    if (!quizAnswers.contains(2)) {
                                      pointQuiz++;
                                    }
                                  } else {
                                    isCorrect = false;
                                    quizAnswers[index] = 2;
                                    if (quizAnswers.indexOf(0) == quizAnswers.lastIndexOf(0)) {
                                      isCorrect = true;
                                      quizAnswers[quizAnswers.indexOf(0)] = 1;
                                    }
                                  }
                                });
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                border: quizAnswers[index] == 0 ? Border.all(color: const Color.fromRGBO(109, 7, 26, 1), width: 3)
                                    : quizAnswers[index] == 1 ? Border.all(color: Colors.green.shade900, width: 3)
                                    : Border.all(color: Colors.red, width: 3),
                                color: quizAnswers[index] == 0 ? Colors.red.shade900 : quizAnswers[index] == 1 ? Colors.green.withOpacity(0.3) : Colors.red.shade900.withOpacity(0.3),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(quiz[avancement].answers[index], style: const TextStyle(color: Colors.white, fontSize: 17)),
                                    quizAnswers[index] == 2 ?
                                    const CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(Icons.close_rounded, color: Colors.white),
                                    )
                                        : quizAnswers[index] == 1 ?
                                    const CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: Icon(Icons.check, color: Colors.white),
                                    )
                                        : const SizedBox(width: 0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: quiz[avancement].answers.length,
                    ),
                  ),
                  isCorrect ? GestureDetector(
                    onTap: () {
                      setState(() {
                        if (avancement < 9) {
                          avancement++;
                          setQuizAnswers();
                          isCorrect = false;
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => FinalScreenQuiz(score: pointQuiz, difficulty: widget.difficulty,)));
                        }
                      });
                    },
                    child: Container(
                      width: width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: Colors.red.shade800,
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("suite".tr, style: const TextStyle(color: Colors.white, fontSize: 20)),
                          )
                      ),
                    ),
                  ) : const SizedBox(width: 0),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      )
    );
  }
}
