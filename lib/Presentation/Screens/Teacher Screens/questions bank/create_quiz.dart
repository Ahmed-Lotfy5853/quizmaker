import 'package:flutter/material.dart';

class Create_Quiz extends StatefulWidget {
  const Create_Quiz({super.key});

  @override
  State<Create_Quiz> createState() => _Create_QuizState();
}

class _Create_QuizState extends State<Create_Quiz> {
  String? difficulty;

  final tf_question_count = TextEditingController();
  final mcq_question_count = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Create Quiz",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButtonFormField<String>(
                    value: difficulty,
                    onChanged: (value) {
                      setState(() {
                        difficulty = value;
                      });
                    },
                    hint: Text("Difficulty"),
                    items: ['Hard', 'Medium', "Easy"]
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(
                                type,
                                style: TextStyle(color: Colors.black),
                              ),
                            ))
                        .toList(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
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
                    validator: (value) {
                      if (difficulty == null) {
                        return 'select difficulty';
                      }
                    }),
                SizedBox(height: 40),
                buidRow("T/F Questions", tf_question_count, "5"),
                SizedBox(height: 40),
                buidRow("MCQ Questions", mcq_question_count, "5"),
                SizedBox(height: 40),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      createQuiz();
                    },
                    child: Container(
                      height: height / 12,
                      width: width / 2,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        "Create Quiz",
                        style: TextStyle(
                          color: Colors.black,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter a number or Zero';
          }
        },
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
      // ToDo : create quiz
    }
  }
}
