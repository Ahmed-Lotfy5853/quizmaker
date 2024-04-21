import 'package:quiz_maker/Data/Models/user.dart';

class Requests{
  String id;
  String name;
  String groupId;
  bool isPending;
  UserModel? userId;

  Requests({
    required this.id,
    required this.name,
    required this.groupId,
    required this.isPending,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'groupId': this.groupId,
      'isPending': this.isPending,
      'userId': this.userId,
    };
  }

  factory Requests.fromMap(Map<String, dynamic> map) {
    return Requests(
      id: map['id'] as String,
      name: map['name'] as String,
      groupId: map['groupId'] as String,
      isPending: map['isPending'] as bool,
      userId: map['userId'] as UserModel,
    );
  }

  Requests copyWith({
    String? id,
    String? name,
    String? groupId,
    bool? isPending,
    UserModel? userId,
  }) {
    return Requests(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      isPending: isPending ?? this.isPending,
      userId: userId ?? this.userId,
    );
  }
}