import 'package:bloc/bloc.dart';
import 'package:space_app/bloc/database/databaseEvents.dart';
import 'package:space_app/bloc/database/databaseStates.dart';
import 'package:space_app/database/localDatabase.dart';

class DatabaseBloc extends Bloc<DatabaseEvents, DatabaseStates> {
  DatabaseBloc() : super(InitialState());

  @override
  Stream<DatabaseStates> mapEventToState(DatabaseEvents event) async* {
    if (event is UpdateDatabaseSettingsEvent) {
      // Atualiza informações no bd
      DatabaseLocalServer.helper.updateNote(event.data);
      yield UpdateState(event.data);
    }
  }
}
