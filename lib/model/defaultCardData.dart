import 'package:flutter/material.dart';

abstract class DefaultCardData {
  String title = 'Título';
  String content = 'Conteúdo';
  String imageUrl = '';
  bool isFavorited;

  DefaultCardData(this.title, this.content, this.imageUrl,
      {this.isFavorited = false});

  buildImage() {
    try {
      return FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'),
        image: imageUrl != '' ? NetworkImage(imageUrl) : AssetImage('assets/images/404.png'),
      );
    } on Exception catch (_) {
      return Image.asset('assets/images/404.png'); 
    }
  }
}
