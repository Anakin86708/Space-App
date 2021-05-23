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
        "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, $colEventNotificationState BIT, $colOnlyFavoriteState BIT, $colUpdateFrequencyState CHARACTERE($sizeColUpdate))");
    await db.execute(
        "INSERT INTO $tableName ($colEventNotificationState, $colOnlyFavoriteState, $colUpdateFrequencyState) VALUES (0, 0, ${SettingsData.avaliableUpdatesFrequency[0]})");
  }

  Future<List<dynamic>> getNoteList() async {
    Database db = await this.database;
    var settingsMapList = await db.rawQuery("SELECT * FROM $tableName");

    SettingsData data = new SettingsData();

    return [noteList, idList];
  }

  // UPDATE
  Future<int> updateNote(int noteId, Note note) async {
    Database db = await this.database;
    var result = await db.update(
      noteTable,
      note.toMap(),
      where: "id = ?",
      whereArgs: [noteId],
    );
    notify();
    return result;
  }
}
