import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker/Constants/styles.dart';

import '../../../../Constants/Strings.dart';

class Add_Questions extends StatefulWidget {
  const Add_Questions({super.key});

  @override
  State<Add_Questions> createState() => _Add_QuestionsState();
}

class _Add_QuestionsState extends State<Add_Questions> {
  final question = TextEditingController();
  final option1 = TextEditingController();
  final option2 = TextEditingController();
  final option3 = TextEditingController();
  final option4 = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? difficulty;

  int? correctAnswer;

  final text = 20.0;

  bool isMcq = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text(
          "Add Questions",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        centerTitle: true,
        elevation: 1,
        actions: [
          Text(
            isMcq ? "MCQ" : 'T/F',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Switch(
            value: isMcq,
            onChanged: (value) {
              setState(() {
                isMcq = !isMcq;
                difficulty = null;
                correctAnswer = null;
              });
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 243, 243, 1),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
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
                      fontSize: text,
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
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: question,
                  decoration: const InputDecoration(
                    hintText: 'Question',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.question_mark,
                      color: Colors.black,
                    ),
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid question';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: text,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                isMcq ? buildMcqFields(width) : buildTFFields(width),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      addQuestion();
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
                        "Add Question",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: text,
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

  buildOptionFiled(IconData icon, TextEditingController controter, String hint,
      bool enabled) {
    return TextFormField(
      controller: controter,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: enabled ? Colors.grey : Colors.black,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
          size: 25,
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
      validator: (value) {
        if (value == null || value.isEmpty && enabled) {
          return 'enter a valid option';
        } else if (value.isEmpty && !enabled) {
          setState(() {
            option1.text = 'True';
            option2.text = 'False';
          });
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
        fontSize: text,
      ),
    );
  }

  buildMcqFields(double width) {
    return Column(
      children: [
        buildOptionFiled(Icons.looks_one_outlined, option1, 'Option 1', true),
        SizedBox(
          height: 40,
        ),
        buildOptionFiled(Icons.looks_two_outlined, option2, 'Option 2', true),
        SizedBox(
          height: 40,
        ),
        buildOptionFiled(Icons.looks_3_outlined, option3, 'Option 3', true),
        SizedBox(
          height: 40,
        ),
        buildOptionFiled(Icons.looks_4_outlined, option4, 'Option 4', true),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Correct Answer",
                style: TextStyle(
                    fontSize: text,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  width: width / 3,
                  child: DropdownButtonFormField<int>(
                    value: correctAnswer,
                    onChanged: (value) {
                      setState(() {
                        correctAnswer = value;
                      });
                    },
                    hint: Text("Answer"),
                    items: ['1', '2', '3', '4']
                        .map(
                          (type) => DropdownMenuItem(
                            value: int.parse(type),
                            child: Text(
                              type,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: text,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Correct Answer',
                      hintStyle: TextStyle(
                        color: Colors.tealAccent,
                      ),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildTFFields(double width) {
    return Column(
      children: [
        buildOptionFiled(Icons.check, option1, "True", false),
        SizedBox(
          height: 40,
        ),
        buildOptionFiled(Icons.close, option2, "False", false),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Correct Answer",
                style: TextStyle(
                    fontSize: text,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  width: width / 3,
                  child: DropdownButtonFormField<int>(
                    value: correctAnswer,
                    onChanged: (value) {
                      setState(() {
                        correctAnswer = value;
                      });
                    },
                    hint: Text("Answer"),
                    items: ["True", "False"]
                        .map(
                          (type) => DropdownMenuItem(
                            value: type == "True" ? 0 : 1,
                            child: Text(
                              type,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: text,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Correct Answer',
                      hintStyle: TextStyle(
                        color: Colors.tealAccent,
                      ),
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
                      if (correctAnswer == null) {
                        return 'Enter a valid option';
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void addQuestion() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(difficulty);
      print(question.text);
      print(option1.text);
      print(option2.text);
      print(option3.text);
      print(option4.text);
      print(correctAnswer);
      if (isMcq) {
        Navigator.pop(context, {
          'difficulty': difficulty,
          'question': question.text,
          'option1': option1.text,
          'option2': option2.text,
          'option3': option3.text,
          'option4': option4.text,
          'correctAnswer': correctAnswer,
        });
      } else {
        Navigator.pop(context, {
          'difficulty': difficulty,
          'question': question.text,
          'option1': option1.text,
          'option2': option2.text,
          'correctAnswer': correctAnswer,
        });
      }
    }
  }
}
