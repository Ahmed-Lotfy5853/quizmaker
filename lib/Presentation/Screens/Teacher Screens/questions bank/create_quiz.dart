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
  final quizName = TextEditingController();
  final easyQuestions = TextEditingController();
  final mediumQuestions = TextEditingController();
  final hardQuestions = TextEditingController();
  final timer = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();

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
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Create Quiz",
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    buidRow("Quiz Name", quizName, "name", true),
                    SizedBox(height: 40),
                    buidRow("Easy Questions", easyQuestions, "0", false),
                    SizedBox(height: 40),
                    buidRow("Medium Questions", mediumQuestions, "0", false),
                    SizedBox(height: 50),
                    buidRow("Hard Questions", hardQuestions, "0", false),
                    SizedBox(height: 50),
                    buidRow("Timer", timer, "min.", false),
                    SizedBox(height: 50),
                    buildDatesRow("Starts At", true),
                    SizedBox(height: 50),
                    buildDatesRow("Ends At", false),
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

  Future<void> selectDateTime(BuildContext context, bool startDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ? startDateTime : endDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      print(picked.toString());
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(picked),
      );
      if (pickedTime != null) {
        print(picked.toString());
        setState(() {
          startDate
              ? startDateTime = DateTime(
                  picked.year,
                  picked.month,
                  picked.day,
                  pickedTime.hour,
                  pickedTime.minute,
                )
              : endDateTime = DateTime(
                  picked.year,
                  picked.month,
                  picked.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
          print("Now selected date time is " + startDateTime.toString());
          print("Now selected date time is " + endDateTime.toString());
        });
      }
    }
  }

  buildDatesRow(String s, bool startDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            selectDateTime(context, startDate);
          },
          child: Container(
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                startDate
                    ? startDateTime.toString().substring(0, 16)
                    : endDateTime.toString().substring(0, 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  buidRow(String s, TextEditingController controter, String hint, bool text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          s,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        buildNumberFiled(controter, hint, text),
      ],
    );
  }

  buildNumberFiled(TextEditingController controter, String hint, bool text) {
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
        keyboardType: text ? TextInputType.text : TextInputType.number,
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

  void createQuiz() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        DocumentReference doc = await FirebaseFirestore.instance
            .collection(groupsCollection)
            .doc(widget.groupId)
            .collection(quizCollection)
            .add({
          'easyQuestions': easyQuestions.text,
          'quizName': quizName.text,
          'mediumQuestions': mediumQuestions.text,
          'hardQuestions': hardQuestions.text,
          'results': [],
          'timer': timer.text,
          'startDate': startDateTime.toString().substring(0, 16),
          'endDate': endDateTime.toString().substring(0, 16),
          'createdAt': DateTime.now().toString(),
        }).then((value) {
          value.update({
            'id': value.id,
          });
          Navigator.pop(context);
          return value;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
