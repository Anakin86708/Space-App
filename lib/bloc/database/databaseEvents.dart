import 'package:space_app/model/settingsData.dart';

abstract class DatabaseEvents {}

class UpdateDBSettingsEvent extends DatabaseEvents {
  SettingsData data;
  UpdateDBSettingsEvent(SettingsData data) {
    this.data = data;
  }
}
