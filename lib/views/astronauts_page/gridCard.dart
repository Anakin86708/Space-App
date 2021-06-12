import 'package:flutter/material.dart';
import 'package:space_app/model/api/astronautData.dart';
import 'package:space_app/model/astronautData.dart';

class AstronautGridCard extends StatefulWidget {
  static const cardPadding = const EdgeInsets.all(8.0);
  LocalAstronautData data;
  AstronautData apiData;

  AstronautGridCard(
      {String title = 'Title',
      String content = 'Content',
      String imageUrl = '',
      bool isFavorited = false, this.apiData}) {
    data =
        LocalAstronautData(title, content, imageUrl, isFavorited: isFavorited);
  }

  factory AstronautGridCard.fromAstronautData(AstronautData data) {
    return AstronautGridCard(
        title: data.name,
        content: data.bio,
        imageUrl: data.profileImageThumbnail, apiData: data,);
  }

  @override
  _AstronautGridCardState createState() => _AstronautGridCardState();
}

class _AstronautGridCardState extends State<AstronautGridCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: double.infinity, minWidth: double.infinity),
          child: Padding(
            padding: AstronautGridCard.cardPadding,
            child: Stack(
              children: [widget.data.buildImage()],
            ),
          ),
        ));
  }
}
