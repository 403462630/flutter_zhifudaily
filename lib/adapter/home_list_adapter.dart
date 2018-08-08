import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/base_adapter.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/widget/home_banner.dart';

class HomeListAdapter<T> extends BaseAdapter<T> {
  static const int TYPE_HOME_BANNER = 1;
  static const int TYPE_HOME_TITLE = 2;
  static const int TYPE_HOME_CONTENT = 3;
  int currentIndex;
  List bannerData;

  HomeListAdapter({
    List<T> data,
    this.bannerData,
    this.currentIndex: 0,
  }) : super(data: data);

  @protected
  @override
  int getItemType(int position) {
    if (position == 0) {
      return TYPE_HOME_BANNER;
    } else {
      return TYPE_HOME_CONTENT;
    }
  }

  @override
  int getItemCount() {
    return super.getItemCount() + 1;
  }

  @protected
  @override
  Widget onCreateWidget(BuildContext context, int type, int position) {
    switch (type) {
      case TYPE_HOME_BANNER:
        return onCreateBannerWidget(context);
      case TYPE_HOME_CONTENT:
        return onCreateContentWidget(context);
      case TYPE_HOME_TITLE:
        return onCreateTitleWidget(context);
      default:
        return null;
    }
  }

  @protected
  Widget onCreateBannerWidget(BuildContext context) {
    return new Container(
      height: 200.0,
      margin: EdgeInsets.only(bottom: 8.0),
      child: new HomeBanner(
        data: bannerData,
        currentIndex: currentIndex,
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
  Widget onCreateContentWidget(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
      padding: EdgeInsets.all(8.0),
      color: Colors.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new DefaultTextStyle(
              style: Style.buildItemTextStyle(),
              child: new Text("如何整理冰如何整理冰箱如何整理冰箱如何整理冰箱如何整理冰箱如何整理冰箱如何整理冰箱箱如何整理冰箱"),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Image.asset("images/lake.jpeg", width: 100.0, height: 80.0, fit: BoxFit.contain,),
        ],
      ),
    );
  }
}