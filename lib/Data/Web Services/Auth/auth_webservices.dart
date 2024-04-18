import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Constants/Strings.dart';

class Auth_WebServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Signed in user: ${userCredential.user!.uid}');
    }catch (e) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Signed up user: ${userCredential.user!.uid}');
    }catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    }catch (e) {
      rethrow;
    }
  }

  Future<void> setAccountType(bool isTeacher) async {
    try{
      if(isTeacher) {
        firestore.collection(teachersCollection).doc(firebaseAuth.currentUser!.uid).set({});
      } else {
        firestore.collection(studentsCollection).doc(firebaseAuth.currentUser!.uid).set({});
      }
    }catch (e) {
      rethrow;
    }
  }

}