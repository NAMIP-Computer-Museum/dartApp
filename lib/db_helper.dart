import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {

  static Database? _db;
  static const dbName = 'NAMIP.db';

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<void> closeDb() async {
    await _db?.close();
  }

  void printDb() async {
    var myDb = await db;
    print(myDb);
    final List<Map<String, Object?>>? maps = await myDb?.query('GENERAL');
    print(jsonEncode(maps));
  }

  Future<Database?> initDb() async {
    io.Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPathEnglish = join(applicationDirectory.path, dbName);

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", dbName));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    _db = await openDatabase(dbPathEnglish);
    return _db;
  }
}