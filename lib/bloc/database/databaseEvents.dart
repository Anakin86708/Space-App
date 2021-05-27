import 'package:space_app/model/settingsData.dart';

abstract class DatabaseEvents {}

class UpdateSettingsEvent extends DatabaseEvents {
  SettingsData data;
  UpdateSettingsEvent(SettingsData data) {
    this.data = data;
  }
}
