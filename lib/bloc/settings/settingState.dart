import 'package:space_app/database/localDatabase.dart';
import 'package:space_app/model/settingsData.dart';

abstract class SettingsState {
  SettingsData data;
}

class ViewState extends SettingsState {
  ViewState(SettingsData data) {
    this.data = data;
  }
}

class InitialState extends SettingsState {
  InitialState() {
    this.data = new SettingsData();
  }
}
