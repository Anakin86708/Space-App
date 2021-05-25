import 'package:space_app/model/settingsData.dart';

abstract class SettingsStates {}

class ViewState extends SettingsStates{
  SettingsData data;
  ViewState({SettingsData data }) {
    this.data = data ?? new SettingsData();
  }
}
