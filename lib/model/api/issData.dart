class IssData {
  static const issTable = 'iss';

  final int serverID;
  final String url;
  final String name;
  final String founded;
  final String deorbited;
  final String description;
  final String orbit;
  final String imageUrl;

  IssData(this.serverID, this.url, this.name, this.founded, this.deorbited,
      this.description, this.orbit, this.imageUrl);

  factory IssData.fromMapAPI(Map<String, dynamic> map) {
    return IssData(
      map['id'],
      map['url'],
      map['name'],
      map['founded'],
      map['deorbited'],
      map['description'],
      map['orbit'],
      map['image_url'],
    );
  }

  Map<String, dynamic> asMap() {
    return {
      'id': serverID,
      'url': url ?? '',
      'name': name ?? '',
      'founded': founded ?? '',
      'deorbited': deorbited ?? '',
      'description': description ?? '',
      'orbit': orbit ?? '',
      'image_url': imageUrl ?? '',
    };
  }

  static String sqlCreateQuery() {
    return 'CREATE TABLE $issTable ('
        'idDB INTEGER PRIMARY KEY AUTOINCREMENT,'
        'id INTEGER,'
        'url TEXT,'
        'name TEXT,'
        'founded TEXT,'
        'deorbited TEXT,'
        'description TEXT,'
        'orbit TEXT,'
        'image_url TEXT'
        ')';
  }
}
