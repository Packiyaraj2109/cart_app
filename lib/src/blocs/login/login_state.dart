part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginValidateSuccessState extends LoginState {}

// class LoginValidateFailedtate extends LoginState {}

class LoginFailedFailedState extends LoginState {
  String msg;
  LoginFailedFailedState(this.msg);
}
