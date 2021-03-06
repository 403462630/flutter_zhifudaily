import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/state_base_adapter.dart';
import 'package:flutter_zhifudaily/data/news.dart';
import 'package:flutter_zhifudaily/data/stories.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/widget/home_banner.dart';
import 'package:intl/intl.dart';

typedef void OnItemClick(BuildContext context, Stories data);

class HomeListAdapter extends StateBaseAdapter<Stories> {
  static const int TYPE_HOME_BANNER = 1;
  static const int TYPE_HOME_TITLE = 2;
  static const int TYPE_HOME_CONTENT = 3;
  int currentIndex;
  HomeNews homeNews;
  OnItemClick itemClick;

  HomeListAdapter({
    List<Stories> data,
    this.currentIndex: 0,
    this.homeNews,
    ErrorStateClick errorClick,
    this.itemClick,
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

  Widget _createTitleWidget(BuildContext context, String date) {
    return new Container(
      height: 40.0,
      padding: EdgeInsets.only(left: 15.0, top: 10.0),
      child: new Text(_formatDate(date), style: new TextStyle(
        color: app_gray,
        fontSize: text_size_small
      )),
    );
  }

  @protected
  Widget onCreateContentWidget(BuildContext context, int position) {
    int dataPosition = position - 1;
    Stories stories = getItem(dataPosition);
    String image = stories.images != null && stories.images.isNotEmpty ? stories.images[0] : null;
    String date = stories.date;
    List<Widget> widgets = [];
    if (date != null && date.isNotEmpty) {
      widgets.add(_createTitleWidget(context, date));
    }
    widgets.add(new GestureDetector(
      onTap: () {
        if (context != null) {
          itemClick(context, stories);
        }
      },
      child: new Container(
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
            image != null
                ? FadeInImage.assetNetwork(placeholder: "images/ic_image_placeholder.png", image: image, width: 100.0, height: 70.0, fit: BoxFit.fitWidth)
                : Padding(padding: EdgeInsets.only(left: 0.0)),
          ],
        ),
      ),
    ));
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets
    );
  }

  String _formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    Duration duration = dateTime.difference(DateTime.now());
    if (duration.inDays == 0) {
      return "今日要闻";
    } else {
      DateFormat dateFormat = new DateFormat("MM月dd日");
      return dateFormat.format(dateTime);
    }
  }
}