import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Constants/styles.dart';
import 'package:quiz_maker/Data/Models/question.dart';

class Questions_Bank extends StatefulWidget {
  const Questions_Bank({super.key, required this.groupId});

  final String groupId;

  @override
  State<Questions_Bank> createState() => _Questions_BankState();
}

class _Questions_BankState extends State<Questions_Bank> {
  bool isSearch = false;
  List<Question> questions = [];

  List<Question> searchedQuestions = [];

  bool isSearcffh = false;
  final searchTextController = TextEditingController();

  Widget buildSearchfield() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        hintText: "Find a question...",
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
  void initState() {
    getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double smallerTextFontsize = MediaQuery.textScalerOf(context).scale(15);
    double bigTextFontsize = MediaQuery.textScalerOf(context).scale(25);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(backgroundAsset), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: isSearch ? buildSearchfield() : buildAppbarTitle(),
          centerTitle: true,
          backgroundColor: firstColor,
          iconTheme: IconThemeData(color: Colors.white, size: 30),
          actions: buildSearchAppbarItems(),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Map<String, dynamic>? q;
                Navigator.pushNamed(context, addQuestions).then((value) {
                  setState(() {
                    q = value as Map<String, dynamic>?;
                    if (q != null) {
                      List<String> answers = [
                        if (q!['option1'] != null) q!['option1'] as String,
                        if (q!['option2'] != null) q!['option2'] as String,
                        if (q!['option3'] != null) q!['option3'] as String,
                        if (q!['option4'] != null) q!['option4'] as String,
                      ];

                      questions.add(Question(
                          question: q!['question']!,
                          answers: answers,
                          correctAnswer: q!['correctAnswer'] - 1 ?? 0,
                          level: q!['difficulty']!));
                    }
                  });
                  FirebaseFirestore.instance
                      .collection(groupsCollection)
                      .doc(widget.groupId)
                      .collection(questionsCollection)
                      .add(questions.last.toMap());
                });
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
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
                        color: firstColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: isSearch
                                ? searchedQuestions.length
                                : questions.length,
                            itemBuilder: (context, index) {
                              return isSearch
                                  ? ListTile(
                                      title: Text(
                                        searchedQuestions[index].question,
                                        style: TextStyle(
                                            fontSize: bigTextFontsize),
                                      ),
                                      subtitle: Container(
                                        width: w,
                                        height: 20,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: searchedQuestions[index]
                                              .answers
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int idx) {
                                            print("correct " +
                                                searchedQuestions[index]
                                                    .correctAnswer
                                                    .toString());
                                            var chars = ["a", "b", "c", "d"];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Text(
                                                chars[idx] +
                                                    ". " +
                                                    searchedQuestions[index]
                                                        .answers[idx],
                                                style: TextStyle(
                                                    fontSize:
                                                        smallerTextFontsize,
                                                    color: idx ==
                                                            searchedQuestions[
                                                                    index]
                                                                .correctAnswer
                                                        ? Colors.green
                                                        : Colors.red),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection(groupsCollection)
                                              .doc(widget.groupId)
                                              .collection(questionsCollection)
                                              .doc(questions[index].id)
                                              .delete()
                                              .then((value) {
                                            setState(() {
                                              questions.removeAt(index);
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_outlined,
                                          size: 40,
                                        ),
                                      ),
                                      leading: Text(
                                        (index + 1).toString() + ")",
                                        style: TextStyle(
                                            fontSize: bigTextFontsize),
                                      ),
                                    )
                                  : ListTile(
                                      title: Text(
                                        questions[index].question,
                                        style: TextStyle(
                                            fontSize: bigTextFontsize),
                                      ),
                                      subtitle: Container(
                                        width: w,
                                        height: 20,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              questions[index].answers.length,
                                          itemBuilder:
                                              (BuildContext context, int idx) {
                                            print("correct " +
                                                questions[index]
                                                    .correctAnswer
                                                    .toString());
                                            var chars = ["a", "b", "c", "d"];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Text(
                                                chars[idx] +
                                                    ". " +
                                                    questions[index]
                                                        .answers[idx],
                                                style: TextStyle(
                                                    fontSize:
                                                        smallerTextFontsize,
                                                    color: idx ==
                                                            questions[index]
                                                                .correctAnswer
                                                        ? Colors.green
                                                        : Colors.red),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection(groupsCollection)
                                              .doc(widget.groupId)
                                              .collection(questionsCollection)
                                              .doc(questions[index].id)
                                              .delete()
                                              .then((value) {
                                            setState(() {
                                              questions.removeAt(index);
                                            });
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_outlined,
                                          size: 40,
                                        ),
                                      ),
                                      leading: Text(
                                        (index + 1).toString() + ")",
                                        style: TextStyle(
                                            fontSize: bigTextFontsize),
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
            ),
          ],
        ),
      ),
    );
  }

  void getQuestions() async {
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.groupId)
        .collection(questionsCollection)
        .get()
        .then((value) {
      setState(() {
        for (int i = 0; i < value.docs.length; i++) {
          questions.add(Question(
              id: value.docs[i].id,
              question: value.docs[i].data()['question'],
              answers: value.docs[i].data()['answers'],
              correctAnswer: value.docs[i].data()['correctAnswer'],
              level: value.docs[i].data()['level']));
        }
      });
    });
  }
}
