import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/profile/profileBloc.dart';
import 'package:space_app/bloc/profile/profileEvents.dart';
import 'package:space_app/bloc/profile/profileStates.dart';
import 'package:space_app/theme/themeData.dart';
import 'package:space_app/views/initialLayout.dart';
import 'package:space_app/views/interfacePage.dart';
import 'package:space_app/views/initial_page/postCard.dart';

class FavoritePage extends StatefulWidget implements InterfacePage {
  final Icon _pageIcon = Icon(Icons.star);
  final String _pageName = 'Favoritos';

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
          return _buildListFavorites();
        }
        return _buildLoginMessage(context);
      },
    );
  }

  Container _buildListFavorites() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: ListView.builder(
          itemBuilder: (context, index) => new PostCard(),
        ),
      ),
    );
  }

  Widget _buildLoginMessage(BuildContext context) {
    double padding = 16.0;
    return Container(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uma conta, todos seus favoritos\nonde quer que esteja',
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
      child: Text('Criar uma'),
    );
  }
}
