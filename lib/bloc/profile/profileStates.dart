import 'package:space_app/model/userData.dart';

abstract class AuthState {}

class UnloggedState extends AuthState {}

class RegisterState extends AuthState {}

class LoginState extends AuthState {}

class SuccessLoggedState extends AuthState {
  final UserData user;

  SuccessLoggedState(this.user);
}

class MessageState extends AuthState {
  final String message;

  MessageState(this.message);
}
