import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/database/databaseBloc.dart';
import 'package:space_app/bloc/database/databaseEvents.dart';
import 'package:space_app/bloc/database/databaseStates.dart';
import 'package:space_app/bloc/settings/settingsBloc.dart';
import 'package:space_app/bloc/settings/settingsStates.dart';
import 'package:space_app/model/settingsData.dart';
import 'package:space_app/theme/appColors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsData _data = new SettingsData();
  final GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      // Tire esse bloc daqui
      body: BlocListener<SettingsBloc, SettingsStates>(
          listener: (context, state) {
            if (state is UpdateViewState) {
              setState(() {
                this._data = state.data;
              });
            }
          },
          child: BlocBuilder<SettingsBloc, SettingsStates>(
            builder: (BuildContext context, state) =>
                _generateListSettings(context, state),
          )),
    );
  }

  Widget _generateListSettings(BuildContext context, state) {
    return Form(
      key: formKey,
          child: ListView(
        children: [
          _eventNotificationItem(context, state),
          _onlyFavoriteItem(context, state),
          _updateFrequencyItem(context, state),
          // _saveButtonItem(context),
        ],
      ),
    );
  }

  ListTile _eventNotificationItem(BuildContext context, state) {
    return ListTile(
      title: Text('Notificação de eventos'),
      trailing: Switch(
        value: state.data.eventNotificationsState,
        onChanged: (bool value) {
            state.data.eventNotificationsState = value;
          print(_data);
        },
      ),
    );
  }

  ListTile _onlyFavoriteItem(BuildContext context, state) {
    return ListTile(
      title: Text('Apenas eventos favoritos'),
      trailing: Switch(
        value: state.data.onlyFavoriteState,
        onChanged: state.data.eventNotificationsState
            ? (bool value) {
                  state.data.onlyFavoriteState = value;
                print(_data);
              }
            : null,
      ),
    );
  }

  ListTile _updateFrequencyItem(BuildContext context, state) {
    return ListTile(
      title: Text('Frequência de atualização'),
      trailing: DropdownButton<String>(
        value: state.data.updateFrequencyValue,
        items: _generateListItens(),
        onChanged: (value) {
            state.data.updateFrequencyValue = value;
          print(_data);
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

  Widget _saveButtonItem(BuildContext context) {
    double padding = 100;
    return Padding(
      padding: EdgeInsets.only(right: padding, left: padding),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<DatabaseBloc>(context).add(UpdateSettingsEvent(_data));
        },
        child: Text('Save'),
      ),
    );
  }
}
