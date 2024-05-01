class Question {
  String? id;
  String question;
  List<dynamic> answers;
  int correctAnswer;
  String level;

  Question({
    this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.level
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'question': this.question,
      'answers': this.answers,
      'correctAnswer': this.correctAnswer,
      'level': this.level,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      question: map['question'] as String,
      answers: map['answers'] as List<String>,
      correctAnswer: map['correctAnswer'] as int,
      level: map['level'] as String,
    );
  }

  Question copyWith({
    String? id,
    String? question,
    List<String>? answers,
    int? correctAnswer,
    String? level,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      level: level ?? this.level,
    );
  }
}