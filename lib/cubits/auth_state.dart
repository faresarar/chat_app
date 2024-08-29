part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  String errorMessage;

  LoginFailure({required this.errorMessage});
}
class SignUpSuccess extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpFailure extends AuthState {
  String errorMessage;

  SignUpFailure({required this.errorMessage});
}