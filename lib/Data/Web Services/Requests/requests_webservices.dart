import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/Constants/Strings.dart';
import 'package:quiz_maker/Data/Models/requests.dart';

class RequestsWebServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> createRequest(List<String> teachersId, Request request) async {
    try {
      if (current_user!.isTeacher) {
        for (var id in teachersId) {
          firestore
              .collection(teachersCollection)
              .doc(id)
              .collection(teacherRequestsCollection)
              .add(request.toMap());
        }
      }
      if (!current_user!.isTeacher) {
        for (var id in teachersId) {
          firestore
              .collection(teachersCollection)
              .doc(id)
              .collection(studentRequestsCollection)
              .add(request.toMap())
              .then((value) {
            firestore
                .collection(studentsCollection)
                .doc(current_user!.uid)
                .collection(studentRequestsCollection)
                .doc(value.id)
                .set(request.toMap());
          });
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Request>> getStudentRequests(String teacherId) async {
    try {
      List<Request> requests = [];
      firestore
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(studentRequestsCollection)
          .get()
          .then((value) {
        for (var element in value.docs) {
          requests.add(Request.fromMap(element.data()));
        }
      });
      return requests;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Request>> getTeacherRequests(String teacherId) async {
    try {
      List<Request> requests = [];
      firestore
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(teacherRequestsCollection)
          .get()
          .then((value) {
        for (var element in value.docs) {
          requests.add(Request.fromMap(element.data()));
        }
      });
      return requests;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRequest(
      String teacherId, String requestId, bool isTeacher) async {
    try {
      await firestore
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(
              isTeacher ? teacherRequestsCollection : studentRequestsCollection)
          .doc(requestId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> acceptRequest(
      String teacherId, String requestId, bool isTeacher) async {
    try {
      await firestore
          .collection(teachersCollection)
          .doc(teacherId)
          .collection(
              isTeacher ? teacherRequestsCollection : studentRequestsCollection)
          .doc(requestId)
          .update({"isPending": false});
    } catch (e) {
      rethrow;
    }
  }
}
