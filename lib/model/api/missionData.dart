class MissionData {
  static const eventTable = 'mission';
  
  final int serverID;
  final String name;
  final String description;
  final String launchDesignator;
  final String type;
  final String orbitName;

  MissionData(this.serverID, this.name, this.description, this.launchDesignator,
      this.type, this.orbitName);

  static String sqlCreateQuery() {
    return 'CREATE TABLE $eventTable ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'serverID INTEGER,'
        'name TEXT,'
        'description TEXT,'
        'launchDesignator TEXT,'
        'type TEXT,'
        'orbitName TEXT'
        ')';
  }
}
