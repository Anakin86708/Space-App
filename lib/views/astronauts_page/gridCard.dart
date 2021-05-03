import 'package:flutter/material.dart';
import 'package:space_app/model/astronautData.dart';

class GridCard extends StatefulWidget {
  static const cardPadding = const EdgeInsets.all(8.0);
  AstronautData data;

  GridCard(
      {String title = 'Title',
      String content = 'Content',
      String imageUrl = '',
      bool isFavorited = false}) {
    data = AstronautData(title, content, imageUrl, isFavorited: isFavorited);
  }

  @override
  _GridCardState createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: double.infinity, minWidth: double.infinity),
          child: Padding(
            padding: GridCard.cardPadding,
            child: Stack(
              children: [widget.data.buildImage()],
            ),
          ),
        ));
  }
}
