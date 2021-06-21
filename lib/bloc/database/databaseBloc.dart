import 'package:bloc/bloc.dart';
import 'package:space_app/bloc/database/databaseEvents.dart';
import 'package:space_app/bloc/database/databaseStates.dart';
import 'package:space_app/database/settingsDatabase.dart';

class DatabaseBloc extends Bloc<DatabaseEvents, DatabaseStates> {
  DatabaseBloc() : super(InitialState());

  @override
  Stream<DatabaseStates> mapEventToState(DatabaseEvents event) async* {
    if (event is UpdateSettingsEvent) {
      // Atualiza informações no bd
      SettingsDatabaseLocalServer.helper.updateSettings(event.data);
      yield UpdateState(event.data);
    }
  }
}
