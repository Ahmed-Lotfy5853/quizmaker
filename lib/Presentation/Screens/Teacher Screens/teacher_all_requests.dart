import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/requests.dart';

class TeacherAllRequestsPage extends StatefulWidget {
  const TeacherAllRequestsPage({super.key});

  @override
  State<TeacherAllRequestsPage> createState() => _TeacherAllRequestsPageState();
}

class _TeacherAllRequestsPageState extends State<TeacherAllRequestsPage> {
  double height (BuildContext context,double height)=> MediaQuery.sizeOf(context).height*height;
  double width (BuildContext context,double width)=> MediaQuery.sizeOf(context).width*width;
  double textFontSize (BuildContext context,double fontSize)=> MediaQuery.textScalerOf(context).scale(fontSize);
  List<Request> requests=[

  ];
  bool isTeacherSelected=false;
  List<String> accountTypes=['Teacher','Student'];

  getRequests(int requestType)async{
    await FirebaseFirestore.instance.collection(teachersCollection).doc(current_user!.uid).collection("Requests").doc("${requestType}").collection(accountTypes[requestType]).get().then(
            (value) {
          setState(() {
            requests.
            clear();
            value.docs.forEach((element) {
              requests.add(Request.fromMap(element.data()));

            });
          });

        });
  }
@override
  void initState() {
  getRequests(0);

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
                  isTeacherSelected = true;
                });
                getRequests(0);
              },color: isTeacherSelected?Colors.grey:Colors.grey.shade400),
              requestButton(text: accountTypes[1], tap: () {
                setState(() {
                  isTeacherSelected = false;
                });
                getRequests(1);

              },color: !isTeacherSelected?Colors.grey:Colors.grey.shade400),
            ],
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return  requestItem(requests[index]);
            },

              padding: EdgeInsets.only(top:10),itemCount: requests.length,),
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
            height: height(context,0.1),
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
Widget requestItem(Request requestModel
    )=>InkWell(
  onTap: (){
    log('profile');
  },
  child: Container(
    width: width(context, 1),
    color: Colors.grey.shade200,
    margin: EdgeInsets.only(
      bottom: 10,

    ),
    padding: EdgeInsets.symmetric(horizontal: 10),
    child:  Row(
      children: [
        // ToDo add image
        Image.asset(/*requestModel.groupId??*/"assets/images/profile_place_holder.png",width: width(context,0.3),fit: BoxFit.cover,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(" ${requestModel.name}",style: Theme.of(context).textTheme.headlineSmall,),
              Row(
                children: [
                  Text(" ${requestModel.name}",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey),),
                  Expanded(child: Text("  ${requestModel.groupId}",style: Theme.of(context).textTheme.titleMedium!,)),

                ],
              ),
              Row(
                children: [
                  requestButton(text: "Accept", tap: (){
                    log('Accept');
                  }, color: Colors.green),
                 requestButton(text: "Reject", tap: (){
                    log('Reject');
                  }, color: Colors.red),
                ],
              )

            ],),
        )
      ],
    ),
  ),
);
}

