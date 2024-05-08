import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Data/Models/comment_model.dart';
import 'package:quiz_maker/Data/Models/group.dart';
import 'package:quiz_maker/Data/Models/user.dart';
import 'package:quiz_maker/Constants/strings.dart';

import '../../../../Data/Models/exam_model.dart';

class ViewQuiz extends StatefulWidget {
  const ViewQuiz(
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
  State<ViewQuiz> createState() => _ViewQuizState();
}

class _ViewQuizState extends State<ViewQuiz> {
  List<CommentModel> comments = [];
  late ExamModel examModel;
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();

  Future<List<CommentModel>> getComments(String groupId) async {
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(groupId)
        .collection(quizCollection)
        .doc(widget.exam.id)
        .collection(commentsCollection)
        .get()
        .then((value) {
      for (var element in value.docs) {
        comments.add(CommentModel.fromMap(element.data()));
      }
    });

    return comments;
  }

  @override
  void initState() {
    examModel = widget.exam;
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(
          examModel.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Students who took the quiz:",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: examModel.results?.isEmpty ?? true
                          ? Center(
                              child: Text(
                              "No Students yet",
                              style: TextStyle(fontSize: 20),
                            ))
                          : ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                UserModel? student = getUserInfo(
                                    examModel.results![index].keys.first);

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: student!.photoUrl != null
                                        ? NetworkImage(student.photoUrl!)
                                        : AssetImage(profileAsset)
                                            as ImageProvider,
                                    radius: 20,
                                  ),
                                  title: Text(
                                    (index + 1).toString() +
                                        ". " +
                                        student.name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  trailing: Text(
                                    examModel.results![index][
                                            "${examModel.results![index].keys.first}"]
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                              itemCount: examModel.results!.length,
                            ),
                    ),
                  ],
                ),
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
    await getExam();
    await getComments(widget.group.id!);
    setState(() {});
  }

/*
  getPhotoUrl(bool isTeacher , String id) async {
    if (isTeacher) {
      return teachers
    }
  }

 */

  UserModel? getUserInfo(String id) {
    for (var teacher in widget.teachers) {
      if (teacher.uid == id) {
        return teacher;
      }
    }

    print("Teacher not found, checking if student...");

    for (var student in widget.students) {
      if (student.uid == id) {
        print("Student found");
        return student;
      }
    }

    print("Student not found");

    return null;
  }

  getExam() async {
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(quizCollection)
        .doc(widget.exam.id)
        .get()
        .then((value) {
      setState(() {
        examModel = ExamModel.fromMap(value.data()!);
      });
    });
  }
}
