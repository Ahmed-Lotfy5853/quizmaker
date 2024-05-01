import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Constants/styles.dart';

import '../../../../Constants/Strings.dart';

class Create_Quiz extends StatefulWidget {
  const Create_Quiz({super.key, required this.groupId});
final String groupId;
  @override
  State<Create_Quiz> createState() => _Create_QuizState();
}

class _Create_QuizState extends State<Create_Quiz> {
  String? difficulty;

  final quizName = TextEditingController();
  final easyQuestions = TextEditingController();
  final  mediumQuestions= TextEditingController();
  final  hardQuestions= TextEditingController();
  final  timer= TextEditingController();
  final  startDate= TextEditingController();
  final  endDate= TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 40,),
                    Text("Create Quiz" , style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold),),
                    SizedBox(height: 40),
                    buidRow("Quiz Name", easyQuestions, ""),
                     SizedBox(height: 40),
                    buidRow("Easy Questions", quizName, ""),
                    SizedBox(height: 40),
                    buidRow("Medium Questions", mediumQuestions, ""),
                    SizedBox(height: 50),
                    buidRow("Hard Questions", hardQuestions, ""),
                    SizedBox(height: 50),
                    buidRow("Timer", timer, ""),
                    SizedBox(height: 50),
                    buidRow("Start Date", startDate, ""),
                    SizedBox(height: 50),
                    buidRow("End Date", endDate, ""),
                    SizedBox(height: 50),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          createQuiz();
                        },
                        child: Container(
                          height: height / 12,
                          width: width / 2,
                          decoration: BoxDecoration(
                            color: firstColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(
                                "Create Quiz",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  buidRow(String s, TextEditingController controter, String hint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buildNumberFiled(controter, hint),
      ],
    );
  }

  buildNumberFiled(TextEditingController controter, String hint) {
    return SizedBox(
      width: 70,
      child: TextFormField(
        controller: controter,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        keyboardType: TextInputType.number,

        onChanged: (value) {
          setState(() {
            controter.text = value;
          });
        },
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  void createQuiz() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      FirebaseFirestore.instance.collection(groupsCollection).doc(widget.groupId).collection(quizCollection).add({
        'easyQuestions': easyQuestions.text,
        'quizName': quizName.text,
        'mediumQuestions': mediumQuestions.text,
        'hardQuestions': hardQuestions.text,
        'timer': timer.text,
        'startDate': startDate.text,
        'endDate': endDate.text,
      }).then((value) {
        Navigator.pop(context);
      });
    }
  }
}
