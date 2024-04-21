import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';

import '../../../../Data/Models/user.dart';
import '../../Student Screens/inside_bottom_bar/chat/student_all_chats.dart';
import 'chat_details.dart';

class TeacherAllChats extends StatefulWidget {
  const TeacherAllChats({super.key});

  @override
  State<TeacherAllChats> createState() => _TeacherAllChatsState();
}

class _TeacherAllChatsState extends State<TeacherAllChats> {
  double height (BuildContext context,double height)=> MediaQuery.sizeOf(context).height*height;
  double width (BuildContext context,double width)=> MediaQuery.sizeOf(context).width*width;
  double textFontSize (BuildContext context,double fontSize)=> MediaQuery.textScalerOf(context).scale(fontSize);
  List<ChatModel> allChats=[
ChatModel(user:
UserModel(name: 'Mohamed', email: 'aa@a.com', uid: 'hjdshbjk', photoUrl: onboardAsset, isTeacher: true), chatId:'hjsdhj' , lastMessage: MessageModel(message: 'hello', time: DateTime.now().toString().substring(0,19), sender: UserModel(name: 'Mohamed', email: 'aa@a.com', uid: 'hjdshbjk', photoUrl: 'jdsk', isTeacher: true), receiver: UserModel(name: 'Mohamed', email: 'aa@a.com', uid: 'hjdshbjk', photoUrl: 'jdsk', isTeacher: true))) ,
ChatModel(user:
UserModel(name: 'Ahmed', email: 'aa@a.com', uid: 'hjdshbjk', photoUrl: onboardAsset, isTeacher: true), chatId:'hjsdhj' , lastMessage: MessageModel(message: 'hello', time: DateTime.now().toString().substring(0,19), sender: UserModel(name: 'Mohamed', email: 'aa@a.com', uid: 'hjdshbjk', photoUrl: 'jdsk', isTeacher: true), receiver: UserModel(name: 'Mohamed', email: 'aa@a.com', uid: 'hjdshbjk', photoUrl: 'jdsk', isTeacher: true))) ,

  ];
  bool isTeacherSelected=false;
  List<String> accountTypes=['Teacher','Student'];
  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              requestButton(text: accountTypes[0], tap: () {
                setState(() {
                  isTeacherSelected = true;
                });
              },color: isTeacherSelected?Colors.grey:Colors.grey.shade400),
              requestButton(text: accountTypes[1], tap: () {
                setState(() {
                  isTeacherSelected = false;
                });
              },color: !isTeacherSelected?Colors.grey:Colors.grey.shade400),
            ],
          ),

          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return  chatItem(allChats[index]);
            },

              padding: EdgeInsets.only(top:10),itemCount: allChats.length,),
          ),
        ],
      ),
    );
  }
  Widget requestButton({required String text,required void Function() tap,Color? color }){ {
    return                   Expanded(
      child: InkWell(
        onTap: tap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Container(
            height: height(context,0.06),
            color: color??Colors.red,
            alignment: Alignment.center,
            child: Text(text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
            )
        ),
      ),
    );

  }
  }
  Widget chatItem(ChatModel chatModel
      )=>InkWell(
          onTap: (){
      log('chat');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDetails( chat: chatModel)));

          },
          child: Container(
      width: width(context, 1),
      color: Colors.grey.shade200,
      margin: EdgeInsets.only(
        bottom: 10,

      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,

        children: [
          Container(
            width:width(context,0.1) ,
            height:width(context,0.1) ,
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(chatModel.user.photoUrl),
                fit: BoxFit.fill
              )
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" ${chatModel.user.name}",maxLines:1,overflow: TextOverflow.clip,style: Theme.of(context).textTheme.titleMedium,),
                Text("  ${chatModel.lastMessage.sender.name=='Ahmed'?'You:':''}${chatModel.lastMessage.message}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!,),



              ],),
          ),
          Text(" ${chatModel.lastMessage.time}",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey),),

        ],
      ),
          ),
        );
}
