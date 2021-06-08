class RocketData {
  static const eventTable = 'rocket';

  final int serverID;
  final String url;
  final String name;
  final String family;
  final String fullName;
  final String variant;

  RocketData(this.serverID, this.url, this.name, this.family, this.fullName,
      this.variant);

  static String sqlCreateQuery() {
    return 'CREATE TABLE $eventTable ('
        'serverID INTEGER PRIMARY KEY,'
        'url TEXT,'
        'name TEXT,'
        'family TEXT,'
        'fullName TEXT,'
        'variant TEXT,'
        ')';
  }
}
