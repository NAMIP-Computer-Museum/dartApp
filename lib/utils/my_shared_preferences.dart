import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {

  static late SharedPreferences prefs;

  static late bool _isAuthorized;
  static late String _lang;
  static late int _year;
  static late int _month;
  static late int _day;
  static late Duration _premiumDuration;
  static late List<int> _favorites;

  ///Snake
  static late int _snakeHighScore;
  static late double _snakeSpeed;
  static late int _snakeGridSize;
  static late int _appleCount;
  static late bool _isClassicSnake;
  static late Color _snakeColor;

  static init() async {
    prefs = await SharedPreferences.getInstance();
    _isAuthorized = prefs.getBool('isAuthorized') ?? false;
    _lang = prefs.getString('lang') ?? 'fr';
    Get.updateLocale(Locale(_lang, ''));
    _initLimitedAccess();
    if (prefs.getStringList("favorites") == null) {
      await prefs.setStringList("favorites", []);
      _favorites = [];
    } else {
      _favorites = prefs.getStringList("favorites")!.map((e) => int.parse(e)).toList();
    }
    _snakeHighScore = prefs.getInt('snakeHighScore') ?? 0;
    _snakeSpeed = prefs.getDouble('snakeSpeed') ?? 0.5;
    _snakeGridSize = prefs.getInt('snakeGridSize') ?? 15;
    _appleCount = prefs.getInt('appleCount') ?? 1;
    _isClassicSnake = prefs.getBool('isClassicSnake') ?? false;
    _snakeColor = Color(prefs.getInt('snakeColor') ?? Colors.blue.value);
  }

  static _initLimitedAccess() async {
    _premiumDuration = const Duration(milliseconds: 20 * 1000);
    DateTime now = DateTime.now();
    /*try { //TODO: uncomment this
      now = await NTP.now();
    } catch (e) {
      now = DateTime.now();
    }*/
    int? year = prefs.getInt("year");
    year ??= now.year;
    int? month = prefs.getInt("month");
    month ??= now.month;
    int? day = prefs.getInt("day");
    day ??= now.day;
    if (prefs.getInt("duration") == null || year != now.year || month != now.month || day != now.day) {
      await prefs.setInt("duration", _premiumDuration.inMilliseconds);
      await prefs.setInt("year", now.year);
      await prefs.setInt("month", now.month);
      await prefs.setInt("day", now.day);
    } else {
      _premiumDuration = Duration(milliseconds: prefs.getInt("duration")!);
    }
  }

  static bool get isAuthorized => _isAuthorized;
  static String get lang => _lang;
  static int get year => _year;
  static int get month => _month;
  static int get day => _day;
  static Duration get premiumDuration => _premiumDuration;
  static List<int> get favorites => _favorites;
  static int get snakeHighScore => _snakeHighScore;
  static double get snakeSpeed => _snakeSpeed;
  static int get snakeGridSize => _snakeGridSize;
  static int get appleCount => _appleCount;
  static bool get isClassicSnake => _isClassicSnake;
  static Color get snakeColor => _snakeColor;

  static updateLang(String value) async {
    _lang = value;
    await prefs.setString('lang', value);
    Get.updateLocale(Locale(value, ''));
  }

  static setDate(DateTime date) async {
    _year = date.year;
    _month = date.month;
    _day = date.day;
    await prefs.setInt('year', date.year);
    await prefs.setInt('month', date.month);
    await prefs.setInt('day', date.day);
  }

  static setPremiumDuration(Duration value) async {
    _premiumDuration = value;
    await prefs.setInt('premiumDuration', value.inMilliseconds);
  }

  static authorized() async {
    _isAuthorized = true;
    await prefs.setBool('isAuthorized', true);
  }

  static setDuration(int value) async {
    await prefs.setInt("duration", value);
  }

  static addFavorite(int id) async {
    _favorites.add(id);
    await prefs.setStringList("favorites", _favorites.map((e) => e.toString()).toList());
  }

  static removeFavorite(int id) async {
    bool canRemove = _favorites.remove(id);
    if (canRemove) {
      await prefs.setStringList("favorites", _favorites.map((e) => e.toString()).toList());
    }
  }

  ///Snake
  static updateSnakeHighScore(int value) async {
    _snakeHighScore = value;
    await prefs.setInt('snakeHighScore', value);
  }

  static updateSnakeSpeed(double value) async {
    _snakeSpeed = value;
    await prefs.setDouble('snakeSpeed', value);
  }

  static updateSnakeGridSize(int value) async {
    _snakeGridSize = value;
    await prefs.setInt('snakeGridSize', value);
  }

  static updateAppleCount(int value) async {
    _appleCount = value;
    await prefs.setInt('appleCount', value);
  }

  static updateIsClassicSnake(bool value) async {
    _isClassicSnake = value;
    await prefs.setBool('isClassicSnake', value);
  }

  static updateSnakeColor(Color value) async {
    _snakeColor = value;
    await prefs.setInt('snakeColor', value.value);
  }
}