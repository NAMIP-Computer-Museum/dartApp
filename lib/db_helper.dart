import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {

  Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, ''),
    );
  }

  static late Database _db;

  Future<Database> get db async {
    // https://camposha.info/flutter/fr/flutter-sqflite/#gsc.tab=0
    if (_db != null) return _db;
    _db = await database();
    return _db;
  }
}