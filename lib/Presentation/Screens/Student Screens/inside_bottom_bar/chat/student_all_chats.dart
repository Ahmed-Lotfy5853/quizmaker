import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';

import '../../../../../Data/Models/chat_model.dart';
import '../../../../../Data/Models/messages_model.dart';
import '../../../../../Data/Models/user.dart';
import '../../Teacher Screens/chat/chat_details.dart';

class StudentAllChats extends StatefulWidget {
  const StudentAllChats({super.key});

  @override
  State<StudentAllChats> createState() => _StudentAllChatsState();
}

class _StudentAllChatsState extends State<StudentAllChats> {
  double height(BuildContext context, double height) =>
      MediaQuery.sizeOf(context).height * height;
  double width(BuildContext context, double width) =>
      MediaQuery.sizeOf(context).width * width;
  double textFontSize(BuildContext context, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize);
  List<ChatModel> allChats = [
    ChatModel(
        user: UserModel(
            name: 'Mohamed',
            email: 'aa@a.com',
            uid: 'hjdshbjk',
            photoUrl: 'jdsk',
            isTeacher: true),
        lastMessage: MessageModel(
          message: 'hello',
          time: DateTime.now().toString().substring(0, 19),
        ),
        id: '',
        messages: []),
    ChatModel(
        user: UserModel(
            name: 'Ahmed',
            email: 'aa@a.com',
            uid: 'hjdshbjk',
            photoUrl: onboardAsset,
            isTeacher: true),
        id: 'hjsdhj',
        lastMessage: MessageModel(
          message: 'hello',
          time: DateTime.now().toString().substring(0, 19),
        ),
        messages: []),
  ];
  bool isTeacherSelected = false;
  List<String> accountTypes = ['Teacher', 'Student'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return chatItem(allChats[index]);
          },
          padding: EdgeInsets.only(top: 10),
          itemCount: allChats.length,
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

  Widget chatItem(ChatModel chatModel) => InkWell(
        onTap: () {
          log('chat');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetails(chat: chatModel)));
        },
        child: Container(
          width: width(context, 1),
          color: Colors.grey.shade200,
          margin: EdgeInsets.only(
            bottom: 10,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Container(
                width: width(context, 0.1),
                height: width(context, 0.1),
                margin: EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(chatModel.user?.photoUrl ??
                            "assets/images/profile_place_holder.png"),
                        fit: BoxFit.fill)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " ${chatModel.user?.name}",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "  ${chatModel.lastMessage.isMe ?? false ? 'You:' : ''}${chatModel.lastMessage.message}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                  ],
                ),
              ),
              Text(
                " ${chatModel.lastMessage.time}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
}
