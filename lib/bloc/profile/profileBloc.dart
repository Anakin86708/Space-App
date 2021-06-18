import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:space_app/auth/authProvider.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/bloc/profile/profileStates.dart';
import 'package:space_app/model/userData.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthProvider _authenticationService;
  StreamSubscription _authenticationStream;

  AuthBloc() : super(UnloggedState()) {
    // Verificar no servidor se está logado
    _authenticationService = AuthProvider();
    _authenticationStream = _authenticationService.user.listen((event) {
      add(ServerEvent(event));
    });
    add(ChangeToRegisterEvent());
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is ChangeToRegisterEvent) {
      yield RegisterState();
    } else if (event is ChangeToLoginEvent) {
      yield LoginState();
    } else if (event is SendDataEvent) {
      if (state is RegisterState) {
        yield await _registerState(event);
      } else if (state is LoginState) {
        yield await _loginState(event);
      }
    } else if (event is Logout) {
      await _authenticationService.signOut();
      yield UnloggedState();
    } else if (event is ServerEvent) {
      if (event.data == null) {
        yield UnloggedState();
      } else {
        yield SuccessLoggedState(event.data);
      }
    } else if (event is ErrorEvent) {
      yield ErrorState(event.message);
    }
  }

  _loginState(SendDataEvent event) async {
    try {
      UserData user =
          await _authenticationService.signInWithEmailAndPassword(
              email: event.email, password: event.password);
      return SuccessLoggedState(user);
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

  _registerState(SendDataEvent event) async {
    try {
      UserData user =
          await _authenticationService.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      return SuccessLoggedState(user);
    } catch (e) {
      return ErrorState(e.toString());
    }
  }

   close() {
    _authenticationStream.cancel();
    return super.close();
  }
}
