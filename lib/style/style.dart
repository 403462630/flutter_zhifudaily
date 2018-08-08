import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';

class Style {

  static TextStyle buildTitleStyle() {
    return new TextStyle(
      fontSize: text_size_app_bar,
      color: text_color_app_bar
    );
  }

  static TextStyle buildItemTextStyle() {
    return new TextStyle(
      fontSize: text_size_list_item_content,
      color: text_color_list_item_context,
    );
  }

  static TextStyle buildDrawerItemTextStyle() {
    return new TextStyle(
      fontSize: text_size_medium,
      color: text_color_list_item_context,
    );
  }

  static TextStyle buildDrawerHomeItemTextStyle() {
    return new TextStyle(
      fontSize: text_size_medium,
      color: app_blue,
    );
  }
}
