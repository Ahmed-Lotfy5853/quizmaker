import 'package:quiz_maker/Data/Models/comment_model.dart';

class ExamModel {
  String? id;
  String name;
  String createdAt;
  int easyQuestions;
  int mediumQuestions;
  int hardQuestions;
  List<dynamic>? results;
  String? startAt;
  int timer;
  String? endAt;

  ExamModel({
    this.id,
    required this.name,
    required this.createdAt,
    required this.easyQuestions,
    required this.mediumQuestions,
    required this.hardQuestions,
    this.results,
    required this.timer,
    this.startAt,
    this.endAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'quizName': this.name,
      'createdAt': this.createdAt,
      'easyQuestions': this.easyQuestions,
      'mediumQuestions': this.mediumQuestions,
      'hardQuestions': this.hardQuestions,
      'results': this.results,
      'startDate': this.startAt,
      'timer': this.timer,
      'endDate': this.endAt,
    };
  }

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['id'] as String,
      name: map['quizName'] as String,
      createdAt: map['createdAt'] as String,
      easyQuestions: int.parse(map['easyQuestions']),
      mediumQuestions: int.parse(map['mediumQuestions']),
      hardQuestions: int.parse(map['hardQuestions']),
      results: map['students'] as List<dynamic>?,
      startAt: map['startDate'] as String,
      timer: int.parse(map['timer']),
      endAt: map['endDate'] as String,
    );
  }

  ExamModel copyWith({
    String? id,
    String? name,
    String? createdAt,
    int? easyQuestions,
    int? mediumQuestions,
    int? hardQuestions,
    List<dynamic>? results,
    String? startAt,
    int? timer,
    String? endAt,
  }) {
    return ExamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      easyQuestions: easyQuestions ?? this.easyQuestions,
      mediumQuestions: mediumQuestions ?? this.mediumQuestions,
      hardQuestions: hardQuestions ?? this.hardQuestions,
      results: results ?? this.results,
      startAt: startAt ?? this.startAt,
      timer: timer ?? this.timer,
      endAt: endAt ?? this.endAt,
    );
  }
}
