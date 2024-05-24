import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_maker/Data/Models/chat_model.dart';
import 'package:quiz_maker/Data/Models/messages_model.dart';

import '../../Constants/Strings.dart';
import '../../Constants/responsive.dart';
import '../../Constants/styles.dart';
import '../../Data/Models/user.dart';
import 'Teacher Screens/chat/chat_details.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen(
      {super.key,
      required this.groupName,
      required this.teachers,
      required this.students});

  final String groupName;
  final List<UserModel> teachers;
  final List<UserModel> students;

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  double height(BuildContext context, double height) =>
      MediaQuery.sizeOf(context).height * height;

  double width(BuildContext context, double width) =>
      MediaQuery.sizeOf(context).width * width;
  List<String> accountTypes = ['Teacher', 'Student'];

  double textFontSize(BuildContext context, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize);
  bool? isTeacherSelected ;

  @override
  void initState() {
    widget.teachers.removeWhere((element) => current_user.uid==element.uid);
    widget.students.removeWhere((element) => current_user.uid==element.uid);
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
          backgroundColor: firstColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.groupName,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isTeacherSelected = true;
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Container(
                        height: height(context, 0.06),
                        color: (isTeacherSelected??true) ? Colors.grey : Colors.grey.shade400,
                        alignment: Alignment.center,
                        child: Text(
                          accountTypes[0],
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),  Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isTeacherSelected = false;
                      });
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    child: Container(
                        height: height(context, 0.06),
                        color: !(isTeacherSelected??true) ? Colors.grey : Colors.grey.shade400,
                        alignment: Alignment.center,
                        child: Text(
                          accountTypes[1],
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),

  
              ],
            ),
            Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              itemBuilder: (context, index) {
                UserModel member = (isTeacherSelected??true)
                    ? widget.teachers[index + 1]
                    : widget.students[index + 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        member.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                      if ((isTeacherSelected??true) ||
                          (!(isTeacherSelected??true) && current_user.isTeacher))
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatDetails(
                                      chat: ChatModel(
                                          id: member.uid!,
                                          user: member,
                                          lastMessage: MessageModel(
                                              message: '',
                                              isMe: true,
                                              time: DateTime.now().toString()),
                                          messages: []),
                                    ),
                                  ));
                            },
                            child: Container(
                              width: width(context, 0.2),
                              height: 50,
                              padding: EdgeInsets.all(10),

                              alignment: Alignment.center,
                  decoration: BoxDecoration(
                  color: Colors.teal,
                    borderRadius: BorderRadius.circular(10)

                  ),
                              child: Text(
                                'Chat',
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ))
                    ],
                  ),
                );
              },
              itemCount: ((isTeacherSelected??true)
                      ? widget.teachers.length
                      : widget.students.length) -
                  1,
            ))
          ],
        ),
      ),
    );
  }

/*  Widget requestButton(
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
  }*/
}
