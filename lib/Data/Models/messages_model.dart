
class MessageModel {
  String message;
  bool? isMe;
  String time;

  MessageModel({
    required this.message,
    this.isMe,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'isMe': this.isMe,
      'time': this.time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      isMe: map['isMe'] as bool,
      time: map['time'] as String,
    );
  }

  MessageModel copyWith({
    String? message,
    bool? isMe,
    String? time,
  }) {
    return MessageModel(
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
    );
  }
}
