import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();
  Database _database;
  Future<Database> get database async {
    if (_database != null)
      return _database;

    // 如果数据库不存在
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "accompany.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Message ("
          "id INTEGER PRIMARY KEY,"
          "messageid INTEGER,"
          "fromid INTEGER,"
          "toid INTEGER,"
          "content TEXT,"
          "read INTEGER,"
          "time NUMERIC"
          ")");
    });
  }
}

