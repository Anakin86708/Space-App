import 'package:space_app/model/settingsData.dart';

abstract class DatabaseStates {}

class InitialState extends DatabaseStates {}

class UpdateState extends DatabaseStates {
  SettingsData data;
  UpdateState(SettingsData data) {
    this.data = data;
  }
}
