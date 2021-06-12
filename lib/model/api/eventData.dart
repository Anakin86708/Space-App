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
 });

  factory EventData.fromMapAPI(Map<String, dynamic> map) {
    return EventData(map['id'],
        url: map['url'],
        eventName: map['name'] ?? '',
        typeName: _getType(map),
        description: map['description'] ?? '',
        location: map['location'],
        newsUrl: map['news_url'],
        videoUrl: map['video_url'],
        imageUrl: map['feature_image'] ?? '',
        date: map['date'],
       );
  }

  static _getType(Map<String, dynamic> map) {
    if (map['type'] != null) {
      return map['type'] is String ? map['type'] : map['type']['name'];
    }
    return '';
  }

  Map<String, dynamic> asMap() {
    return {
      'serverID': serverID,
      'url': url,
      'name': eventName,
      'type': typeName,
      'description': description,
      'location': location,
      'news_url': newsUrl,
      'video_url': videoUrl,
      'feature_image': imageUrl,
      'date': date,
    };
  }

  Map<String, Map<String, dynamic>> getMenuItemIconList() {
    return {
      'news_url': {
        'name': 'Notícias',
        'icon': Icon(Icons.link),
        'value': newsUrl
      },
      'video_url': {
        'name': 'Vídeo',
        'icon': Icon(Icons.play_circle),
        'value': videoUrl
      },
    };
  }

  static String sqlCreateQuery() {
    return 'CREATE TABLE $eventTable ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'serverID INTEGER,'
        'url TEXT,'
        'name TEXT,'
        'type TEXT,'
        'description TEXT,'
        'location TEXT,'
        'news_url TEXT,'
        'video_url TEXT,'
        'feature_image TEXT,'
        'date TEXT'
        ')';
  }
}
