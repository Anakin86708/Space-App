import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/database/databaseBloc.dart';
import 'package:space_app/bloc/database/databaseEvents.dart';
import 'package:space_app/bloc/database/databaseStates.dart';
import 'package:space_app/model/settingsData.dart';
import 'package:space_app/theme/appColors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  SettingsData data = new SettingsData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      // Tire esse bloc daqui
      body: MultiBlocProvider(providers: [
        BlocProvider(create: (_) => DatabaseBloc()),
      ], child: BlocListener<DatabaseBloc, DatabaseStates>(listener: (context, state) {
        if (state is UpdateState) {
          setState(() {
            this.data = state.data;
          });
        }
      },child: BlocBuilder<DatabaseBloc, DatabaseStates>(builder: (BuildContext context, state) =>  _generateListSettings(context, state),
      ))),
    );
  }

  Widget _generateListSettings(BuildContext context, state) {
    return ListView(
      children: [
        _eventNotificationItem(),
        _onlyFavoriteItem(),
        _updateFrequencyItem(),
        _saveButtonItem(context),
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

  Widget _saveButtonItem(BuildContext context) {
    double padding = 100;
    return Padding(
      padding: EdgeInsets.only(right: padding, left: padding),
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<DatabaseBloc>(context).add(UpdateSettingsEvent(data));
        },
        child: Text('Save'),
      ),
    );
  }
}
