import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/settingState.dart';
import 'package:space_app/bloc/settingsBloc.dart';
import 'package:space_app/bloc/settingsEvent.dart';
import 'package:space_app/model/settingsData.dart';
import 'package:space_app/theme/appColors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajustes'),
        ),
        body: BlocProvider(
          create: (BuildContext context) => SettingsBloc(),
          child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (BuildContext context, SettingsState state) {
            this.data = state.data;
            return _generateListSettings(context, state);
          }),
        ));
  }

  Widget _generateListSettings(BuildContext context, SettingsState state) {
    return ListView(
      children: [
        _eventNotificationItem(context, state),
        _onlyFavoriteItem(context, state),
        _updateFrequencyItem(context, state),
        _saveButtonItem(context, state)
      ],
    );
  }

  ListTile _eventNotificationItem(BuildContext context, SettingsState state) {
    return ListTile(
      title: Text('Notificação de eventos'),
      trailing: Switch(
        value: state.data.eventNotificationsState,
        onChanged: (bool value) {
          setState(() {
            data.eventNotificationsState = value;
          });
          print(data);
        },
      ),
    );
  }

  ListTile _onlyFavoriteItem(BuildContext context, SettingsState state) {
    return ListTile(
      title: Text('Apenas eventos favoritos'),
      trailing: Switch(
        value: state.data.onlyFavoriteState,
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

  ListTile _updateFrequencyItem(BuildContext context, SettingsState state) {
    return ListTile(
      title: Text('Frequência de atualização'),
      trailing: DropdownButton<String>(
        value: state.data.updateFrequencyValue,
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

  Widget _saveButtonItem(BuildContext context, SettingsState state) {
    double padding = 100;
    return Padding(
      padding: EdgeInsets.only(right: padding, left: padding),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<SettingsBloc>(context).add(UpdateEvent(data));
        },
        child: Text('Save'),
      ),
    );
  }
}
