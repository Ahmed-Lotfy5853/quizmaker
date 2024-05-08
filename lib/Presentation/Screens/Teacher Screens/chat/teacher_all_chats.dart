import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/chat_model.dart';
import 'package:quiz_maker/Data/Models/messages_model.dart';

import '../../../../Data/Models/user.dart';
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

  ];
  bool isTeacherSelected=false;
  List<String> accountTypes=['Teacher','Student'];
  getChats(int requestType)async{
    await FirebaseFirestore.instance.collection(teachersCollection).doc(current_user!.uid).collection("Chats").doc("${requestType}").collection(accountTypes[requestType]).get().then(
            (value) {
              log("all chats ${value.docs.length}");
          setState(() {
            allChats.
            clear();
            value.docs.forEach((element) {
              getUser(element.data()['user']).then((value) {
                allChats.add(ChatModel(id: element.data()['id'], lastMessage: MessageModel.fromMap(element.data()['lastMessage']), messages:  element.data()["messages"] == null
                    ? []
                    :List<MessageModel>.from((element.data()['messages']?? {})?.map((x) => MessageModel.fromMap(x))), user: UserModel.fromMap(value)));

              });


            });
          });
          log("all chats ${allChats.length}");

        });
  }
  Future<Map<String, dynamic>> getUser(String id)async{
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection(accountTypes[isTeacherSelected?1:0]+'s').doc(id).get();
  return documentSnapshot.data() ?? {};
  }
  @override
  void initState() {
    getChats(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              requestButton(text: accountTypes[0], tap: () {
                setState(() {
                  getChats(0);

                  isTeacherSelected = true;
                });
              },color: isTeacherSelected?Colors.grey:Colors.grey.shade400),
              requestButton(text: accountTypes[1], tap: () {
                setState(() {
                  getChats(1);

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
                image: AssetImage(chatModel.user?.photoUrl??"assets/images/profile_place_holder.png"),
                fit: BoxFit.fill
              )
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" ${chatModel.user?.name}",maxLines:1,overflow: TextOverflow.clip,style: Theme.of(context).textTheme.titleMedium,),
                Text("  ${chatModel.lastMessage.isMe??false?'You:':''}${chatModel.lastMessage.message}",
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
