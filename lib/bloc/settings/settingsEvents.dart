import 'package:space_app/model/settingsData.dart';

abstract class SettingsEvents {}

class GetDatabaseSettingsEvent extends SettingsEvents {
  SettingsData data;
  GetDatabaseSettingsEvent({SettingsData data}) {
    this.data = data ?? SettingsData();
  }
}

class UpdateSettingsEvent extends SettingsEvents {
  SettingsData data;
  UpdateSettingsEvent({SettingsData data}) {
    this.data = data ?? SettingsData();
  }
}