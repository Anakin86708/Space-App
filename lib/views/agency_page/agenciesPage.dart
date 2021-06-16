import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:space_app/model/api/agencyData.dart';
import 'package:space_app/theme/themeData.dart';

class AgenciesPage extends StatelessWidget {
  const AgenciesPage(this.data) : super();
  final AgencyData data;

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: post(),
    );
  }

  Widget post() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              banner(),
              Container(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _generateTitle(),
                  SizedBox(height: 20),
                  _generateContentText(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget banner() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        constraints: BoxConstraints.expand(),
        child: generateImage(),
      ),
    );
  }

  Image generateImage() {
    return Image.network(
      data.imageUrl,
      fit: BoxFit.fill,
    );
  }

  Text _generateTitle() {
    return Text(
      data.name,
      style: AppTheme.postStyle["titleStyle"],
    );
  }

  Column _generateContentText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _generateAstronautStatus(),
        // _generateAstronautAgency(),
        // SizedBox(height: 10),
        // _generateAstronautBio(),
      ],
    );
  }
}
