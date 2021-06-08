class MissionData {
  final int serverID;
  final String name;
  final String description;
  final String launchDesignator;
  final String type;
  final String orbitName;

  MissionData(this.serverID, this.name, this.description, this.launchDesignator,
      this.type, this.orbitName);

  static String sqlCreateQuery() {
    const eventTable = 'mission';
    return 'CREATE TABLE $eventTable ('
        'serverID INTEGER PRIMARY KEY,'
        'name TEXT,'
        'description TEXT,'
        'launchDesignator TEXT,'
        'type TEXT,'
        'orbitName TEXT,'
        ')';
  }
}
