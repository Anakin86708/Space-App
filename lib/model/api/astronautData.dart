class AstronautData {
  static const astronautTable = 'astronaut';

  final int serverID;
  final String url;
  final String name;
  final String status;
  final String dateBirth;
  final String dateDeath;
  final String nationality;
  final String bio;
  final String agency;
  final String profileImage;
  final String profileImageThumbnail;

  AstronautData(
      this.serverID,
      this.url,
      this.name,
      this.status,
      this.dateBirth,
      this.dateDeath,
      this.nationality,
      this.bio,
      this.agency,
      this.profileImage,
      this.profileImageThumbnail);

  factory AstronautData.fromMapAPI(Map<String, dynamic> map) {
    return AstronautData(
      map['id'],
      map['url'],
      map['name'],
      _getStatus(map),
      _getBirth(map),
      _getDeath(map),
      map['nationality'],
      map['bio'],
      _getAgency(map),
      map['profile_image'],
      map['profile_image_thumbnail'],
    );
  }

  static String _getStatus(Map<String, dynamic> map) {
    const name = 'status';
    if (map[name] != null) {
      return map[name] is String ? map[name] : map[name]['name'];
    }
    return '';
  }

  static String _getBirth(Map<String, dynamic> map) {
    const name = 'date_of_birth';
    if (map[name] != null) {
      return map[name] is String ? map[name] : map[name]['name'];
    }
    return '';
  }

  static String _getDeath(Map<String, dynamic> map) {
    const name = 'date_of_death';
    if (map[name] != null) {
      return map[name] is String ? map[name] : map[name]['name'];
    }
    return '';
  }

  static String _getAgency(Map<String, dynamic> map) {
    const name = 'agency';
    if (map[name] != null) {
      return map[name] is String ? map[name] : map[name]['name'];
    }
    return '';
  }

  Map<String, dynamic> asMap() {
    return {
      'id': serverID,
      'url': url ?? '',
      'name': name ?? '',
      'status': status ?? '',
      'date_of_birth': dateBirth ?? '',
      'date_of_death': dateDeath ?? '',
      'nationality': nationality ?? '',
      'bio': bio ?? '',
      'agency': agency ?? '',
      'profile_image': profileImage ?? '',
      'profile_image_thumbnail': profileImageThumbnail ?? ''
    };
  }

  static String sqlCreateQuery() {
    return 'CREATE TABLE $astronautTable ('
        'idDB INTEGER PRIMARY KEY AUTOINCREMENT,'
        'id INTEGER,'
        'url TEXT,'
        'name TEXT,'
        'status TEXT,'
        'date_of_birth TEXT,'
        'date_of_death TEXT,'
        'nationality TEXT,'
        'bio TEXT,'
        'agency TEXT,'
        'profile_image TEXT,'
        'profile_image_thumbnail TEXT'
        ')';
  }
}
