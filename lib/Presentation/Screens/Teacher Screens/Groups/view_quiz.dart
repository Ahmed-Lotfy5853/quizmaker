import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker/Data/Models/comment_model.dart';
import 'package:quiz_maker/Data/Models/user.dart';
import 'package:quiz_maker/Constants/strings.dart';

import '../../../../Data/Models/exam_model.dart';

class ViewQuiz extends StatefulWidget {
  const ViewQuiz({super.key, required this.exam});

  final ExamModel exam;

  @override
  State<ViewQuiz> createState() => _ViewQuizState();
}

class _ViewQuizState extends State<ViewQuiz> {
  List<UserModel> students = [];
  List<CommentModel> comments = [];

  String getStudentName(String id) {
    return students.firstWhere((element) => element.uid == id).name;
  }

  Future<List<UserModel>> getStudents(List<String> studentIds) async {
    await FirebaseFirestore.instance
        .collection(studentsCollection)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (studentIds.contains(element.id)) {
            students.add(UserModel.fromMap(element.data()));
          }
        }
        return students;
      }
    });
    return students;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List<String> extractStrings(List<dynamic>? dataList) {
      List<String> stringList = [];
      if (dataList == null) return [];

      for (var dataMap in dataList ?? []) {
        if (dataMap.containsKey('name')) {
          stringList.add(dataMap['name'].toString());
        }
      }
      return stringList;
    }

    List<CommentModel> getComments(String groupId) {
      List<CommentModel> commentList = [];
      FirebaseFirestore.instance
          .collection(groupsCollection)
          .doc(groupId)
          .collection(quizCollection)
          .doc(widget.exam.id)
          .collection(commentsCollection)
          .get()
          .then((value) {
        for (var element in value.docs) {
          commentList.add(CommentModel.fromMap(element.data()));
        }
      });
      return commentList;
    }

    getStudents(extractStrings(widget.exam.results));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  child: Column(
                    children: [
                      Text("Students who took the quiz:"),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            /*
                            var name = getStudentName(
                                widget.exam.results![index]["id"].toString());

                             */
                            return widget.exam.results?.isEmpty ?? true
                                ? Text("No students yet")
                                : ListTile(
                                    title: Text("Ahmed Mohamed"),
                                    trailing: Text(widget
                                        .exam.results![index]["degree"]
                                        .toString()),
                                  );
                          },
                          itemCount: widget.exam.results?.length ?? 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text("Comments: "),
              Container(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(students
                        .firstWhere(
                            (element) => element.uid == comments[index].userId)
                        .name),
                    subtitle: Text(comments[index].comment),
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
