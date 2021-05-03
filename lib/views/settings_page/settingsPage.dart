import 'package:flutter/material.dart';
import 'package:space_app/model/settingsData.dart';
import 'package:space_app/theme/appColors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static SettingsData data = new SettingsData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: _generateListSettings(),
    );
  }

  Widget _generateListSettings() {
    return ListView(
      children: [
        _eventNotificationItem(),
        _onlyFavoriteItem(),
        _updateFrequencyItem(),
      ],
    );
  }

  ListTile _eventNotificationItem() {
    return _generateSettingsItem();
  }

  ListTile _generateSettingsItem() {
    return ListTile(
      title: Text('Notificação de eventos'),
      trailing: Switch(
        value: data.eventNotificationsState,
        onChanged: (bool value) {
          setState(() {
            data.eventNotificationsState = value;
          });
          print(data);
        },
      ),
    );
  }

  ListTile _onlyFavoriteItem() {
    return ListTile(
      title: Text('Apenas eventos favoritos'),
      trailing: Switch(
        value: data.onlyFavoriteState,
        onChanged: data.eventNotificationsState
            ? (bool value) {
                setState(() {
                  data.onlyFavoriteState = value;
                });
                print(data);
              }
            : null,
      ),
    );
  }

  ListTile _updateFrequencyItem() {
    return ListTile(
      title: Text('Frequência de atualização'),
      trailing: DropdownButton<String>(
        value: data.updateFrequencyValue,
        items: _generateListItens(),
        onChanged: (value) {
          setState(() {
            data.updateFrequencyValue = value;
          });
          print(data);
        },
        underline: Container(
          color: AppColors.accent,
          height: 2,
        ),
      ),
    );
  }

  List<DropdownMenuItem<dynamic>> _generateListItens() =>
      SettingsData.avaliableUpdatesFrequency
          .map((e) => new DropdownMenuItem(value: e, child: Text(e)))
          .toList();
}
