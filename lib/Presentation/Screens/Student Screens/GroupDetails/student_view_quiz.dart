import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Data/Models/comment_model.dart';
import 'package:quiz_maker/Data/Models/group.dart';
import 'package:quiz_maker/Data/Models/user.dart';

import '../../../../Constants/Strings.dart';
import '../../../../Constants/styles.dart';
import '../../../../Data/Models/exam_model.dart';
import 'package:local_auth/local_auth.dart';

class StudentViewQuiz extends StatefulWidget {
  const StudentViewQuiz(
      {super.key,
      required this.exam,
      required this.group,
      required this.currentUser,
      required this.teachers,
      required this.students});

  final UserModel currentUser;
  final ExamModel exam;
  final Group group;
  final List<UserModel> teachers;
  final List<UserModel> students;

  @override
  State<StudentViewQuiz> createState() => _StudentViewQuizState();
}

class _StudentViewQuizState extends State<StudentViewQuiz> {
  List<CommentModel> comments = [];
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  Future<List<CommentModel>> getComments(String groupId) async {
    print("in the get comments");
    print(groupId);
    print(widget.exam.id);
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(groupId)
        .collection(quizCollection)
        .doc(widget.exam.id)
        .collection(commentsCollection)
        .get()
        .then((value) {
      print("docs" + value.docs.length.toString());

      for (var element in value.docs) {
        comments.add(CommentModel.fromMap(element.data()));
      }
    });

    return comments;
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.exam.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          child: Column(
            children: [
              Container(
                height: 330,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: buildColumn(height, width),
              ),
              SizedBox(height: 20),
              Container(
                height: 330,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Comments: ",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 210,
                        child: comments.length == 0
                            ? Center(
                                child: Text(
                                "No comments yet",
                                style: TextStyle(fontSize: 20),
                              ))
                            : ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                shrinkWrap: true,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  UserModel? commentedUser =
                                      getUserInfo(comments[index].userId);
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          commentedUser!.photoUrl != null
                                              ? NetworkImage(
                                                  commentedUser.photoUrl!)
                                              : AssetImage(profileAsset)
                                                  as ImageProvider,
                                    ),
                                    title: Text(commentedUser.name),
                                    subtitle: Text(comments[index].comment),
                                  );
                                },
                              ),
                      ),
                      Form(
                        key: formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: commentController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please write a comment";
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: "Comment",
                                  hintText: "Write a Comment",
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  addComment();
                                },
                                icon: Icon(Icons.send, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
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

  void addComment() async {
    if (formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection(groupsCollection)
          .doc(widget.group.id)
          .collection(quizCollection)
          .doc(widget.exam.id)
          .collection(commentsCollection)
          .add(CommentModel(
            comment: commentController.text.trim(),
            userId: widget.currentUser.uid!,
            isTeacher: widget.currentUser.isTeacher,
          ).toMap())
          .then((value) {
        comments.add(CommentModel(
            comment: commentController.text.trim(),
            userId: widget.currentUser.uid!,
            isTeacher: widget.currentUser.isTeacher));
      });
      formKey.currentState!.reset();
      setState(() {});
    }
  }

  void getAllData() async {
    await getComments(widget.group.id!);
    setState(() {});
  }

  UserModel? getUserInfo(String id) {
    for (var teacher in widget.teachers) {
      if (teacher.uid == id) {
        return teacher;
      }
    }

    print("Teacher not found, checking if student...");

    for (var student in widget.students) {
      if (student.uid == id) {
        return student;
      }
    }

    return null;
  }

  buildColumn(double height, double width) {
    int? studentResult = null;
    log(widget.currentUser.uid!);
    log(widget.exam.results!.length.toString());
    for (Map<String, dynamic> result in widget.exam.results!) {
      log(result.toString());
      if (result.containsKey(widget.currentUser.uid)) {
        studentResult = result["${widget.currentUser.uid}"];
      }
    }
    // student did not take the quiz
    if (widget.exam.results!.isEmpty || studentResult == null) {
      bool studentCanStart = false;
      if (DateTime.parse(widget.exam.startAt.toString())
          .isBefore(DateTime.now())) {
        if (DateTime.parse(widget.exam.endAt.toString())
            .isAfter(DateTime.now())) {
          studentCanStart = true;
        }
      }

      return Column(
        children: [
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              "Starts at: ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              formatDateString(widget.exam.startAt.toString()),
              style: TextStyle(fontSize: 25),
            )
          ]),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Ends at: ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                formatDateString(widget.exam.endAt.toString()),
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text(
              "Timer: ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.exam.timer.toString() + " minutes.",
              style: TextStyle(fontSize: 25),
            ),
          ]),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              if (studentCanStart) {
                /*
                Navigator.of(context).pushNamed(
                  studentViewQuizScreen,
                );

                 */
                getFaceId();
              }
            },
            child: Container(
              height: height / 12,
              width: width / 1.5,
              decoration: BoxDecoration(
                color: studentCanStart ? firstColor : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Start Quiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              )),
            ),
          ),
        ],
      );
    } else {
      return Container(
        width: double.infinity,
        child: Center(
          child: Text(
            "Your Score: " +
                studentResult.toString() +
                " / " +
                (widget.exam.easyQuestions +
                        widget.exam.mediumQuestions +
                        widget.exam.hardQuestions)
                    .toString(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = "${dateTime.day}/${dateTime.month}";
    String formattedTime =
        "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
    String period = dateTime.hour < 12 ? 'am' : 'pm';
    if (dateTime.hour > 12) {
      formattedTime =
          "${dateTime.hour - 12}:${dateTime.minute.toString().padLeft(2, '0')}";
    } else if (dateTime.hour == 0) {
      formattedTime = "12:${dateTime.minute.toString().padLeft(2, '0')}";
    }
    return "$formattedDate $formattedTime $period";
  }

  void getFaceId() async {
    if (await auth.isDeviceSupported()) {
      try {
        bool authenticated = await auth.authenticate(
          localizedReason:
              'Authenticate to access the quiz', // Reason to show to the user
        );
        if (authenticated) {
          // User authenticated successfully
          print('Authentication successful');
          Navigator.of(context).pushNamed(startQuizScreen, arguments: {
            "exam": widget.exam,
            "group": widget.group,
          });
        } else {
          // Authentication failed
          print('Authentication failed');
        }
      } catch (e) {
        // An error occurred during authentication
        print('Error: $e');
      }
    } else {
      // Device does not support biometric authentication
      print('Biometric authentication not supported');
    }
  }
}
