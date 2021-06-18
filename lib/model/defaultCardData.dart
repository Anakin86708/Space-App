import 'package:flutter/material.dart';
import 'package:space_app/database/favoritesDatabase.dart';

abstract class DefaultCardData {
  int id;
  String title = 'Título';
  String content = 'Conteúdo';
  String imageUrl = '';
  bool _isFavorited = false;

  DefaultCardData(this.id, this.title, this.content, this.imageUrl,
      {bool isFavorited}) {
    this._isFavorited = isFavorited;
  }

  buildImage() {
    try {
      return FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'),
        image: imageUrl != ''
            ? NetworkImage(imageUrl)
            : AssetImage('assets/images/404.png'),
      );
    } on Exception catch (_) {
      return Image.asset('assets/images/404.png');
    }
  }

  bool get isFavorited => _isFavorited;

  set isFavorited(bool value) {
    value ? FavoriteDatabase.helper.insertFavorite(id) : FavoriteDatabase.helper.removeFavorite(id);
    _isFavorited = value;
  }
}
