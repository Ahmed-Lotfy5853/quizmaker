import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_maker/Bussiness%20Logic/Cubit/Requests/requests_cubit.dart';

import '../../../../../Constants/Strings.dart';
import '../../../../Data/Models/requests.dart';
import '../teacher_all_requests.dart';

class StudentAllRequestsPage extends StatefulWidget {
  const StudentAllRequestsPage({super.key});

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
  List<Request> requests = [];
  bool isTeacherSelected = false;
  List<String> accountTypes = ['Teacher', 'Student'];

  @override
  void initState() {
    super.initState();
    fetchAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(backgroundAsset), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return requestItem(requests[index]);
          },
          padding: EdgeInsets.only(top: 10),
          itemCount: requests.length,
        ),
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

  Widget requestItem(Request requestModel) => InkWell(
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
              Image.network(
                requestModel.groupId!,
                width: width(context, 0.3),
                fit: BoxFit.cover,
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
                          " ${requestModel.name}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.grey),
                        ),
                        Expanded(
                            child: Text(
                          "  ${requestModel..userId}",
                          style: Theme.of(context).textTheme.titleMedium!,
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        requestButton(
                            text: "ReApply",
                            tap: () {
                              log('reApply');
                            },
                            color: Colors.green),
                        requestButton(
                            text: "Remove",
                            tap: () {
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

  void fetchAllRequests() {
    try {
      FirebaseFirestore.instance
          .collection(teachersCollection)
          .doc(current_user!.uid)
          .collection(teacherRequestsCollection)
          .get()
          .then((value) {
            log('value.docs ${value.docs[0].data()}');
        for (var element in value.docs) {
          requests.add(Request.fromMap(element.data()));
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
