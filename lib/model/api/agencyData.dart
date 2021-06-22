class AgencyData {
  static const agencyTable = 'agency';

  final int serverID;
  final String url;
  final String name;
  final String type;
  final String abbrev;
  final String description;
  final String foundingYear;
  final String launchers;
  final String spacecraft;
  final String imageUrl;

  AgencyData(
      this.serverID,
      this.url,
      this.name,
      this.type,
      this.abbrev,
      this.description,
      this.foundingYear,
      this.launchers,
      this.spacecraft,
      this.imageUrl);

  factory AgencyData.fromMapAPI(Map<String, dynamic> map) {
    return AgencyData(
        map['id'],
        map['url'],
        map['name'],
        map['type'],
        map['abbrev'],
        map['description'],
        map['founding_year'],
        map['launchers'],
        map['spacecraft'],
        map['image_url']);
  }

  Map<String, dynamic> asMap() {
    return {
      'id': serverID,
      'url': url ?? '',
      'name': name ?? '',
      'type': type ?? '',
      'abbrev': abbrev ?? '',
      'description': description ?? '',
      'founding_year': foundingYear ?? '',
      'launchers': launchers ?? '',
      'spacecraft': spacecraft ?? '',
      'image_url': imageUrl ?? ''
    };
  }

  static String sqlCreateQuery() {
    return 'CREATE TABLE $agencyTable ('
        'idDB INTEGER PRIMARY KEY AUTOINCREMENT,'
        'id INTEGER,'
        'url TEXT,'
        'name TEXT,'
        'type TEXT,'
        'abbrev TEXT,'
        'description TEXT,'
        'founding_year TEXT,'
        'launchers TEXT,'
        'spacecraft TEXT,'
        'image_url TEXT'
        ')';
  }
}
