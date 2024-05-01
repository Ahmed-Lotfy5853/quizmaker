import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/chat_model.dart';

class ChatsWebServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> createChat(
      String teacherId, String studentId, ChatModel chatModel) async {
    try {
      await firestore
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(studentId)
          .doc(studentId)
          .set(chatModel.toMap());
    } catch (e) {
      rethrow;
    }
  }


}
