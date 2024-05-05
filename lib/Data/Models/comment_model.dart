class CommentModel {
  String comment;
  String userId;
  bool isTeacher;

  CommentModel({
    required this.comment,
    required this.userId,
    required this.isTeacher,
  });

  CommentModel copyWith({
    String? comment,
    String? userId,
    bool? isTeacher,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
      isTeacher: isTeacher ?? this.isTeacher,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': this.comment,
      'user_id': this.userId,
      'isTeacher': this.isTeacher,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: map['comment'] as String,
      userId: map['user_id'] as String,
      isTeacher: map['isTeacher'] as bool,
    );
  }
}
