abstract class ProfileEvents {}

class RegisterEvent {}

class ChangeToRegisterEvent extends ProfileEvents {}

class ChangeToLoginEvent extends ProfileEvents {}

class ErrorEvent extends ProfileEvents {
  final String message;

  ErrorEvent(this.message);
}

class LoginSucess extends ProfileEvents {}
