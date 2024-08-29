import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user-not-found'));
      } else if (ex.code == 'wrong-password') {}
      emit(LoginFailure(errorMessage: "wrong password"));
    } catch (error) {
      emit(LoginFailure(errorMessage: "Something went wrong"));
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(SignUpFailure(errorMessage: "Weak Password"));
      } else if (ex.code == 'email-already-in-use') {
        emit(SignUpFailure(errorMessage: "Email already in use"));
      }
    } catch (error) {
      emit(SignUpFailure(errorMessage: "There was an error please try again"));
    }
  }
}
