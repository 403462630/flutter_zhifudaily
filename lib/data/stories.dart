
class Stories {
  int type;
  int id;
  String title;
  List<String> images;
  String gaPrefix;

  Stories({
    this.type,
    this.id,
    this.title,
    this.images,
    this.gaPrefix
  });

  Stories.fromJson(Map<String, dynamic> json)
      : type = json["type"],
        id = json["id"],
        title = json["title"],
        images = json["images"] == null ? null : (json["images"] as List<dynamic>).map<String>((f) => f).toList(),
        gaPrefix = json["ga_prefix"];
}

class TopStories {
  int type;
  int id;
  String title;
  String image;
  String gaPrefix;

  TopStories({
    this.type,
    this.id,
    this.title,
    this.image,
    this.gaPrefix
  });

  TopStories.fromJson(Map<String, dynamic> json)
      : type = json["type"],
        id = json["id"],
        title = json["title"],
        image = json["image"],
        gaPrefix = json["ga_prefix"];
}