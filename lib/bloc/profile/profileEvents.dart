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
