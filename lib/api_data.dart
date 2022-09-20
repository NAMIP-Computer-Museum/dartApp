import 'dart:convert';

import 'models/person.dart';

import 'package:http/http.dart' as http;

class ApiData {
  static List<Person> persons = [];
  static Map<int, Person> personsMap = {};

  static Future<void> loadAllPersons() async {
    Uri url = Uri.https('sig.cetic.be', '/trajectware-0.6/v0/person/find', {"name": "all"});
    http.Response response = await http.get(url);
    List data = jsonDecode(response.body);
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