import 'package:flutter/material.dart';

abstract class DefaultCardData {
  String title = 'Título';
  String content = 'Conteúdo';
  String imageUrl = '';
  bool isFavorited;

  DefaultCardData(this.title, this.content, this.imageUrl,
      {this.isFavorited = false});

  Image buildImage() {
    return Image.network(
      imageUrl,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset('assets/images/404.png'),
    );
  }
}
