import 'dart:async';
import 'dart:io';

import 'package:space_app/model/settingsData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  static Database _database;

  String tableName = 'Settings';
  String colEventNotificationState = 'event_notification';
  String colOnlyFavoriteState = 'only_favorite';
  String colUpdateFrequencyState = 'update_frequency';
  int sizeColUpdate = 20;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "notes.db";

    Database notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName (id INTEGER PRIMARY KEY, $colEventNotificationState BIT, $colOnlyFavoriteState BIT, $colUpdateFrequencyState CHARACTERE($sizeColUpdate))");
    await db.execute(
        "INSERT INTO $tableName (id, $colEventNotificationState, $colOnlyFavoriteState, $colUpdateFrequencyState) VALUES (0, 0, 0, ${SettingsData.avaliableUpdatesFrequency[0]})");
  }

  Future<SettingsData> getSettingsData() async {
    Database db = await this.database;
    var settingsMapList = await db.rawQuery("SELECT * FROM $tableName");

    SettingsData data = new SettingsData();
    data.eventNotificationsState =
        settingsMapList[0][colEventNotificationState];
    data.onlyFavoriteState = settingsMapList[0][colOnlyFavoriteState];
    data.updateFrequencyValue = settingsMapList[0][colUpdateFrequencyState];
    return data;
  }

  // UPDATE
  Future<int> updateNote(SettingsData data) async {
    Database db = await this.database;
    var result = await db.update(
      tableName,
      _convertDataToMap(data),
      where: "id = ?",
      whereArgs: [0],
    );
    notify();
    return result;
  }

  Map<String, Object> _convertDataToMap(SettingsData data) {
    var convertedMap = {};
    convertedMap[colEventNotificationState] =
        data.eventNotificationsState ? 1 : 0;
    convertedMap[colOnlyFavoriteState] = data.onlyFavoriteState ? 1 : 0;
    convertedMap[colUpdateFrequencyState] = data.updateFrequencyValue;

    return convertedMap;
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
