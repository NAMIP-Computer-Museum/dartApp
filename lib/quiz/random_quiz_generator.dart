import 'dart:math';

import 'package:get/get.dart';
import 'package:nam_ip_museum/data/api_data.dart';
import 'package:nam_ip_museum/models/person.dart';

import '../data/codes.dart';
import '../models/quiz_infos.dart';

class RandomQuizGenerator {
  final int numberOfQuestions;
  final String difficulty;
  final int numberOfAnswers;

  bool _isLoaded = false;
  final List<String> questionsTypesFR = [
    "Quand est né {person}",
    "Quand est décédé {person}",
    "Quelle est le prénom de {lastname}",
    "D'où vient {person}"
  ];
  final List<String> questionsTypesEN = [
    "Quand est né {person}",
    "Quand est décédé {person}",
    "Quelle est le prénom de {lastname}",
    "D'où vient {person}"
  ];
  final List<String> questionsTypesNL = [
    "Quand est né {person}",
    "Quand est décédé {person}",
    "Quelle est le prénom de {lastname}",
    "D'où vient {person}"
  ];
  
  late final List<String> questionsTypes = Get.locale?.languageCode == 'fr' ? questionsTypesFR : Get.locale?.languageCode == 'nl' ? questionsTypesNL : questionsTypesEN;

  RandomQuizGenerator({required this.numberOfQuestions, required this.difficulty, this.numberOfAnswers = 4});

  Future<List<QuizInfos>> generateQuiz() async {
    if (!_isLoaded) {
      await ApiData.loadAllPersons();
      _isLoaded = true;
    }
    final data = ApiData.persons;
    final List<QuizInfos> quiz = [];
    for (int i = 0; i < numberOfQuestions; i++) {
      final int randomPerson = Random().nextInt(data.length);
      final int randomQuestion = Random().nextInt(questionsTypes.length);
      final Person person = data[randomPerson];
      quiz.add(generateQuestion(person, randomQuestion));
    }
    return quiz;
  }

  QuizInfos generateQuestion(Person person, int randomQuestion) {
    String answer = "";
    List<String> answers = [];
    switch (randomQuestion) {
      case 0:
        answer = person.birthdate.substring(person.birthdate.length - 4);
        answers = generateAnswersDate(int.parse(answer), difficulty);
        break;
      case 1:
        answer = person.birthdate.substring(person.birthdate.length - 4);
        answers = generateAnswersDate(int.parse(answer), difficulty);
        break;
      case 2:
        answer = person.firstname;
        answers = generateAnswersFirstname(answer, difficulty);
        break;
      case 3:
        answer = getNameCountry(person.country);
        answers = generateAnswersCountry(answer, difficulty);
        break;
      default:
        break;
    }
    return QuizInfos(
      img: person.photos.isEmpty ? "" : person.photos[0],
      question: questionsTypes[randomQuestion].replaceAll("{person}", "${person.firstname} ${person.lastname}").replaceAll("{lastname}", person.lastname),
      answers: answers,
      answer: answer
    );
  }

  List<String> generateAnswersDate(int answer, String difficulty) {
    List<String> answers = [];
    final int numberOfOthersAnswers = numberOfAnswers - 1;
    if (difficulty == "difficult") {
      int date = answer - numberOfOthersAnswers;
      int random = Random().nextInt(numberOfOthersAnswers);
      date += random;
      for (int i = 0 ; i < numberOfOthersAnswers ; i++) {
        if (!(date == answer)) {
          answers.add(date.toString());
        } else {
          i--;
        }
        date++;
      }
    } else {
      //
    }
    answers.add(answer.toString());
    answers.sort();
    return answers;
  }

  List<String> generateAnswersFirstname(String answer, String difficulty) {
    List<String> answers = [];
    List<Person> copyData = List.from(ApiData.persons);
    copyData.removeWhere((element) => element.firstname == answer);
    final int numberOfOthersAnswers = numberOfAnswers - 1;
    if (difficulty == "difficult") {
      for (int i = 0 ; i < numberOfOthersAnswers ; i++) {
        int random = Random().nextInt(copyData.length);
        if (!(answers.contains(copyData[random].firstname))) {
          answers.add(copyData[random].firstname);
          copyData.removeAt(random);
        } else {
          i--;
        }
      }
    } else {
      //
    }
    answers.add(answer);
    answers.shuffle();
    return answers;
  }

  List<String> generateAnswersCountry(String answer, String difficulty) {
    List<String> answers = [];
    List<Person> copyData = List.from(ApiData.persons);
    copyData.removeWhere((element) => getNameCountry(element.country) == answer);
    final int numberOfOthersAnswers = numberOfAnswers - 1;
    if (difficulty == "difficult") {
      for (int i = 0 ; i < numberOfOthersAnswers ; i++) {
        int random = Random().nextInt(copyData.length);
        if (!(answers.contains(getNameCountry(copyData[random].country)))) {
          answers.add(getNameCountry(copyData[random].country));
        } else {
          i--;
        }
        copyData.removeAt(random);
        if (copyData.isEmpty) {
          break;
        }
      }
    } else {
      //
    }
    answers.add(answer);
    answers.shuffle();
    return answers;
  }

  String getNameCountry(String code) {
    return codes[code]![Get.locale?.languageCode.toUpperCase()] ?? "";
  }
}