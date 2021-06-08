import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:space_app/model/api/eventData.dart';
import 'package:space_app/model/api/launchData.dart';
import 'package:space_app/model/api/missionData.dart';
import 'package:space_app/model/api/rocketData.dart';
import 'package:space_app/model/api/spacestationData.dart';
import 'package:sqflite/sqflite.dart';

class APIDatabase {
  static const String FILENAME = 'api_data.db';

  static Database _database;
  static APIDatabase helper = APIDatabase._createInstance();
  APIDatabase._createInstance();

  Future<Database> get database async {
    return _database ?? await _initializeDatabase();
  }

  Future<Database> _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + FILENAME;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int newVersion) async {
    await db.execute(EventData.sqlCreateQuery());
    await db.execute(LaunchData.sqlCreateQuery());
    await db.execute(MissionData.sqlCreateQuery());
    await db.execute(RocketData.sqlCreateQuery());
    await db.execute(SpacestationData.sqlCreateQuery());
  }

  Future<List<EventData>> getAllEvents() async {
    Database db = await this.database;
    var result = db.rawQuery('SELECT * FROM ${EventData.eventTable}');
  }
}
