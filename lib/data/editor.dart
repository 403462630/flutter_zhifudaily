
class Editor {
  int id;
  String avatar;
  String name;
  String url;
  String bio;

  Editor({
    this.id,
    this.avatar,
    this.name,
    this.url,
    this.bio
  });

  Editor.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        avatar = json["avatar"],
        name = json["name"],
        url = json["url"],
        bio = json["bio"];

}