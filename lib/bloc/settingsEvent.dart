import 'package:space_app/model/settingsData.dart';

abstract class SettingsEvent {}

class EditEvent extends SettingsEvent {}

class SaveEvent extends SettingsEvent {
  SettingsData data;
  SaveEvent({this.data});
}

class ViewEvent extends SettingsEvent {}
