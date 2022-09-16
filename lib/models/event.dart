class Event {
  String date;
  String title;
  String description;
  String societe;
  String localisation;
  String type;
  String fullDate;

  Event.fromMap(Map<String, dynamic> map)
      :
        date = map['date'],
        title = map['titre'],
        description = map['description'],
        societe = map['société'],
        localisation = map['localisation'],
        type = map['type'],
        fullDate = map['full_date'];


  String getTitle() {
    if (title != '') {
      return title;
    } else {
      if (societe != "") {
        return societe;
      } else {
        return "Sans titre";
      }
    }
  }
}