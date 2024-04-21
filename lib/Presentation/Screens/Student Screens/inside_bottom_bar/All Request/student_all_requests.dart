
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../Constants/Strings.dart';
import '../../../Teacher Screens/teacher_all_requests.dart';

class StudentAllRequestsPage extends StatefulWidget {
  const StudentAllRequestsPage({super.key});

  @override
  State<StudentAllRequestsPage> createState() => _StudentAllRequestsPageState();
}

class _StudentAllRequestsPageState extends State<StudentAllRequestsPage> {
  double height (BuildContext context,double height)=> MediaQuery.sizeOf(context).height*height;
  double width (BuildContext context,double width)=> MediaQuery.sizeOf(context).width*width;
  double textFontSize (BuildContext context,double fontSize)=> MediaQuery.textScalerOf(context).scale(fontSize);
  List<RequestModel> requests=[
    RequestModel(name: 'Mechanics', cover: onboardAsset, requestDate: '22/04/2024', group: 'Accepted'),
    RequestModel(name: 'Mechanics', cover: onboardAsset, requestDate: '22/04/2024', group: 'Accepted'),
    RequestModel(name: 'Mechanics', cover: onboardAsset, requestDate: '22/04/2024', group: 'Accepted'),
  ];
  bool isTeacherSelected=false;
  List<String> accountTypes=['Teacher','Student'];
  @override
  Widget build(BuildContext context) {


    return  SafeArea(
      child: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
        child: ListView.builder(itemBuilder: (context, index) {
          return  requestItem(requests[index]);
        },
        
          padding: EdgeInsets.only(top:10),itemCount: requests.length,),
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
  Widget requestItem(RequestModel requestModel
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
          Image.asset(requestModel.cover,width: width(context,0.3),fit: BoxFit.cover,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" ${requestModel.name}",style: Theme.of(context).textTheme.headlineSmall,),
                Row(
                  children: [
                    Text(" ${requestModel.requestDate}",style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.grey),),
                    Expanded(child: Text("  ${requestModel.group}",style: Theme.of(context).textTheme.titleMedium!,)),

                  ],
                ),
                Row(
                  children: [
                    requestButton(text: "ReApply", tap: (){
                      log('reApply');
                    }, color: Colors.green),
                    requestButton(text: "Remove", tap: (){
                      log('remove');
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