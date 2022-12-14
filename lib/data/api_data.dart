import 'dart:convert';
import 'dart:developer';

import '../models/person.dart';

import 'package:http/http.dart' as http;

class ApiData {
  static List<Person> persons = [];
  static Map<int, Person> personsMap = {};

  static Future<void> loadAllPersons() async {
    Uri url = Uri.https('sig.cetic.be', '/trajectware-1/person/find');
    http.Response response = await http.get(url);
    List data = jsonDecode(utf8.decode(response.bodyBytes));
    log(data.toString());
    data = data.where((element) => element["birthdate"] != null).toList();
    log(data.toString());
    List<Person> persons = [];
    for (final person in data) {
      persons.add(Person.fromMap(person));
      personsMap[person["id"]] = Person.fromMap(person);
    }
    ApiData.persons = persons;
  }

  static Future<void> loadPerson(int id) async {
    Uri url = Uri.https('sig.cetic.be', '/trajectware-0.6/v0/person/$id');
    http.Response response = await http.get(url);
    Map<String, dynamic> data = jsonDecode(response.body);
    personsMap[id] = Person.fromMap(data);
  }
}