import 'package:bloc/bloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/bloc/profile/profileStates.dart';
import 'package:space_app/model/userData.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(UnloggedState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is RegisterEvent) {
      yield RegisterState();
    } else if (event is ChangeToRegisterEvent) {
      yield RegisterState();
    } else if (event is ChangeToLoginEvent) {
      yield LogState();
    } else if (event is LoginSucess) {
      // yield LoggedState();
    } else if (event is ErrorEvent) {
      yield ErrorState(event.message);
    }
  }
}
