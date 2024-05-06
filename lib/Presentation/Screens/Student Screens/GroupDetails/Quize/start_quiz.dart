import 'dart:async';
import 'dart:developer' as log;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/Data/Models/exam_model.dart';
import 'package:quiz_maker/Data/Models/question.dart';

import '../../../../../Constants/Strings.dart';
import '../../../../../Constants/styles.dart';
import '../../../../../Data/Models/group.dart';

class StartQuiz extends StatefulWidget {
  const StartQuiz({super.key, required this.group, required this.exam});

  final Group group;
  final ExamModel exam;

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  int currentIndex = 0;
  int selectedAnswerIndex = 0;
  int score = 0;
  List<Question> easyQuestions = [];
  List<Question> mediumQuestions = [];
  List<Question> hardQuestions = [];
  List<Question> myQuestions = [];

  late Timer timer;
  int _secondsRemaining = 0;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_secondsRemaining == 0) {
          timer.cancel(); // Cancel the timer when countdown reaches zero
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  @override
  void initState() {
    fetchQuizData();
    _secondsRemaining = widget.exam.timer * 60;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _secondsRemaining ~/ 60; // Get minutes from remaining seconds
    int seconds = _secondsRemaining % 60; // Get remaining seconds
    String timeString =
        '$minutes:${seconds < 10 ? '0' : ''}$seconds'; // Format time as mm:ss

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exam.name,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: firstColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: firstColor,
      body: WillPopScope(
        onWillPop: () async {
          addStudentScore();
          return false;
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Timer: $timeString',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    myQuestions[currentIndex].question,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 300,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              height: 1,
                            ),
                        itemCount: myQuestions[currentIndex].answers.length,
                        itemBuilder: (context, index) {
                          List<String> characters = ['A.', 'B.', 'C.', 'D.'];
                          selectedAnswerIndex > 0 ? selectedAnswerIndex : 0;
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAnswerIndex = index;
                                  print(index);
                                });
                              },
                              child: Container(
                                  color: selectedAnswerIndex == index
                                      ? Colors.green.withOpacity(0.5)
                                      : Colors.white,
                                  child: ListTile(
                                    leading: Text(
                                      characters[index],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    title: Text(
                                      myQuestions[currentIndex].answers[index],
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    trailing: selectedAnswerIndex == index
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                                  )));
                        }),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Check answer and move to the next question
                      if (currentIndex < myQuestions.length - 1) {
                        log.log("the answer is " +
                            myQuestions[currentIndex].correctAnswer.toString());
                        log.log(
                            "user answer is " + selectedAnswerIndex.toString());

                        setState(() {
                          if (myQuestions[currentIndex].correctAnswer ==
                              selectedAnswerIndex) {
                            score++;
                          }

                          currentIndex++;
                        });
                        log.log("current score is " + score.toString());
                      } else {
                        if (myQuestions[currentIndex].correctAnswer ==
                            selectedAnswerIndex) {
                          score++;
                        }
                        // Quiz completed
                        addStudentScore();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Quiz Completed'),
                            content: Text(
                                'Congratulations! You have completed the quiz. Your score is $score out of ${myQuestions.length}.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];
    await FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(questionsCollection)
        .get()
        .then((value) {
      log.log("questions" + value.docs.length.toString());
      for (var element in value.docs) {
        if (element['level'] == 'Easy') {
          easyQuestions.add(Question.fromMap(element.data()));
        }
        if (element['level'] == 'Medium') {
          mediumQuestions.add(Question.fromMap(element.data()));
        }
        if (element['level'] == 'Hard') {
          hardQuestions.add(Question.fromMap(element.data()));
        }
      }
      log.log("easyQuestions" + easyQuestions.length.toString());
      log.log("mediumQuestions" + mediumQuestions.length.toString());
      log.log("hardQuestions" + hardQuestions.length.toString());
      for (var i = 0; i < widget.exam.easyQuestions; i++) {
        if (easyQuestions.isEmpty) break;
        if (easyQuestions.length == 1) {
          questions.add(easyQuestions[0]);
          break;
        }
        Random random = Random();
        int randomIndex = easyQuestions.length == 1
            ? 0
            : random.nextInt(easyQuestions.length);
        questions.add(easyQuestions[randomIndex]);
        easyQuestions.removeAt(randomIndex);
      }
      for (var i = 0; i < widget.exam.mediumQuestions; i++) {
        if (mediumQuestions.isEmpty) break;

        Random random = Random();
        int randomIndex = mediumQuestions.length == 1
            ? 0
            : random.nextInt(mediumQuestions.length);
        questions.add(mediumQuestions[randomIndex]);
        mediumQuestions.removeAt(randomIndex);
      }
      for (var i = 0; i < widget.exam.hardQuestions; i++) {
        if (hardQuestions.isEmpty) break;
        Random random = Random();
        int randomIndex = hardQuestions.length == 1
            ? 0
            : random.nextInt(hardQuestions.length);
        questions.add(hardQuestions[randomIndex]);
        hardQuestions.removeAt(randomIndex);
      }

      setState(() {});
    });
    return questions;
  }

  fetchQuizData() async {
    if (myQuestions.isEmpty) {
      myQuestions = await getQuestions();
      setState(() {});
    }
    log.log("myQuestions" + myQuestions.length.toString());
  }

  void addStudentScore() async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(groupsCollection)
        .doc(widget.group.id)
        .collection(quizCollection)
        .doc(widget.exam.id);

    try {
      DocumentSnapshot docSnapshot = await docRef.get();
      List<Map<String, dynamic>> currentArray =
          List.from(docSnapshot.get('results') ?? []);

      Map<String, int> newMap = {current_user.uid.toString(): score};

      currentArray.add(newMap);

      await docRef.update({'results': currentArray});

      print('Map added to the Firestore document successfully.');
    } catch (e) {
      print('Error adding map to Firestore document: $e');
    }
  }
}
