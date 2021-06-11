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
        image: NetworkImage(imageUrl),
      );
    } on Exception catch (e) {
      return Image.asset('assets/images/404.png'); 
    }
  }
}
