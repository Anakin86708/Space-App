import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/data/dataBloc.dart';
import 'package:space_app/bloc/data/dataEvents.dart';
import 'package:space_app/bloc/data/dataStates.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/bloc/profile/profileStates.dart';
import 'package:space_app/model/postData.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/interfacePage.dart';
import 'package:space_app/views/initial_page/postCard.dart';

class FavoritePage extends StatefulWidget implements InterfacePage {
  final Icon _pageIcon = Icon(Icons.star);
  final String _pageName = 'Favorites';

  @override
  _FavoritePageState createState() => _FavoritePageState();

  @override
  Icon get pageIcon => _pageIcon;

  @override
  String get pageName => _pageName;
}

class _FavoritePageState extends State<FavoritePage> {
  static const padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is SuccessLoggedState) {
          BlocProvider.of<DataBloc>(context).add(RequestListFavorite());
          return _buildListFavorites(state);
        }
        return _buildLoginMessage(context);
      },
    );
  }

  _buildListFavorites(state) {
    return BlocBuilder<DataBloc, DataStates>(
      builder: (context, dataState) => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(padding, 0, padding, 0),
          child: _buildListView(context, dataState),
        ),
      ),
    );
  }

  Widget _buildListView(context, state) {
    try {
      if (state.data.length <= 0) {
        throw Exception();
      }
      return ListView.builder(
        itemCount: state.data.length,
        itemBuilder: (context, index) =>
            _dataItemBuilder(context, state, index),
      );
    } on Exception catch (_) {
      return _buildEmpty();
    }
  }

  _dataItemBuilder(context, state, index) {
    return PostCard(PostData.fromEventData(state.data[index]));
  }

  Widget _buildLoginMessage(BuildContext context) {
    double padding = 16.0;
    return Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'One account, all your favorites\nwherever you are',
            style: AppTheme.titleForFavorites['textStyle'],
            textAlign: AppTheme.titleForFavorites['textAlign'],
          ),
          Divider(
            thickness: 2,
          ),
          _buildButton(context)
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(ChangeToRegisterEvent());
      },
      child: Text('Create One'),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'Looks like you don\'t have favorite items yet.',
        style: AppTheme.titleForFavorites['textStyle'],
        textAlign: AppTheme.titleForFavorites['textAlign'],
      ),
    );
  }
}
