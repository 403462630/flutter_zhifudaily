import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/state_base_adapter.dart';
import 'package:flutter_zhifudaily/data/stories.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/widget/home_banner.dart';

class HomeListAdapter extends StateBaseAdapter<Stories> {
  static const int TYPE_HOME_BANNER = 1;
  static const int TYPE_HOME_TITLE = 2;
  static const int TYPE_HOME_CONTENT = 3;
  int currentIndex;
  HomeNews homeNews;

  HomeListAdapter({
    List<Stories> data,
    this.currentIndex: 0,
    this.homeNews,
    ErrorStateClick errorClick,
  }) : super(data: data, errorClick: errorClick);

  @protected
  @override
  int getStateItemType(int position) {
    if (position == 0) {
      return TYPE_HOME_BANNER;
    } else {
      return TYPE_HOME_CONTENT;
    }
  }

  @override
  int getDataCount() {
    return super.getDataCount() + 1;
  }

  @protected
  @override
  Widget onStateCreateWidget(BuildContext context, int type, int position) {
    switch (type) {
      case TYPE_HOME_BANNER:
        return onCreateBannerWidget(context);
      case TYPE_HOME_CONTENT:
        return onCreateContentWidget(context, position);
      case TYPE_HOME_TITLE:
        return onCreateTitleWidget(context);
      default:
        return null;
    }
  }

  @protected
  Widget onCreateBannerWidget(BuildContext context) {
    print("onCreateBannerWidget");
    return new Container(
      height: 240.0,
      margin: EdgeInsets.only(bottom: 8.0),
      child: new HomeBanner(
        data: homeNews.topStories,
        currentIndex: currentIndex,
        onBannerChanged: (index) {
          currentIndex = index;
        },
      ),
    );
  }

  @protected
  Widget onCreateTitleWidget(BuildContext context) {
    return new Container(
      height: 40.0,
      padding: EdgeInsets.all(8.0),
      child: new Text("今日要闻"),
    );
  }

  @protected
  Widget onCreateContentWidget(BuildContext context, int position) {
    int dataPosition = position - 1;
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