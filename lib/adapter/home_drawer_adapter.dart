import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/state_base_adapter.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/utils/RouteUtil.dart';

typedef void ItemClick(NewsTheme data, int position);
typedef void ItemCollectClick(NewsTheme data, int position);

class HomeDrawerAdapter extends StateBaseAdapter<NewsTheme> {
  static const int TYPE_HOME_TITLE = 1;
  static const int TYPE_HOME_ITEM = 2;
  static const int TYPE_HOME_OTHER_ITEM = 3;
  int selectedIndex = 0;
  ItemClick itemClick;
  ItemCollectClick collectClick;

  HomeDrawerAdapter({
    List<NewsTheme> data,
    this.itemClick,
    this.collectClick,
    this.selectedIndex = 0,
  }) : super(data: data);

  @override
  int getDataCount() {
    return super.getDataCount() + 1;
  }

  @protected
  @override
  int getStateItemType(int position) {
    return position == 0 ? TYPE_HOME_TITLE : (position == 1 ? TYPE_HOME_ITEM : TYPE_HOME_OTHER_ITEM);
  }

  @protected
  @override
  Widget onStateCreateWidget(BuildContext context, int type, int position) {
    if (type == TYPE_HOME_TITLE) {
      return onCreateTitleWidget(context, position);
    } else if (type == TYPE_HOME_ITEM) {
      return onCreateHomeItemWidget(context, position);
    } else {
      return onCreateItemWidget(context, position);
    }
  }

  @protected
  Widget onCreateTitleWidget(BuildContext context, int position) {
    return new Container(
      color: bg_home_drawer_top,
      height: 134.0,
      padding: EdgeInsets.only(top: 34.0, left: 15.0, right: 15.0, bottom: 15.0),
      child: new Column(
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              gotoLogin(context);
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("images/ic_default_avatar.png", height: 40.0,),
                new Padding(padding: EdgeInsets.only(left: 10.0)),
                new Text("请登录", style: new TextStyle(
                  fontSize: text_size_medium,
                  color: Colors.white,
                ))
              ],
            ),
          ),
          new Expanded(child: Padding(padding: EdgeInsets.only(top: 0.0))),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new GestureDetector(
                  onTap: () {},
                  child: new Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Icon(Icons.star, color: Colors.white, size: 19.0),
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      new Text("我的收藏", style: new TextStyle(
                        color: Colors.white,
                        fontSize: text_size_small,
                        fontWeight: FontWeight.bold,
                      ))
                    ],
                  ),
                ),
              ),
              new Expanded(
                child: new GestureDetector(
                  onTap: () {},
                  child: new Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10.0)),
                      Icon(Icons.file_download, color: Colors.white, size: 19.0),
                      Padding(padding: EdgeInsets.only(left: 20.0)),
                      new Text("离线下载", style: new TextStyle(
                        color: Colors.white,
                        fontSize: text_size_small,
                        fontWeight: FontWeight.bold,
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget onCreateHomeItemWidget(BuildContext context, int position) {
    int dataPosition = position - 1;
    bool isSelected = selectedIndex == dataPosition;
    return new GestureDetector(
      onTap: () {
        if (itemClick != null) {
          itemClick(getItem(dataPosition), dataPosition);
        }
      },
      child: new Container(
        color: isSelected ? bg_home_drawer_item_selected : bg_home_drawer_item_normal,
        height: 45.0,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: new Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Icon(Icons.home, color: app_blue),
            Padding(padding: EdgeInsets.only(left: 15.0)),
            new Text(
              "首页",
              style: Style.buildDrawerHomeItemTextStyle(),
            )
          ],
        ),
      ),
    );
  }

  @protected
  Widget onCreateItemWidget(BuildContext context, int position) {
    int dataPosition = position - 1;
    NewsTheme drawerItem = getItem(dataPosition);
    bool isSelected = selectedIndex == dataPosition;
    bool isCollect = getItem(dataPosition).isCollect;
    return new GestureDetector(
      onTap: () {
        if (itemClick != null) {
          itemClick(drawerItem, dataPosition);
        }
      },
      child: new Container(
        color: isSelected ? bg_home_drawer_item_selected : bg_home_drawer_item_normal,
        height: 45.0,
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              "${drawerItem.name}",
              style: Style.buildDrawerItemTextStyle(),
            ),
            new IconButton(
              icon: Icon(isCollect ? Icons.chevron_right : Icons.add, color: Color(0xffc9c9c9), size: 15.0),
              onPressed: () {
                if (collectClick != null) {
                  collectClick(drawerItem, dataPosition);
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}