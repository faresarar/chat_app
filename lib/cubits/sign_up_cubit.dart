import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
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

    }
    catch (error){
      emit(SignUpFailure(errorMessage: "There was an error please try again"));
    }
  }
}
