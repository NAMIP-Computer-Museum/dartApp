import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../models/component.dart';

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

  Future<List<Component>> getComponentsMicro() async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.query('GENERAL');
    if (maps == null) return List.empty();
    List<Component> components = await getCopyListWithLogo(maps);
    return components;
  }

  Future<Map<String, Object?>?> getComponentData(int id, String type, int annee) async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.rawQuery("SELECT * FROM  $type WHERE ID = $id");
    Map<String, Object?> copy = Map.from(maps![0]);
    copy['année'] = annee;
    return maps.length == 1 ? copy : null;
  }

  Future<Component?> getComponentByID(int id) async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.rawQuery('SELECT * FROM GENERAL WHERE ID = $id');
    if (maps?.length != 1) return null;
    List<Component> components = await getCopyListWithLogo(maps!);
    return components.first;
  }

  Future<List<Component>> getComponentByIDList(List<int> ids) async {
    List<Component> microComponents = await getComponentsMicro();

    return microComponents.where((element) => ids.contains(element.id)).toList();
  }

  Future<List<Component>> getCopyListWithLogo(List<Map<String, Object?>> maps) async {
    List<Component> components = List.empty(growable: true);
    final String response = await rootBundle.loadString("assets/data/componentsImagesData.json");
    final Map data = await json.decode(response);
    for (int i = 0; i < maps.length; i++) {
      Map copy = Map.from(maps[i]);
      copy["logo"] = data[copy["ID"].toString()];
      components.add(Component.fromMap(copy));
    }
    return components;
  }

  Future<Database?> initDb() async { // code by https://blog.devgenius.io/adding-sqlite-db-file-from-the-assets-internet-in-flutter-3ec42c14cd44
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