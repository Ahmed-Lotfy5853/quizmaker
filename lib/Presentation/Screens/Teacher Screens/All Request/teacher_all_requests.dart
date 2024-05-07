import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../Constants/Strings.dart';
import '../../../../Data/Models/group.dart';
import '../../../../Data/Models/requests.dart';
import '../../../../Data/Models/user.dart';

class TeacherAllRequestsPage extends StatefulWidget {
  TeacherAllRequestsPage({super.key});

  @override
  State<TeacherAllRequestsPage> createState() => _TeacherAllRequestsPageState();
}

class _TeacherAllRequestsPageState extends State<TeacherAllRequestsPage> {
  double height(BuildContext context, double height) =>
      MediaQuery.sizeOf(context).height * height;

  double width(BuildContext context, double width) =>
      MediaQuery.sizeOf(context).width * width;

  double textFontSize(BuildContext context, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize);
  List<Request> teachersRequests = [];
  List<Request> studentsRequests = [];
  bool isTeacherSelected = true;
  List<Group> teacherGroups = [];

  @override
  void initState() {
    super.initState();
    fetchAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTeacherSelected = true;
                  });
                },
                child: Container(
                  height: height(context, 0.06),
                  width: width(context, 0.5),
                  color: isTeacherSelected ? Colors.teal : Colors.grey,
                  child: Center(
                      child: Text(
                    'Teachers',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isTeacherSelected = false;
                  });
                },
                child: Container(
                  height: height(context, 0.06),
                  width: width(context, 0.5),
                  color: isTeacherSelected ? Colors.grey : Colors.teal,
                  child: Center(
                      child: Text(
                    'Students',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
            ],
          ),
          if (isTeacherSelected)
            SizedBox(
              height: height(context, 0.6),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return requestItem(
                      teachersRequests[index], isTeacherSelected);
                },
                padding: EdgeInsets.only(top: 10),
                itemCount: teachersRequests.length,
              ),
            ),
          if (!isTeacherSelected)
            SizedBox(
                height: height(context, 0.6),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return requestItem(
                        studentsRequests[index], isTeacherSelected);
                  },
                  padding: EdgeInsets.only(top: 10),
                  itemCount: studentsRequests.length,
                ))
        ],
      ),
    );
  }

  Widget requestButton(
      {required String text, required void Function() tap, Color? color}) {
    {
      return Expanded(
        child: InkWell(
          onTap: tap,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Container(
              height: height(context, 0.06),
              color: color ?? Colors.red,
              alignment: Alignment.center,
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              )),
        ),
      );
    }
  }

  Widget requestItem(Request requestModel, bool isTeacher) {
    log(requestModel.groupId);
    log(teacherGroups.length.toString());

    Group? group =
        !teacherGroups.any((element) => element.id == requestModel.groupId) ||
                teacherGroups.isEmpty
            ? null
            : teacherGroups
                .firstWhere((element) => element.id == requestModel.groupId);
    log(group.toString());
    return InkWell(
      onTap: () {
        log('profile');
      },
      child: Container(
        width: width(context, 1),
        color: Colors.grey.shade200,
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: group != null
                  ? NetworkImage(
                      group.image!,
                    )
                  : AssetImage(profileAsset) as ImageProvider,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " ${requestModel.name}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    children: [
                      Text(
                        "Wants To Join",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                        group?.name.toString() ?? '',
                        style: Theme.of(context).textTheme.titleMedium!,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      requestButton(
                          text: "Accept",
                          tap: () {
                            acceptRequest(requestModel, isTeacher);
                            log('reApply');
                          },
                          color: Colors.green),
                      requestButton(
                          text: "Remove",
                          tap: () {
                            rejectRequest(requestModel, isTeacher);
                            log('remove');
                          },
                          color: Colors.red),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Request>> getStudentRequests(String teacherId) async {
    try {
      List<Request> requests = [];
      await FirebaseFirestore.instance
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(studentRequestsCollection)
          .get()
          .then((value) {
        for (var element in value.docs) {
          print("element ${element.data()}");
          if (element.data()["isPending"] == true) {
            requests.add(Request.fromMap(element.data()));
          }
        }
      });
      return requests;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Request>> getTeacherRequests(String teacherId) async {
    try {
      List<Request> requests = [];
      await FirebaseFirestore.instance
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(teacherRequestsCollection)
          .get()
          .then((value) {
        print("value ${value.docs}");
        for (var element in value.docs) {
          print("element ${element.data()}");
          if (element.data()["isPending"] == true) {
            print("element ${element.data()}");
            requests.add(Request.fromMap(element.data()));
          }
        }
      });
      return requests;
    } catch (e) {
      rethrow;
    }
  }

  fetchGroups(String groupId) async {
    try {
      await FirebaseFirestore.instance
          .collection(groupsCollection)
          .doc(groupId)
          .get()
          .then((value) {
        if (value.data() != null) {
          teacherGroups.add(Group.fromMap(value.data()!));
          setState(() {});
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  void fetchAllRequests() async {
    teachersRequests = await getTeacherRequests(current_user.uid!);
    studentsRequests = await getStudentRequests(current_user.uid!);
    print("teachersRequests ${teachersRequests.length}");
    print("studentsRequests ${studentsRequests.length}");
    for (var request in teachersRequests) {
      fetchGroups(request.groupId);
    }
    for (var request in studentsRequests) {
      fetchGroups(request.groupId);
    }
    setState(() {});
  }

  void acceptRequest(Request requestModel, bool isTeacher) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(requestModel.groupId);
    try {
      await docRef.get().then((value) {
        List<dynamic> currentArray =
            List.from(value.get(isTeacher ? 'teachers' : 'students') ?? []);

        currentArray.add(requestModel.userId);

        docRef.update({isTeacher ? 'teachers' : 'students': currentArray});

        print('Element added to the end of the Firestore array successfully.');

        FirebaseFirestore.instance
            .collection(teachersCollection)
            .doc(current_user.uid!)
            .collection(isTeacher
                ? teacherRequestsCollection
                : studentRequestsCollection)
            .doc(requestModel.id)
            .update({
          "isPending": false,
        });

        var ref = FirebaseFirestore.instance
            .collection(isTeacher ? teachersCollection : studentsCollection)
            .doc(requestModel.userId);

        ref.get().then((value) {
          List<dynamic> currentArray = List.from(value.get("groups") ?? []);
          currentArray.add(requestModel.groupId);
          ref.update({"groups": currentArray}).then((value) {
            if (!isTeacher) {
              FirebaseFirestore.instance
                  .collection(studentsCollection)
                  .doc(requestModel.userId)
                  .collection(studentRequestsCollection)
                  .doc(requestModel.id)
                  .update({
                "isPending": false,
              });
            }
            return;
          });
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  void rejectRequest(Request requestModel, bool isTeacher) async {
    try {
      await FirebaseFirestore.instance
          .collection(teachersCollection)
          .doc(current_user.uid!)
          .collection(
              isTeacher ? teacherRequestsCollection : studentRequestsCollection)
          .doc(requestModel.id)
          .update({
        "isPending": null,
      });
      if (!isTeacher) {
        FirebaseFirestore.instance
            .collection(studentsCollection)
            .doc(requestModel.userId)
            .collection(studentRequestsCollection)
            .doc(requestModel.id)
            .update({
          "isPending": null,
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}
