import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/responsive.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Constants/widget.dart';
import 'package:quiz_maker/Presentation/Screens/Student%20Screens/GroupDetails/Quize/quize.dart';

import '../../../../Data/Models/comment_model.dart';
import '../../../../Data/Models/exam_model.dart';
import '../../../../Data/Models/group.dart';
import '../../../../Data/Models/post_model.dart';
import '../../../../Data/Models/user.dart';

class StudentGroupDetails extends StatefulWidget {
  StudentGroupDetails({
    super.key,
    required this.group,
  });
  final Group group;

  @override
  State<StudentGroupDetails> createState() => _StudentGroupDetailsState();
}

class _StudentGroupDetailsState extends State<StudentGroupDetails> {
  TextEditingController messageController = TextEditingController();
  List<PostModel> posts = [];
  List<ExamModel> exams = [];
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
                      userId: current_user!.uid!));
                });
                FirebaseFirestore.instance
                    .collection(groupsCollection)
                    .doc(widget.group.id)
                    .collection(postsCollection)
                    .doc(postId)
                    .collection('comments')
                    .add(CommentModel(
                            comment: messageController.text.trim(),
                            userId: current_user!.uid!)
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

  // String groupName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Name Group',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // for quiz
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, int index) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(teacherViewQuizScreen);
                  },
                  child: Card(
                    child: Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (bool? value) {},
                        ),
                        title: Text('"Name Quize"'),
                        trailing: Text("From   to    "),
                      ),
                    ),
                  ),
                ),
              ),
              // for post
              ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, int index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(groupAsset),
                        ),
                        title: Text('Name Teacher'),
                        trailing: Text("10:30 PM"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width(context) * 0.07),
                        child: Text(
                            "Checkbox in flutter is a material design widget. It is always used in the Stateful Widget as it does not maintain a state of its own. We can use its onChanged property to interact or modify other widgets in the flutter app. Like most of the other flutter widgets, it also comes with many properties like activeColor, checkColor, mouseCursor, etc, to let developers have full control over the widget’s look and feel."),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width(context) * 0.07),
                        child: Row(
                          children: [
                            Text('10'),
                            IconButton(
                                onPressed: () {
                                  // for comment
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => Padding(
                                      padding: EdgeInsets.only(
                                          top: height(context) * 0.1),
                                      child: commentTextField(
                                        context,
                                        posts[index].comments!,
                                        posts[index].id!,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.chat)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
