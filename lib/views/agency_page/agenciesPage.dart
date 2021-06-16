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
        _generateAgencyDescription(),
      ],
    );
  }

  Column _generateAgencyDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Founding Year: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text(
              data.foundingYear,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        _generateLaunches(),
        _generateSpacecraft(),
        SizedBox(height: 10),
        Text(
          data.description,
          style: AppTheme.postStyle["contentStyle"],
          textAlign: AppTheme.postStyle["contentJustify"],
        ),
      ],
    );
  }

  _generateLaunches() {
    var launches = (data.launchers);

    if (launches != '') {
      return Row(
        children: [
          Text(
            'Total of Launches: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            data.launchers,
            style: TextStyle(fontSize: 15),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }

  _generateSpacecraft() {
    var spacecraft = data.spacecraft;

    if (spacecraft != '') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spacecraft: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Expanded(
            child: Text(
              data.spacecraft,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }
}
