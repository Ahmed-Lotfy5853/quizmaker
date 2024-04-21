import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quiz_maker/Data/Models/user.dart';

import '../../../Constants/Strings.dart';

class Auth_WebServices {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Signed in user: ${userCredential.user?.uid}');
      if(userCredential.user?.uid != null){
        getProfile(userCredential.user!.uid);

      }
    }catch (e) {
      rethrow;
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Signed up user: ${userCredential.user?.uid}');
      if(userCredential.user?.uid != null)
      return userCredential.user?.uid;
    }catch (e) {
      rethrow;
    }
    return null;
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

  Future<void> getProfile(String uId)async {
    firestore.collection(studentsCollection).doc(uId).get().then(
          (DocumentSnapshot doc) {
        final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if(data != null){
           user = UserModel.fromMap(data);
        }
        else{
          firestore.collection(teachersCollection).doc(uId).get().then(
                (DocumentSnapshot doc) {
              final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
              if(data != null){
                user = UserModel.fromMap(data);
              }
              else{
Fluttertoast.showToast(msg: 'user not found');
              }
              // ...
            },
            onError: (e) => print("Error getting document: $e"),
          );
        }
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

}