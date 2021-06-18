import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:space_app/model/api/agencyData.dart';
import 'package:space_app/model/api/astronautData.dart';
import 'package:space_app/model/api/eventData.dart';
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
    Database db = await openDatabase(path,
        version: 9, onCreate: _createDB, onUpgrade: _upgradeDB);
    return db;
  }

  _createDB(Database db, int newVersion) async {
    await db.execute(EventData.sqlCreateQuery());
    await db.execute(AstronautData.sqlCreateQuery());
    await db.execute(AgencyData.sqlCreateQuery());
    print('Database create complete!');
  }

  _upgradeDB(Database db, int newVersion, int _) async {
    await db.execute('DROP TABLE IF EXISTS ${EventData.eventTable}');
    await db.execute('DROP TABLE IF EXISTS ${AstronautData.astronautTable}');
    await db.execute('DROP TABLE IF EXISTS ${AgencyData.agencyTable}');
    await _createDB(db, newVersion);
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

  Future<List<AstronautData>> getAllAstronauts() async {
    List<AstronautData> events = [];
    Database db = await this.database;
    List<Map<String, Object>> result =
        await db.rawQuery('SELECT * FROM ${AstronautData.astronautTable}');

    result.forEach((element) {
      events.add(AstronautData.fromMapAPI(element));
    });
    return events;
  }

  Future<int> insertAstronaut(AstronautData data) async {
    Database db = await this.database;
    return await db.insert(AstronautData.astronautTable, data.asMap());
  }

  Future<List<AgencyData>> getAllAgencies() async {
    List<AgencyData> events = [];
    Database db = await this.database;
    List<Map<String, Object>> result =
        await db.rawQuery('SELECT * FROM ${AgencyData.agencyTable}');

    result.forEach((element) {
      events.add(AgencyData.fromMapAPI(element));
    });
    return events;
  }

  Future<int> insertAgency(AgencyData data) async {
    Database db = await this.database;
    return await db.insert(AgencyData.agencyTable, data.asMap());
  }
}
