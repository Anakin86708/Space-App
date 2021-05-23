import 'package:space_app/model/settingsData.dart';

abstract class SettingsEvent {}

class UpdateEvent extends SettingsEvent {
  SettingsData data;
  UpdateEvent(data) {
    this.data = data;
  };
}

class ViewEvent extends SettingsEvent {}
