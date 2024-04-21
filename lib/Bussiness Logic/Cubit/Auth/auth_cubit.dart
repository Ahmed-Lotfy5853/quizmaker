import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data/Repository/Auth/auth_repository.dart';

part 'auth_state.dart';

class Auth_Cubit extends Cubit<AuthState> {
  Auth_Cubit(this.auth_Repository) : super(AuthInitial());

  final Auth_Repository auth_Repository;

 Future<void> signUp(String name,String email, String password , bool isTeacher) async {
    emit(AuthLoading());
   var uId = await auth_Repository.signUp(email, password);
   if(uId != null)
    await auth_Repository.setAccountType(name,email,uId,isTeacher);
    emit(AuthSuccess());
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    await auth_Repository.login(email, password);
    emit(AuthSuccess());
  }

  Future<void> signOut() async {
    await auth_Repository.signOut();

  }

}



