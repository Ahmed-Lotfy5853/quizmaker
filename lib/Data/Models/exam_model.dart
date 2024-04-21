import 'package:quiz_maker/Data/Models/comment_model.dart';

class ExamModel {


  String? id;
  String name;
  String createdAt;
  Map<String, int>questions;
  Map<String, int>?results;
  String? startAt;
  int timer;
  String? endAt;
  List<CommentModel> comments;

  ExamModel({
    this.id,
    required this.name,
    required this.createdAt,
    required this.questions,
    this.results,
    required this.timer,
    this.startAt,
    this.endAt,
    required this.comments
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'created_at': this.createdAt,
      'questions': this.questions,
      'results': this.results,
      'start_at': this.startAt,
      'timer': this.timer,
      'end_at': this.endAt,
      'comments': this.comments,
    };
  }

  factory ExamModel.fromMap(Map<String, dynamic> map) {
    return ExamModel(
      id: map['id'] as String,
      name: map['name'] as String,
      createdAt: map['created_at'] as String,
      questions: map['questions'] as Map<String, int>,
      results: map['results'] as Map<String, int>,
      startAt: map['start_at'] as String,
      timer: map['timer'] as int,
      endAt: map['end_at'] as String,
      comments: map['comments'] as List<CommentModel>,
    );
  }

  ExamModel copyWith({
    String? id,
    String? name,
    String? createdAt,
    Map<String, int>? questions,
    Map<String, int>? results,
    String? startAt,
    int? timer,
    String? endAt,
    List<CommentModel>? comments,
  }) {
    return ExamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      questions: questions ?? this.questions,
      results: results ?? this.results,
      startAt: startAt ?? this.startAt,
      timer: timer ?? this.timer,
      endAt: endAt ?? this.endAt,
      comments: comments ?? this.comments,
    );
  }
}