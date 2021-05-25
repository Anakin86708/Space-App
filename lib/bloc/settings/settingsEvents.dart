import 'package:space_app/model/settingsData.dart';

abstract class SettingsEvents {}

class GetSettingsEvent extends SettingsEvents {
  SettingsData data;
  GetSettingsEvent({SettingsData data}) {
    this.data = data ?? SettingsData();
  }
}
