import 'package:space_app/model/userData.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent {}

class ChangeToRegisterEvent extends AuthEvent {}

class ChangeToLoginEvent extends AuthEvent {}

class SendDataEvent extends AuthEvent {
  String email;
  String password;
  SendDataEvent();
}

class ErrorEvent extends AuthEvent {
  final String message;

  ErrorEvent(this.message);
}

class Logout extends AuthEvent {}

class ServerEvent extends AuthEvent {
  final UserData data;

  ServerEvent(this.data);
}
