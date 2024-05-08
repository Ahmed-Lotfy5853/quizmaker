

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/Data/Web%20Services/Questions%20Bank/questions_bank_webservices.dart';

import '../../Models/exam_model.dart';
import '../../Models/question.dart';

class QuestionsBankRepository {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final QuestionsBankWebServices questionsBankWebServices ;

  QuestionsBankRepository({required this.questionsBankWebServices});


  Future<void> createQuestion(String groupId , Question question) async {
    try {
      await questionsBankWebServices.createQuestion(groupId, question);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteQuestion(String groupId , String questionId) async {
    try {
      await questionsBankWebServices.deleteQuestion(groupId, questionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createExam(String groupId , ExamModel examModel) async {
    try {
      await questionsBankWebServices.createExam(groupId, examModel);
    } catch (e) {
      rethrow;
    }
  }


}