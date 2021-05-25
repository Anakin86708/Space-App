import 'package:space_app/model/settingsData.dart';

abstract class SettingsEvents {}

class GetSettingsEvent extends SettingsEvents {
  SettingsData data;
  GetSettingsEvent({SettingsData data}) {
    this.data = data ?? SettingsData();
  }
}

class UpdateSettingsEvent extends SettingsEvents {
  SettingsData data;
  UpdateSettingsEvent({SettingsData data}) {
    this.data = data ?? SettingsData();
  }
}