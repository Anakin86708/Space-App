import 'package:space_app/model/userData.dart';

abstract class AuthState {}

class UnloggedState extends AuthState {}

class RegisterState extends AuthState {}

class LogState extends AuthState {}

class SuccessLoggedState extends AuthState {
  final UserData user;

  SuccessLoggedState(this.user);
}

class ErrorState extends AuthState {
  final String message;

  ErrorState(this.message);
}
