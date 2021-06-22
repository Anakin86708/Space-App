import 'package:flutter/material.dart';
import 'package:space_app/model/agencyData.dart';
import 'package:space_app/model/api/agencyData.dart';
import 'package:space_app/theme/appColors.dart';

class AgencyGridCard extends StatefulWidget {
  static const cardPadding = const EdgeInsets.all(8.0);
  AgencyData apiData;
  LocalAgencyData data;

  AgencyGridCard(
      {String title = 'Title',
      String content = 'Content',
      String imageUrl = '',
      this.apiData}) {
    data = LocalAgencyData(title, content, imageUrl, data: apiData);
  }

  factory AgencyGridCard.fromAgencyData(AgencyData data) {
    return AgencyGridCard(
        title: data.name,
        content: data.description,
        imageUrl: data.imageUrl,
        apiData: data);
  }

  @override
  _AgencyGridCard createState() => _AgencyGridCard();
}

class _AgencyGridCard extends State<AgencyGridCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: double.infinity, minWidth: double.infinity),
          child: Padding(
            padding: AgencyGridCard.cardPadding,
            child: Stack(
              children: [
                Center(child: widget.data.buildImage()),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    widget.data.title,
                    style: TextStyle(
                        color: AppColors.accent,
                        backgroundColor: AppColors.primary.shade100),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
