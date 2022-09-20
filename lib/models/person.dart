class Person {
  String lastname;
  String firstname;
  String birthdate;
  String deathdate;
  String country;
  List<dynamic> photos;
  List<dynamic> tags;

  Person.fromMap(Map<String, dynamic> map) :
    lastname = map['lastname'],
    firstname = map['firstname'],
    birthdate = map['birthdate'],
    deathdate = map['deathdate'],
    country = map['country'],
    photos = map['photos'] ?? [],
    tags = map['tags'] ?? [];
}