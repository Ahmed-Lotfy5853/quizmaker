

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/exam_model.dart';
import 'package:quiz_maker/Data/Models/question.dart';

class QuestionsBankWebServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> createQuestion(String groupId , Question question) async {
    try {
      await firestore.collection(groupsCollection).doc(groupId).collection(questionsCollection).add(question.toMap());
    }catch(e){
      rethrow;
    }
  }

   Future<void> deleteQuestion(String groupId , String questionId) async {
     try {
       await firestore.collection(groupsCollection).doc(groupId).collection(questionsCollection).doc(questionId).delete();
     } catch (e) {
       rethrow;
     }
   }

   Future<void> createExam (String groupId , ExamModel examModel) async {
     try {
       await firestore.collection(groupsCollection).doc(groupId).collection(examsCollection).add(examModel.toMap());
     }catch(e){
       rethrow;
     }
   }




}