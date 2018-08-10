import 'package:flutter_zhifudaily/data/editor.dart';
import 'package:flutter_zhifudaily/data/stories.dart';

class ThemeResult {
  int limit;
  List subscribed;
  List<NewsTheme> others;

  ThemeResult({
    this.limit,
    this.subscribed,
    this.others,
  });
}

class NewsTheme {
  int id;
  String name;
  int color;
  String thumbnail;
  String description;
  bool isCollect = false;

  NewsTheme({
    this.id,
    this.name,
    this.color,
    this.thumbnail,
    this.description,
    this.isCollect = false,
  });

  NewsTheme.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        color = json["color"],
        thumbnail = json["thumbnail"],
        description = json["description"];
}

class ThemeNews {
  List<Stories> stories;
  List<Editor> editors;
  String name;
  int color;
  String image;
  String description;
  String background;

  ThemeNews({
    this.stories,
    this.editors,
    this.name,
    this.color,
    this.image,
    this.description,
    this.background
  });
}