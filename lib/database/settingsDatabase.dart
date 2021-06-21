import 'dart:async';
import 'dart:io';

import 'package:space_app/model/settingsData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SettingsDatabaseLocalServer {
  static SettingsDatabaseLocalServer helper =
      SettingsDatabaseLocalServer._createInstance();
  SettingsDatabaseLocalServer._createInstance();

  static Database _database;

  String _tableName = 'Settings';
  String _colEventNotificationState = 'event_notification';
  String _colOnlyFavoriteState = 'only_favorite';
  String _colUpdateFrequencyState = 'update_frequency';
  int _id = 1;

  String _lastUpdateName = 'last_update';
  String _lastUpdateDate = 'update_date';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "settings.db";

    Database notesDatabase = await openDatabase(path,
        version: 6, onCreate: _createDb, onUpgrade: _upgradeDB);
    return notesDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await _createSettingsTable(db);
    await _insertSettings(db);

    await _createLastUpdateTable(db);
    await _insertLastUpdate(db);
  }

  _upgradeDB(Database db, int newVersion, int _) async {
    await db.execute('DROP TABLE IF EXISTS $_lastUpdateName');
    await db.execute('DROP TABLE IF EXISTS $_tableName');
    await _createDb(db, newVersion);
  }

  Future<void> _createSettingsTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $_tableName (id INTEGER PRIMARY KEY, $_colEventNotificationState INT, $_colOnlyFavoriteState INT, $_colUpdateFrequencyState TEXT)");
  }

  Future<void> _insertSettings(Database db) async {
    await db.insert(_tableName, {
      'id': _id,
      _colEventNotificationState: 0,
      _colOnlyFavoriteState: 0,
      _colUpdateFrequencyState: SettingsData.availableUpdatesFrequency[0],
    });
  }

  Future<void> _createLastUpdateTable(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $_lastUpdateName (id INTEGER PRIMARY KEY AUTOINCREMENT, $_lastUpdateDate DATE)");
  }

  Future<void> _insertLastUpdate(Database db) async {
    await db.rawInsert(
        "INSERT INTO $_lastUpdateName ($_lastUpdateDate) VALUES (datetime('now','-1 year', 'localtime'))");
    print('table $_lastUpdateName ok');
  }

  Future<SettingsData> getSettingsData() async {
    Database db = await this.database;
    var settingsMapList = await db.rawQuery("SELECT * FROM $_tableName");

    SettingsData data = new SettingsData();
    data.eventNotificationsState =
        settingsMapList[0][_colEventNotificationState] == 1 ? true : false;
    data.onlyFavoriteState =
        settingsMapList[0][_colOnlyFavoriteState] == 1 ? true : false;
    data.updateFrequencyValue = settingsMapList[0][_colUpdateFrequencyState];
    return data;
  }

  Future<DateTime> getLastUpdateDate() async {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $_lastUpdateName");
    return _dbStringToDateTime(result[0][_lastUpdateDate]);
  }

  DateTime _dbStringToDateTime(String dateString) {
    List split = dateString.split(' ');
    String date = split[0];
    String time = split[1];
    List dateSplit = date.split('-').map((e) => int.parse(e)).toList();
    List timeSplit = time.split(':').map((e) => int.parse(e)).toList();
    return DateTime(
        dateSplit[0], dateSplit[1], dateSplit[2], timeSplit[0], timeSplit[1]);
  }

  setLastUpdateDateNow() async {
    Database db = await this.database;
    await db.rawUpdate(
        "UPDATE $_lastUpdateName SET $_lastUpdateDate = datetime('now', 'localtime')");
  }

  Future<String> getUpdateFrequency() async {
    SettingsData data = await this.getSettingsData();
    return data.updateFrequencyValue;
  }

  Future<int> updateSettings(SettingsData data) async {
    Database db = await this.database;
    var result = await db.update(
      _tableName,
      _convertDataToMap(data),
      where: "id = ?",
      whereArgs: [_id],
    );
    print('Atualizado DB');
    notify();
    return result;
  }

  Map<String, Object> _convertDataToMap(SettingsData data) {
    Map<String, Object> convertedMap = {};
    convertedMap[_colEventNotificationState] =
        data.eventNotificationsState ? 1 : 0;
    convertedMap[_colOnlyFavoriteState] = data.onlyFavoriteState ? 1 : 0;
    convertedMap[_colUpdateFrequencyState] = data.updateFrequencyValue;

    return convertedMap;
  }

  clearUpdateDatabase() async {
    Database db = await this.database;
    await db.execute('DROP TABLE IF EXISTS $_lastUpdateName');
    await _createLastUpdateTable(db);
    await _insertLastUpdate(db);
  }

  notify() async {
    if (_controller != null) {
      var response = await getSettingsData();
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  static StreamController _controller;
}
