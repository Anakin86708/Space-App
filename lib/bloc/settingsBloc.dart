import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/settingState.dart';
import 'package:space_app/bloc/settingsEvent.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(ViewState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is EditEvent) {
      yield EditState();
    } else if (event is SaveEvent) {
      yield SaveState(data: event.data);
    } else if (event is ViewEvent) {
      yield ViewState();
    }
  }
}
