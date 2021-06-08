class EventData {
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
  final int launchID;
  final int spacestationID;
  final int programID;

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

  static String sqlCreateQuery() {
    const eventTable = 'event';
    return 'CREATE TABLE $eventTable ('
        'serverID INTEGER PRIMARY KEY,'
        'url TEXT,'
        'eventName TEXT,'
        'typeName TEXT,'
        'descripti TEXT,'
        'location TEXT,'
        'newsUrl TEXT,'
        'videoUrl TEXT,'
        'imageUrl TEXT,'
        'date TEXT,'
        'launchID INTEGER,'
        'spacestation INTEGER,'
        'programID INTEGER,'
        ')';
  }
}
