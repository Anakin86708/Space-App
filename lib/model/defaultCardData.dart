import 'package:flutter/material.dart';

abstract class DefaultCardData {
  String title = 'Título';
  String content = 'Conteúdo';
  String imageUrl = 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.mundoecologia.com.br%2Fwp-content%2Fuploads%2F2020%2F05%2FPato-Bravo-1.jpg&f=1&nofb=1';
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
