
import 'package:flutter_zhifudaily/data/editor.dart';
import 'package:flutter_zhifudaily/data/stories.dart';

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

class HomeNews {
  String date;
  List<Stories> stories;
  List<TopStories> topStories;

  HomeNews({
    this.date,
    this.stories,
    this.topStories
  });
}

class NewsDetail {
  String body;
  String imageSource;
  String title;
  String image;
  String shareUrl;
  String gaPrefix;
  List<String> images;
  int type;
  int id;
  List<String> css;

  NewsDetail({
    this.body,
    this.imageSource,
    this.title,
    this.image,
    this.shareUrl,
    this.gaPrefix,
    this.images,
    this.type,
    this.id,
    this.css
  });

  NewsDetail.fromJson(Map<String, dynamic> json)
      : body = json["body"],
        imageSource = json["image_source"],
        title = json["title"],
        image = json["image"],
        shareUrl = json["share_url"],
        gaPrefix = json["ga_prefix"],
        images = json["images"] == null ? null : (json["images"] as List<dynamic>).map<String>((f) => f).toList(),
        type = json["type"],
        id = json["id"],
        css = json["css"] == null ? null : (json["css"] as List<dynamic>).map<String>((f) => f).toList();
}