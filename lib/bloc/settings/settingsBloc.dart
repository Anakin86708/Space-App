import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:space_app/bloc/settings/settingsEvents.dart';
import 'package:space_app/bloc/settings/settingsStates.dart';
import 'package:space_app/database/apiDatabase.dart';
import 'package:space_app/database/settingsDatabase.dart';
import 'package:space_app/model/settingsData.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsStates> {
  StreamSubscription _localSubscription;

  SettingsBloc() : super(ViewState()) {
    add(GetDatabaseSettingsEvent());
    _localSubscription =
        SettingsDatabaseLocalServer.helper.stream.listen((event) {
      SettingsData data = event;
      add(UpdateSettingsEvent(data: data));
    });
  }

  @override
  Stream<SettingsStates> mapEventToState(SettingsEvents event) async* {
    if (event is GetDatabaseSettingsEvent) {
      SettingsData data =
          await SettingsDatabaseLocalServer.helper.getSettingsData();
      yield ViewState(data: data);
    } else if (event is UpdateSettingsEvent) {
      yield ViewState(data: event.data);
    } else if (event is ClearSettingsDatabase) {
      await _clearDatabases();
    }
  }

  _clearDatabases() async {
    await SettingsDatabaseLocalServer.helper.clearUpdateDatabase();
    await APIDatabase.helper.clearDatabase();
    print('Databases clear complete!');
  }

  close() {
    _localSubscription.cancel();
    return super.close();
  }
}
