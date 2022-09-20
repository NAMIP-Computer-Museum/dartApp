class QuizInfos {
  final String img;
  final String question;
  final List<dynamic> answers;
  final String answer;
  QuizInfos({required this.img, required this.question, required this.answers, required this.answer});

  @override
  String toString() {
    return "Question: $question\nanswer: $answer\nanswers: $answers\n";
  }
}