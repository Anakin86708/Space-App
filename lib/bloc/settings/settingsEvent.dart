import 'package:space_app/model/settingsData.dart';

abstract class SettingsEvent {
  SettingsData data;
  SettingsEvent(SettingsData data) {
    this.data = data;
  }
}

class UpdateEvent extends SettingsEvent {
  UpdateEvent(SettingsData data) : super(data) {
  }
}

class ViewEvent extends SettingsEvent {
  ViewEvent(SettingsData data) : super(data);
}
