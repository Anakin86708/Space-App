abstract class ProfileEvent {}

class RegisterEvent {}

class ChangeToRegisterEvent extends ProfileEvent {}

class ChangeToLoginEvent extends ProfileEvent {}

class ErrorEvent extends ProfileEvent {
  final String message;

  ErrorEvent(this.message);
}

class LoginSucess extends ProfileEvent {}
