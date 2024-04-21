import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/question.dart';

class Questions_Bank extends StatefulWidget {
  const Questions_Bank({super.key});

  @override
  State<Questions_Bank> createState() => _Questions_BankState();
}

class _Questions_BankState extends State<Questions_Bank> {
  bool isSearch = false;
  List<Question> questions = [
    Question(
      "What is the capital of France?",
      [
        {"answer": "Paris", "isCorrect": true},
        {"answer": "London", "isCorrect": false},
        {"answer": "Berlin", "isCorrect": false},
        {"answer": "Madrid", "isCorrect": false},
      ],
    ),
    Question(
      "What is the capital of France?",
      [
        {"answer": "Paris", "isCorrect": true},
        {"answer": "London", "isCorrect": false},
        {"answer": "Berlin", "isCorrect": false},
        {"answer": "Madrid", "isCorrect": false},
      ],
    ),
    Question(
      "What is the capital of France?",
      [
        {"answer": "Paris", "isCorrect": true},
        {"answer": "London", "isCorrect": false},
        {"answer": "Berlin", "isCorrect": false},
        {"answer": "Madrid", "isCorrect": false},
      ],
    ),
    Question(
      "What is the capital of France?",
      [
        {"answer": "Paris", "isCorrect": true},
        {"answer": "London", "isCorrect": false},
        {"answer": "Berlin", "isCorrect": false},
        {"answer": "Madrid", "isCorrect": false},
      ],
    ),
    Question(
      "What is the capital of France?",
      [
        {"answer": "Paris", "isCorrect": true},
        {"answer": "London", "isCorrect": false},
        {"answer": "Berlin", "isCorrect": false},
        {"answer": "Madrid", "isCorrect": false},
      ],
    ),
    Question(
      "What is the capital of France?",
      [
        {"answer": "Paris", "isCorrect": true},
        {"answer": "London", "isCorrect": false},
        {"answer": "Berlin", "isCorrect": false},
        {"answer": "Madrid", "isCorrect": false},
      ],
    ),
    Question(
      "What is the largest country in the world?",
      [
        {"answer": "Russia", "isCorrect": false},
        {"answer": "Canada", "isCorrect": false},
        {"answer": "China", "isCorrect": true},
      ],
    ),
    Question(
      "What is the largest country in the world?",
      [
        {"answer": "Russia", "isCorrect": false},
        {"answer": "Canada", "isCorrect": false},
        {"answer": "China", "isCorrect": true},
      ],
    ),
    Question(
      "What is the largest country in the world?",
      [
        {"answer": "true", "isCorrect": true},
        {"answer": "false", "isCorrect": false},
      ],
    ),Question(
      "What is the largest country in the world?",
      [
        {"answer": "true", "isCorrect": true},
        {"answer": "false", "isCorrect": false},
      ],
    ),
  ];

  List<Question> searchedQuestions = [];

  bool isSearcffh = false;
  final searchTextController = TextEditingController();

  Widget buildSearchfield() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: "Find a character...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      onChanged: (searchedChar) {
        createSearchedList(searchedChar);
      },
    );
  }

  void createSearchedList(String searchedChar) {
    searchedQuestions = questions
        .where(
            (element) => element.question.toLowerCase().contains(searchedChar))
        .toList();
    setState(() {});
  }

  List<Widget> buildSearchAppbarItems() {
    if (isSearch) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startseach();
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
      ];
    }
  }

  void startseach() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearch));
    setState(() {
      isSearch = true;
    });
  }

  void stopSearch() {
    clearSearch();
    setState(() {
      isSearch = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  Widget buildAppbarTitle() {
    return const Text(
      "Questions Bank",
      style: TextStyle(color: Colors.white, fontSize: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(15);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(25);

    return Scaffold(
      appBar: AppBar(
        title: isSearch ? buildSearchfield() : buildAppbarTitle(),
        centerTitle: true,
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        actions: buildSearchAppbarItems(),
      ),
      body: Container(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, addQuestions);
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 243, 243, 1),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Add new question",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Questions",
                style: TextStyle(
                    fontSize: bigTextFontsize + 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 5,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(

              padding:  EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: h * 0.70,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount:
                    isSearch ? searchedQuestions.length : questions.length,
                    itemBuilder: (context, index) {
                      return isSearch
                          ?ListTile(
                        title: Text(
                          searchedQuestions[index].question,
                          style: TextStyle(fontSize: bigTextFontsize),
                        ),
                        subtitle: Container(
                          width: w,
                          height: 20,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: searchedQuestions[index].answers.length,
                            itemBuilder: (BuildContext context, int idx) {
                              var chars = ["a", "b", "c", "d"];
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  chars[idx] +
                                      ". " +
                                      searchedQuestions[index].answers[idx]
                                      ['answer'],
                                  style: TextStyle(
                                      fontSize: smallerTextFontsize,
                                      color: searchedQuestions[index].answers[idx]
                                      ['isCorrect']
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              );
                            },
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            size: 40,
                          ),
                        ),
                        leading: Text(
                          (index + 1).toString() + ")",
                          style: TextStyle(fontSize: bigTextFontsize),
                        ),
                      )
                          : ListTile(
                              title: Text(
                                questions[index].question,
                                style: TextStyle(fontSize: bigTextFontsize),
                              ),
                              subtitle: Container(
                                width: w,
                                height: 20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: questions[index].answers.length,
                                  itemBuilder: (BuildContext context, int idx) {
                                    var chars = ["a", "b", "c", "d"];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        chars[idx] +
                                            ". " +
                                            questions[index].answers[idx]
                                                ['answer'],
                                        style: TextStyle(
                                            fontSize: smallerTextFontsize,
                                            color: questions[index].answers[idx]
                                                    ['isCorrect']
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 40,
                                ),
                              ),
                              leading: Text(
                                (index + 1).toString() + ")",
                                style: TextStyle(fontSize: bigTextFontsize),
                              ),
                            );
                    },

                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Colors.black.withOpacity(0.5),
                          thickness: 2,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
