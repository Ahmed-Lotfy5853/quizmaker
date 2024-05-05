class UserModel {
  late final String name;
  late final String email;
  String? uid;
  String? photoUrl;
  late bool isTeacher;
  late List<dynamic>? groups;

  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.isTeacher,
    this.groups,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'uid': this.uid,
      'cover': this.photoUrl,
      'isTeacher': this.isTeacher,
      'groups': this.groups,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      photoUrl: map['cover'] as String?,
      isTeacher: map['isTeacher'] as bool,
      groups:
          (map['groups'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? photoUrl,
    bool? isTeacher,
    List<String>? groups,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoUrl: photoUrl ?? this.photoUrl,
      isTeacher: isTeacher ?? this.isTeacher,
      groups: groups ?? this.groups,
    );
  }
}
