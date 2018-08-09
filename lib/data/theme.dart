import 'package:flutter_zhifudaily/data/editor.dart';
import 'package:flutter_zhifudaily/data/stories.dart';

class Theme {
  int id;
  String name;
  int color;
  String thumbnail;
  String description;

  Theme({
    this.id,
    this.name,
    this.color,
    this.thumbnail,
    this.description
  });

  Theme.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        color = json["color"],
        thumbnail = json["thumbnail"],
        description = json["description"];
}

class ThemeDetail {
  List<Stories> stories;
  List<Editor> editors;
  String name;
  int color;
  String image;
  String description;
  String background;

  ThemeDetail({
    this.stories,
    this.editors,
    this.name,
    this.color,
    this.image,
    this.description,
    this.background
  });
}