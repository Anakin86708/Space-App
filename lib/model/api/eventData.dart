import 'package:flutter/material.dart';

class EventData {
  static const eventTable = 'event';

  final int serverID;
  final String url;
  final String eventName;
  final String typeName;
  final String description;
  final String location;
  final String newsUrl;
  final String videoUrl;
  final String imageUrl;
  final String date;
  final String launchID;
  final String spacestationID;
  final String programID;

  EventData(this.serverID,
      {this.url,
      this.eventName,
      this.typeName,
      this.description,
      this.location,
      this.newsUrl,
      this.videoUrl,
      this.imageUrl,
      this.date,
      this.launchID,
      this.spacestationID,
      this.programID});

  factory EventData.fromMapAPI(Map<String, dynamic> map) {
    return EventData(map['id'],
        url: map['url'],
        eventName: map['name'],
        typeName: map['type']['name'],
        description: map['description'],
        location: map['location'],
        newsUrl: map['news_url'],
        videoUrl: map['video_url'],
        imageUrl: map['feature_image'],
        date: map['date'],
        launchID: map['launches'].length > 0
            ? map['launches'][0]['id'].toString()
            : null,
        spacestationID: map['spacestations'].length > 0
            ? map['spacestations'][0]['id'].toString()
            : null,
        programID: map['program'].length > 0
            ? map['program'][0]['id'].toString()
            : null);
  }

  Map<String, dynamic> asMap() {
    return {
      'serverID': serverID,
      'url': url,
      'eventName': eventName,
      'typeName': typeName,
      'description': description,
      'location': location,
      'newsUrl': newsUrl,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'date': date,
      'launchID': launchID,
      'spacestationID': spacestationID,
      'programID': programID,
    };
  }

  Map<String, Map<String, dynamic>> getMenuItemIconList() {
    return {
      'newsUrl': {
        'name': 'Notícias',
        'icon': Icon(Icons.link),
        'value': newsUrl
      },
      'videoUrl': {
        'name': 'Vídeo',
        'icon': Icon(Icons.play_circle),
        'value': videoUrl
      },
    };
  }

  static String sqlCreateQuery() {
    return 'CREATE TABLE $eventTable ('
        'serverID INTEGER PRIMARY KEY,'
        'url TEXT,'
        'eventName TEXT,'
        'typeName TEXT,'
        'description TEXT,'
        'location TEXT,'
        'newsUrl TEXT,'
        'videoUrl TEXT,'
        'imageUrl TEXT,'
        'date TEXT,'
        'launchID TEXT,'
        'spacestationID TEXT,'
        'programID TEXT'
        ')';
  }
}
