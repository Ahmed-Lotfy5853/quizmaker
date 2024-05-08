import 'package:quiz_maker/Data/Models/post_model.dart';
import 'package:quiz_maker/Data/Models/question.dart';

import 'exam_model.dart';

class Group {
  String? id;
  String name;
  String? image;
  String description;
  List<String>? teachers;
  List<String>? students;
  String? createdBy;
  String createdAt;

  Group({
    this.id,
    required this.name,
    required this.image,
    required this.description,
    this.teachers,
    this.students,
    required this.createdBy,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'description': this.description,
      'teachers': this.teachers,
      'students': this.students,
      'created_by': this.createdBy,
      'created_at': this.createdAt,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      name: map['name'] as String,
      image: map['image'] as String?,
      description: map['description'] as String,
      teachers: (map['teachers'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      students: (map['students'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      createdBy: map['created_by'] as String?,
      createdAt: map['created_at'] as String,
    );
  }

  Group copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    List<String>? teachers,
    List<String>? students,
    String? createdBy,
    String? createdAt,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      teachers: teachers ?? this.teachers,
      students: students ?? this.students,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
