
import 'package:quiz_maker/Data/Web%20Services/Auth/auth_webservices.dart';

class Auth_Repository {
 final Auth_WebServices auth_WebServices;

  Auth_Repository(this.auth_WebServices);

  Future<String?> signUp(String email, String password) async {
    try {
     String? uId = await auth_WebServices.signUp(email, password);
     if(uId != null) {
       await auth_WebServices.getProfile(uId);
     }
     return uId;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await auth_WebServices.login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await auth_WebServices.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setAccountType(String name,String email,String uid,bool isTeacher) async {
    try {
      await auth_WebServices.setAccountType(isTeacher);
    } catch (e) {
      rethrow;
    }
  }


}