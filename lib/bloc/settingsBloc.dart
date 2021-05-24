import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/settingState.dart';
import 'package:space_app/bloc/settingsEvent.dart';
import 'package:space_app/database/localDatabase.dart';
import 'package:space_app/model/settingsData.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(InitialState());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is ViewEvent) {
      // Será solicitado info do DB
      SettingsData data = await DatabaseLocalServer.helper.getSettingsData();
      // DatabaseLocalServer.helper.getSettingsData().then((value) => data);
      yield ViewState(data);
    } else if (event is UpdateEvent) {
      // Será feito o update no DB
      DatabaseLocalServer.helper.updateNote(event.data);
      SettingsData data = await DatabaseLocalServer.helper.getSettingsData();
      // DatabaseLocalServer.helper.getSettingsData().then((value) => data);
      yield ViewState(data);
    }
  }
}
