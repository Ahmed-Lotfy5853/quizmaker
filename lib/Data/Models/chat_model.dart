import 'package:quiz_maker/Data/Models/messages_model.dart';
import 'package:quiz_maker/Data/Models/user.dart';

class ChatModel{
  String id;
  MessageModel lastMessage;
  List<MessageModel> messages;
  UserModel? user;
  ChatModel({required this.id,required this.lastMessage,required this.messages,required this.user});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'lastMessage': this.lastMessage,
      'messages': this.messages,
      'user': this.user,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      lastMessage: map['lastMessage'] as MessageModel,
      messages: map['messages'] as List<MessageModel>,
      user: map['user'] as UserModel,
    );
  }

  ChatModel copyWith({
    String? id,
    MessageModel? lastMessage,
    List<MessageModel>? messages,
    UserModel? user,
  }) {
    return ChatModel(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      messages: messages ?? this.messages,
      user: user ?? this.user,
    );
  }
}