class CommentModel{
  String? id;
  String comment;
  String userId;

  CommentModel({
     this.id,
    required this.comment,
    required this.userId,
  });

  CommentModel copyWith({
    String? id,
    String? comment,
    String? userId,
  }) {
    return CommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'comment': this.comment,
      'user_id': this.userId,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as String,
      comment: map['comment'] as String,
      userId: map['user_id'] as String,
    );
  }
}