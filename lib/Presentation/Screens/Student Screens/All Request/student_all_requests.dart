import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../Constants/Strings.dart';
import '../../../../Data/Models/group.dart';
import '../../../../Data/Models/requests.dart';
import '../../../../Data/Models/user.dart';

class StudentAllRequestsPage extends StatefulWidget {
  StudentAllRequestsPage({super.key});

  @override
  State<StudentAllRequestsPage> createState() => _StudentAllRequestsPageState();
}

class _StudentAllRequestsPageState extends State<StudentAllRequestsPage> {
  double height(BuildContext context, double height) =>
      MediaQuery.sizeOf(context).height * height;

  double width(BuildContext context, double width) =>
      MediaQuery.sizeOf(context).width * width;

  double textFontSize(BuildContext context, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize);
  List<Request> studentsRequests = [];
  List<Group> requestedGroups = [];

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
          SizedBox(
            height: height(context, 0.6),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return requestItem(studentsRequests[index], false);
              },
              padding: EdgeInsets.only(top: 10),
              itemCount: studentsRequests.length,
            ),
          ),
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
    log(requestedGroups.length.toString());

    Group? group =
        !requestedGroups.any((element) => element.id == requestModel.groupId) ||
                requestedGroups.isEmpty
            ? null
            : requestedGroups
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
                    "${requestModel.name}",
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
                      requestButton(
                          text: requestModel.isPending == null
                              ? "Rejected"
                              : requestModel.isPending!
                                  ? "Pending"
                                  : "Rejected",
                          color: requestModel.isPending == null
                              ? Colors.red
                              : requestModel.isPending!
                                  ? Colors.green
                                  : Colors.red,
                          tap: () {})
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Request>> getStudentRequests() async {
    try {
      List<Request> requests = [];
      await FirebaseFirestore.instance
          .collection(studentsCollection)
          .doc(current_user.uid)
          .collection(studentRequestsCollection)
          .get()
          .then((value) {
        for (var element in value.docs) {
          print("element ${element.data()}");
          if (element.data()["isPending"] != false) {
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
          requestedGroups.add(Group.fromMap(value.data()!));
          setState(() {});
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  void fetchAllRequests() async {
    studentsRequests = await getStudentRequests();
    print("studentsRequests ${studentsRequests.length}");
    for (var request in studentsRequests) {
      fetchGroups(request.groupId);
    }
    setState(() {});
  }
}
