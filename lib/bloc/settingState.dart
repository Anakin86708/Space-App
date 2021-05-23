import 'package:space_app/model/settingsData.dart';

abstract class SettingsState {}

class ViewState extends SettingsState {}

class EditState extends SettingsState {}

class SaveState extends SettingsState {
  SettingsData data;
  SaveState({this.data});
}
