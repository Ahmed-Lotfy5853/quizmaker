import 'package:quiz_maker/Data/Models/user.dart';

import 'comment_model.dart';

class PostModel{
  String? id;
  String content;
  String? image;
  UserModel? teacher;
  List<CommentModel>? comments;

  PostModel({
    this.id,
    required this.content,
    this.image,
    this.teacher,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'content': this.content,
      'image': this.image,
      'teacher': this.teacher?.toMap(),
      'comments': this.comments,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['uid'] as String?,
      content: map['content'] as String,
      image: map['image'] as String,
      teacher:   UserModel.fromMap(map['teacher']),
      comments: map["comments"] == null
          ? []
          :List<CommentModel>.from((map['comments']?? {})?.map((x) => CommentModel.fromMap(x))),
    );
  }

  PostModel copyWith({
    String? id,
    String? content,
    String? image,
    UserModel? teacher,
    List<CommentModel>? comments,
  }) {
    return PostModel(
      id: id ?? this.id,
      content: content ?? this.content,
      image: image ?? this.image,
      teacher: teacher ?? this.teacher,
      comments: comments ?? this.comments,
    );
  }
}