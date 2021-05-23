import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/settingState.dart';
import 'package:space_app/bloc/settingsEvent.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(// TODO: colocar chamada pro db));

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is ViewEvent) {
      // Será solicitado info do DB
      yield SettingsState();
    } else if (event is UpdateEvent) {
      // Será feito o update no DB
      yield SettingsState();
    }
  }
}
