import 'package:flutter/material.dart';
import 'package:space_app/model/api/astronautData.dart';
import 'package:space_app/theme/themeData.dart';

class AstronautsPage extends StatelessWidget {
  const AstronautsPage(this.data) : super();

  final AstronautData data;

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

  generateImage() {
    try {
      return FadeInImage(
        placeholder: AssetImage('assets/images/loading.gif'),
        image: data.profileImage != ''
            ? NetworkImage(data.profileImage,)
            : AssetImage('assets/images/404.png'),
            fit: BoxFit.fill,
      );
    } on Exception catch (_) {
      return Image.asset('assets/images/404.png');
    }
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
        _generateAstronautStatus(),
        _generateAstronautAgency(),
        SizedBox(height: 10),
        _generateAstronautBio(),
      ],
    );
  }

  Text _generateAstronautBio() {
    return Text(
      data.bio,
      style: AppTheme.postStyle["contentStyle"],
      textAlign: AppTheme.postStyle["contentJustify"],
    );
  }

  Text _generateAstronautStatus() {
    List<String> splittedDateDeath = data.dateDeath.split("-");
    var dateDeath = data.dateDeath != ''
        ? 'Status: ' + data.status + ' (${splittedDateDeath[0]})'
        : 'Status: ' + data.status;

    return Text(
      dateDeath,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }

  Text _generateAstronautAgency() {
    return Text(
      'Agency: ' + data.agency,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}
