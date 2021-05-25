import 'dart:async';
import 'dart:io';

import 'package:space_app/model/settingsData.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseLocalServer {
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  static Database _database;

  String _tableName = 'Settings';
  String _colEventNotificationState = 'event_notification';
  String _colOnlyFavoriteState = 'only_favorite';
  String _colUpdateFrequencyState = 'update_frequency';
  int _sizeColUpdate = 20;
  int _id = 1;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "settings.db";

    Database notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, $_colEventNotificationState INT, $_colOnlyFavoriteState INT, $_colUpdateFrequencyState TEXT)");
    print(SettingsData.avaliableUpdatesFrequency[0]);
    await db.insert(_tableName, {
      'id': _id,
      _colEventNotificationState: 0,
      _colOnlyFavoriteState: 0,
      _colUpdateFrequencyState: SettingsData.avaliableUpdatesFrequency[0],
    });
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
    notify();
    print("asdf $data");
    return data;
  }

  // UPDATE
  Future<int> updateNote(SettingsData data) async {
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
