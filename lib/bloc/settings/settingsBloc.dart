import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:space_app/bloc/settings/settingsEvents.dart';
import 'package:space_app/bloc/settings/settingsStates.dart';
import 'package:space_app/database/localDatabase.dart';
import 'package:space_app/model/settingsData.dart';

class SettingsBloc extends Bloc<SettingsEvents, SettingsStates> {
  StreamSubscription _localSubscription;

  SettingsBloc() : super(ViewState()) {
    // add(GetSettingsEvent());
    _localSubscription = DatabaseLocalServer.helper.stream.listen((event) {
      SettingsData data = event;
      add(GetSettingsEvent(data: data));
    });
  }

  @override
  Stream<SettingsStates> mapEventToState(SettingsEvents event) async* {
    if (event is GetSettingsEvent) {
      SettingsData data = await DatabaseLocalServer.helper.getSettingsData();
      yield ViewState(data: data);
    }
  }

  close() {
    _localSubscription.cancel();
    return super.close();
  }
}
