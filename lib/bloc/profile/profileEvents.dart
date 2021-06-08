import 'package:space_app/model/userData.dart';

abstract class ProfileEvent {}

class RegisterEvent extends ProfileEvent {}

class ChangeToRegisterEvent extends ProfileEvent {}

class ChangeToLoginEvent extends ProfileEvent {}

class SendDataEvent extends ProfileEvent {
  String email;
  String password;
  SendDataEvent();
}

class ErrorEvent extends ProfileEvent {
  final String message;

  ErrorEvent(this.message);
}

class LoginSucess extends ProfileEvent {}

class Logout extends ProfileEvent {}

class ServerEvent extends ProfileEvent {
  final UserData data;

  ServerEvent(this.data);
}
