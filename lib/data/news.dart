
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