import 'package:quiz_maker/Data/Models/user.dart';

import 'comment_model.dart';

class PostModel {
  String? id;
  String content;
  String? image;
  UserModel? teacher;

  PostModel({
    this.id,
    required this.content,
    this.image,
    this.teacher,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'content': this.content,
      'image': this.image,
      'teacher': this.teacher?.toMap(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String?,
      content: map['content'] as String,
      image: map['image'] as String?,
      teacher: UserModel.fromMap(map['teacher']),
    );
  }

  PostModel copyWith({
    String? id,
    String? content,
    String? image,
    UserModel? teacher,
  }) {
    return PostModel(
      id: id ?? this.id,
      content: content ?? this.content,
      image: image ?? this.image,
      teacher: teacher ?? this.teacher,
    );
  }
}
