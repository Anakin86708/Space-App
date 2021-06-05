import 'package:space_app/model/userData.dart';

abstract class ProfileState {}

class UnloggedState extends ProfileState {}

class RegisterState extends ProfileState {}

class LogState extends ProfileState {}

class LoggedState extends ProfileState {
  final UserData user;

  LoggedState(this.user);
}

class ErrorState extends ProfileState {
  final String message;

  ErrorState(this.message);
}
