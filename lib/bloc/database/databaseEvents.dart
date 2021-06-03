import 'package:space_app/model/settingsData.dart';

abstract class DatabaseEvents {}

class UpdateDatabaseSettingsEvent extends DatabaseEvents {
  SettingsData data;
  UpdateDatabaseSettingsEvent(SettingsData data) {
    this.data = data;
  }
}
