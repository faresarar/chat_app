import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
   try {
     UserCredential user = await FirebaseAuth.instance
         .signInWithEmailAndPassword(email: email, password: password);
   } on Exception catch (error){
     emit(LoginFailure());
   }
  }
}
