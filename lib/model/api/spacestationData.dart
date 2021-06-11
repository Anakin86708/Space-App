class SpacestationData {
  static const eventTable = 'spacestation';

  final int serverID;
  final String url;
  final String name;
  final String status;
  final String founded;
  final String description;
  final String orbit;
  final String imageUrl;

  SpacestationData(this.serverID, this.url, this.name, this.status,
      this.founded, this.description, this.orbit, this.imageUrl);

  static String sqlCreateQuery() {
    return 'CREATE TABLE $eventTable ('
        'serverID INTEGER PRIMARY KEY,'
        'url TEXT,'
        'name TEXT,'
        'status TEXT,'
        'founded TEXT,'
        'description TEXT,'
        'orbit TEXT,'
        'imageUrl TEXT'
        ')';
  }
}
