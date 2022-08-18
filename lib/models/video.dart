class VideoData {
  late String name;
  late String url;
  late String description;

  VideoData({required this.name, required this.url, required this.description});

  VideoData.fromMap(Map map) {
    name = map['title'];
    url = map['videoURL'];
    description = map['description'];
  }
}