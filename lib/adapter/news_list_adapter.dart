import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/state_base_adapter.dart';
import 'package:flutter_zhifudaily/data/stories.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';
import 'package:flutter_zhifudaily/style/style.dart';

class NewsListAdapter extends StateBaseAdapter<Stories> {
  static const int TYPE_HOME_TOP = 1;
  static const int TYPE_HOME_EDITOR = 2;
  static const int TYPE_HOME_NEWS = 3;

  ThemeNews themeNews;

  NewsListAdapter({
    this.themeNews,
    ErrorStateClick errorClick,
  }) : super(data: themeNews != null ? themeNews.stories : null, errorClick: errorClick);

  @protected
  @override
  int getStateItemType(int position) {
    if (position == 0) {
      return TYPE_HOME_TOP;
    } else if (position == 1) {
      return TYPE_HOME_EDITOR;
    } else {
      return TYPE_HOME_NEWS;
    }
  }

  @override
  int getDataCount() {
    if (themeNews == null) {
      return 0;
    } else {
      return super.getDataCount() + 2;
    }
  }

  @protected
  @override
  Widget onStateCreateWidget(BuildContext context, int type, int position) {
    switch (type) {
      case TYPE_HOME_TOP:
        return onCreateTopWidget(context, position);
      case TYPE_HOME_EDITOR:
        return onCreateEditorWidget(context, position);
      default:
        return onCreateNewsWidget(context, position);
    }
  }

  @protected
  Widget onCreateTopWidget(BuildContext context, int position) {
    return new Container(
      height: 200.0,
      child: Stack(
        children: <Widget>[
          new SizedBox.expand(
            child: new Image.network(themeNews.image, fit: BoxFit.cover),
          ),
          new Positioned(
            left: 15.0,
            top: 150.0,
            child: new Text(themeNews.description, style: new TextStyle(
              color: Colors.white,
              fontSize: text_size_normal,
            )),
          ),
        ],
      ),
    );
  }

  @protected
  Widget onCreateEditorWidget(BuildContext context, int position) {
    return new Container(
      height: 50.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _createEditors(),
      ),
    );
  }

  List<Widget> _createEditors() {
    List<Widget> widgets = [];
    widgets.add(new Text("主编", style: new TextStyle(
      fontSize: text_size_small,
      color: app_gray,
    )));
    if (themeNews.editors != null) {
      for (var editor in themeNews.editors) {
        widgets.add(new Padding(padding: EdgeInsets.only(left: 10.0)));
        widgets.add(new Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(editor.avatar)
            ),
          ),
        ));
      }
    }
    return widgets;
  }

  @protected
  Widget onCreateNewsWidget(BuildContext context, int position) {
    int dataPosition = position - 2;
    Stories stories = getItem(dataPosition);
    String image = stories.images != null && stories.images.isNotEmpty ? stories.images[0] : null;
    return new Container(
      margin: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      constraints: new BoxConstraints(
        minHeight: 70.0,
      ),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new DefaultTextStyle(
              style: Style.buildItemTextStyle(),
              child: new Text(stories.title),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          image != null ? Image.network(image, width: 100.0, height: 70.0, fit: BoxFit.fitWidth) : Padding(padding: EdgeInsets.only(left: 0.0)),
        ],
      ),
    );
  }
}