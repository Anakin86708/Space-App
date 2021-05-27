import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/database/databaseBloc.dart';
import 'package:space_app/bloc/database/databaseEvents.dart';
import 'package:space_app/bloc/settings/settingsBloc.dart';
import 'package:space_app/bloc/settings/settingsStates.dart';
import 'package:space_app/model/settingsData.dart';
import 'package:space_app/theme/appColors.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsStates>(
        builder: (BuildContext context, state) =>
            _generateListSettings(context, state),
      ),
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
          BlocProvider.of<DatabaseBloc>(context)
              .add(UpdateSettingsEvent(state.data));
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
                BlocProvider.of<DatabaseBloc>(context)
                    .add(UpdateSettingsEvent(state.data));
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
          BlocProvider.of<DatabaseBloc>(context)
              .add(UpdateSettingsEvent(state.data));
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
