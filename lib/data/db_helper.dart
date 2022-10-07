import 'dart:convert';
import 'dart:developer';

import 'package:enough_convert/enough_convert.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../models/component.dart';

class DBHelper {

  static Database? _db;
  static Database? _db2;
  static const dbName = 'NAMIP.db';
  static const dbName2 = 'EXPOP-V1.db';

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database?> get db2 async {
    if (_db2 != null) return _db2;
    _db2 = await initDb2();
    return _db2;
  }

  Future<void> closeDb() async {
    await _db?.close();
  }

  Future<List<Component>> getComponentsMicro() async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.query('GENERAL');
    if (maps == null) return List.empty();
    List<Component> components = await getCopyListWithLogo(maps, false);
    return components;
  }

  Future<List<Component>> getComponentsPerma() async {
    Database? myDb = await db2;
    final List<Map<String, Object?>>? maps = await myDb?.query('GENERAL');
    if (maps == null) return List.empty();
    List<Component> components = await getCopyListWithLogo(maps, true);
    return components;
  }

  Future<Map<String, Object?>?> getComponentData(int id, String type, int annee) async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.rawQuery("SELECT * FROM  $type WHERE ID = $id");
    Map<String, Object?> copy = Map.from(maps![0]);
    copy['année'] = annee;
    return maps.length == 1 ? copy : null;
  }

  Future<List<Map<String, Object?>>?> getKeywords(int id) async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.rawQuery('SELECT * FROM MOTCLE WHERE IDObjetDesc = $id');
    return maps;
  }

  Future<Component?> getComponentByID(int id) async {
    Database? myDb = await db;
    final List<Map<String, Object?>>? maps = await myDb?.rawQuery('SELECT * FROM GENERAL WHERE ID = $id');
    if (maps?.length != 1) return null;
    List<Component> components = await getCopyListWithLogo(maps!, false);
    return components.first;
  }

  Future<List<Component>> getComponentByIDList(List<int> ids) async {
    List<Component> microComponents = await getComponentsMicro();
    List<Component> permaComponents = await getComponentsPerma();
    List<Component> allComponents = microComponents + permaComponents;

    return allComponents.where((element) => ids.contains(element.id)).toList();
  }

  Future<List<Component>> getCopyListWithLogo(List<Map<String, Object?>> maps, bool isPerma) async {
    final String s = isPerma ? '0' : '';
    List<Component> components = List.empty(growable: true);
    final String response = await rootBundle.loadString("assets/data/componentsImagesData.json");
    final Map data = await json.decode(response);
    for (int i = 0; i < maps.length; i++) {
      Map copy = Map.from(maps[i]);
      copy["logo"] = data[s + copy["ID"].toString()];
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

  Future<Database?> initDb2() async {
    io.Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String dbPathEnglish = join(applicationDirectory.path, dbName2);

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", dbName2));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }
    _db2 = await openDatabase(dbPathEnglish);
    return _db2;
  }

  static Future<void> transformJsonInDbFile() async { //TODO à supprimer
    Database db = await openDatabase('assets/perma_data.db');
    await db.execute("DROP TABLE IF EXISTS GENERAL");
    await db.execute("CREATE TABLE GENERAL ("
      "ID INTEGER,"
      "Date TEXT,"
      "Société TEXT,"
      "Titre TEXT,"
      "Localisation TEXT,"
      "Description TEXT,"
      "Type TEXT,"
      "Full_Date TEXT,"
      "PRIMARY KEY (ID))"
    );

    const codec = Windows1252Codec();
    final ByteData byteData = await rootBundle.load("assets/data/all_data.json");
    final String response = codec.decode(byteData.buffer.asUint8List());
    final List<dynamic> data = await json.decode(response);

    String s = "";
    for (int i = 0; i < data.length; i++) {
      Map<String, Object?> map = data[i];
      await db.insert("GENERAL", map);
      String desc = map["description"] as String;
      desc = desc.replaceAll("\"", "\\\"");
      s +='INSERT INTO GENERAL (Annee, Société, Titre, Localisation, Description, Type, Full_Date) VALUES ("${map["date"]}", "${map["société"]}", "${map["titre"]}", "${map["localisation"]}", "$desc}", "${map["type"]}", "${map["full_date"]}");\n';
    }
    log(s);
  }
}