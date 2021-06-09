import 'package:flutter/material.dart';
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
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(padding, 0, padding, 0),
        child: ListView.builder(
          itemBuilder: (context, index) => new PostCard(),
        ),
      ),
    );
  }
}