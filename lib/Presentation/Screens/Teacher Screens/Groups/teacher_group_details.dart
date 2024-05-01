import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/responsive.dart';
import 'package:quiz_maker/Constants/widget.dart';
import 'package:quiz_maker/Presentation/Screens/Teacher%20Screens/Groups/group_settings.dart';
import '../../../../Constants/styles.dart';
import '../../../../Data/Models/comment_model.dart';
import '../../../../Data/Models/exam_model.dart';
import '../../../../Data/Models/group.dart';
import '../../../../Data/Models/post_model.dart';
import '../../../../Data/Models/user.dart';
import '../../posts/post_create.dart';
import '../questions bank/create_quiz.dart';

class TeacherGroupDetails extends StatefulWidget {
  TeacherGroupDetails({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  State<TeacherGroupDetails> createState() => _TeacherGroupDetailsState();
}

class _TeacherGroupDetailsState extends State<TeacherGroupDetails> {
  // String groupName;
  TextEditingController messageController = TextEditingController();
  List<CommentModel> comments=[];
  getAllPosts() {
    FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(postsCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          for (var element in value.docs) {
            posts.add(PostModel.fromMap(element.data()));
          }
        });
      }
    });
  }

  getAllQuizzes() {
    FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(quizCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          for (var element in value.docs) {
            exams.add(ExamModel.fromMap(element.data()));
          }
        });
      }
    });
  }
  getComments(String postId) {
    FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(postsCollection)
        .doc(postId).collection('comments').get().then((value) {
      for(var element in value.docs){
        setState(() {

          comments
              .add(CommentModel.fromMap(element.data()));});
      }

            });
  }

  List<PostModel> posts = [];
  List<ExamModel> exams = [];

  @override
  void initState() {

    getAllPosts();
    super.initState();
  }

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
          backgroundColor: Colors.transparent,
          title: Text(
            widget.group.name,
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.menu,
          children: [
            SpeedDialChild(
                child: Icon(Icons.edit),
                label: 'Create post',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PostCreate(
                              groupId: widget.group.id,
                            )),
                  );
                }),
            SpeedDialChild(
              child: Icon(Icons.lightbulb_outline),
              label: 'Create a quiz',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Create_Quiz(groupId: widget.group.id!,)),
                );
              },
            ),
            SpeedDialChild(
                child: Icon(Icons.settings),
                label: 'Group Settings',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => GroupSettings(
                                group: widget.group,
                              )));
                }),
          ],
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
                    Navigator.of(context).pushNamed(quizeScreen);
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
                itemCount: posts.length,
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
                          backgroundImage:posts[index].teacher?.photoUrl !=null? NetworkImage(posts[index].teacher!.photoUrl!):AssetImage(profileAsset) as ImageProvider,
                        ),
                        title: Text(posts[index].teacher!.name),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width(context) * 0.07),
                        child: Text(
                          posts[index].content,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width(context) * 0.07),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  // for comment
                                   await getComments(posts[index].id!).then((value) {
                                     showModalBottomSheet(
                                       backgroundColor: Colors.white,
                                       isScrollControlled: true,
                                       context: context,
                                       builder: (context) => Padding(
                                         padding: EdgeInsets.only(
                                             top: height(context) * 0.1),
                                         child: commentTextField(
                                             context,
                                             comments,
                                             posts[index].id!,
                                         ),
                                       ),
                                     );
                                   });

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
}
