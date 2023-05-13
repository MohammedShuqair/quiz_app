class Question {
  final int id;
  final String title;
  final List<String> answers;
  final int correctIndex;

  Question({
    required this.id,
    required this.title,
    required this.answers,
    required this.correctIndex,
  });

  static Question fromMap(Map<String, dynamic> query) {
    return Question(
      id: query['id'],
      title: query['title'],
      answers: [query['first'],query['second'],query['third'],query['fourth']],
      correctIndex: query['correct'],
    );
  }

  static List<Question> list = [
    Question(
      id: 1,
      title: "What sadsdsgasdfasdfasdfasdf ?",
      answers: ['a', 'b', 'c', 'd'],
      correctIndex: 1,
    ),
    Question(
      id: 1,
      title: "how sadsdsgasdfasdfasdfasdf ?",
      answers: ['a', 'b', 'c', 'd'],
      correctIndex: 2,
    ),
    Question(
      id: 1,
      title: "when sadsdsgasdfasdfasdfasdf ?",
      answers: ['a', 'b', 'c', 'd'],
      correctIndex: 3,
    ),
  ];
}
