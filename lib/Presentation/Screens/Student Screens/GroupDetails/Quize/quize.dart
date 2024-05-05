import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/widget.dart';

import '../../../../../Constants/Strings.dart';
import '../../../../../Constants/responsive.dart';
import '../../../../../Constants/styles.dart';
import '../../../../../Data/Models/comment_model.dart';
import '../../../../../Data/Models/group.dart';
import '../../../../../Data/Models/user.dart';

class QuizeView extends StatefulWidget {
  const QuizeView({super.key, required this.group});

  final Group group;

  @override
  State<QuizeView> createState() => _QuizeViewState();
}

class _QuizeViewState extends State<QuizeView> {
  TextEditingController messageController = TextEditingController();

  Future<UserModel?> getProfile(String uId, BuildContext context) async {
    FirebaseFirestore.instance
        .collection(studentsCollection)
        .doc(uId)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          print("student");
          log('student ${data['email']}');

          return UserModel(
            uid: uId,
            email: data['email'],
            name: data['name'],
            photoUrl: data['cover'],
            isTeacher: data['isTeacher'],
            groups: data['groups'] ?? [],
          );
        } else {
          FirebaseFirestore.instance
              .collection(teachersCollection)
              .doc(uId)
              .get()
              .then(
            (DocumentSnapshot doc) {
              final Map<String, dynamic>? data =
                  doc.data() as Map<String, dynamic>?;
              if (data != null) {
                print("teacher");
                log('teacher ${data['email']}');
                return UserModel(
                  uid: uId,
                  email: data['email'],
                  name: data['name'],
                  photoUrl: data['cover'],
                  isTeacher: data['isTeacher'],
                  groups: data['groups'] ?? [],
                );

                print(current_user!.isTeacher);
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('User not found')));
              }
            },
            onError: (e) => print("Error getting document: $e"),
          );
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
    print(current_user!.name);
    return null;
  }

  Widget commentTextField(context, List<CommentModel> comments, String postId) {
    List<UserModel>? users;
    for (int i = 0; i < comments.length; i++) {
      getProfile(comments[i].userId, context).then((value) {
        if (value != null)
          setState(() {
            users?[i] = value;
          });
      });
    }
    ;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: comments.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(groupAsset),
                ),
                title: Text(users![index].name),
                subtitle: Text(comments[index].comment),
                // trailing: Text(comments[index].),
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: width(context) * 0.06),
                  hintText: "Write Comment...",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: firstColor, width: 1),
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(height(context) * 0.09),
                        left: Radius.circular(height(context) * 0.09)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: firstColor, width: 1),
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(height(context) * 0.07),
                        left: Radius.circular(height(context) * 0.07)),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  (users ?? []).add(current_user!);
                  comments.add(CommentModel(
                      comment: messageController.text.trim(),
                      userId: current_user!.uid!,
                      isTeacher: current_user!.isTeacher));
                });
                FirebaseFirestore.instance
                    .collection(groupsCollection)
                    .doc(widget.group.id)
                    .collection(postsCollection)
                    .doc(postId)
                    .collection(commentsCollection)
                    .add(CommentModel(
                            comment: messageController.text.trim(),
                            userId: current_user!.uid!,
                            isTeacher: current_user!.isTeacher)
                        .toMap());
              },
              icon: Container(
                width: height(context) * 0.07,
                height: height(context) * 0.07,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Start Quize'),
          ),
        ],
      ),
      /* body: commentTextField(
            context,
            comments!,
            id!)*/
    );
  }
}
