part of 'login_cubit.dart';

sealed class LoginStates {}

final class LoginInitial extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String jwt;
  LoginSuccessState(this.jwt);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}
