import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:space_app/model/api/eventData.dart';
import 'package:space_app/model/api/launchData.dart';
import 'package:space_app/model/api/missionData.dart';
import 'package:space_app/model/api/rocketData.dart';
import 'package:space_app/model/api/spacestationData.dart';
import 'package:sqflite/sqflite.dart';

class APIDatabase {
  static const String FILENAME = '/api_data.db';

  static Database _database;
  static APIDatabase helper = APIDatabase._createInstance();
  APIDatabase._createInstance();

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }
    return _database;
    // return _database ?? await _initializeDatabase();
  }

  Future<Database> _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + FILENAME;
    print('Initialized database');
    Database db = await openDatabase(path, version: 2, onCreate: _createDB);
    return db;
  }

  _createDB(Database db, int newVersion) async {
    await db.execute(EventData.sqlCreateQuery());
    await db.execute(LaunchData.sqlCreateQuery());
    await db.execute(MissionData.sqlCreateQuery());
    await db.execute(RocketData.sqlCreateQuery());
    await db.execute(SpacestationData.sqlCreateQuery());
    print('Database create complete!');
  }

  Future<List<EventData>> getAllEvents() async {
    List<EventData> events = [];
    Database db = await this.database;
    List<Map<String, Object>> result =
        await db.rawQuery('SELECT * FROM ${EventData.eventTable}');

    result.forEach((element) {
      events.add(EventData.fromMapAPI(element));
    });
    return events;
  }

  Future<int> insertEvent(EventData data) async {
    Database db = await this.database;
    return await db.insert(EventData.eventTable, data.asMap());
  }
}
