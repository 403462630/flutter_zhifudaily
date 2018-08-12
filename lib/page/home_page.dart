import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/data/drawer_item.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/utils/ToastUtil.dart';
import 'package:flutter_zhifudaily/adapter/home_list_adapter.dart';
import 'package:flutter_zhifudaily/page/home_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeListAdapter homeListAdapter;
  int bannerIndex = 0;
  int drawerIndex = 0;
  GlobalKey<HomeDrawerState> homeDrawerKey = new GlobalKey();
  List<NewsTheme> drawerData; // 暂时只能放在homepage里，因为每次打开drawer都会重新创建HomeDrawerState，无法保持数据
  NewsTheme index;
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    homeListAdapter = new HomeListAdapter(
      bannerData: [1, 2, 3, 4, 5],
      data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
      currentIndex: 0,
    );
    index = new NewsTheme(name: "首页");
    drawerData = [index];
    scrollController = new ScrollController();
    scrollController.addListener(() {
//      print(scrollController.position);
      ScrollPositionWithSingleContext position = scrollController.position;
      if (position.pixels > position.maxScrollExtent && !homeListAdapter.isLoading()) {
        homeListAdapter.notifyLoading();
        setState(() {});
        Timer(Duration(seconds: 5), () {
          print("Timer");
          setState(() {
            homeListAdapter.notifyNormal();
            homeListAdapter.data.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
          });
        });
//        print("loading");
      }
    });
//    loadDrawerData();
  }

  void loadDrawerData() async {
    Result<ThemeResult> result = await ZhiFuNewsApi().getThemeList();
    print("loadDrawerData");
    if (result.isSuccess()) {
      if (homeDrawerKey.currentState == null) {
        setState(() {
          drawerData = [index]..addAll(result.data.others);
        });
      } else {
        drawerData = [index]..addAll(result.data.others);
        homeDrawerKey.currentState.updateData(drawerData);
      }
    }
//    Result<ThemeNews> themeNews = await ZhiFuNewsApi().getThemeNewsList(result.data.others[0].id);
  }

  void _onDrawerItemClick(int index) {
    setState(() {
      drawerIndex = index;
      Navigator.of(context).pop(); // close the drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      drawer: new MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: new HomeDrawer(
          key: homeDrawerKey,
          data: drawerData,
          selectedIndex: drawerIndex,
          drawerItemClick: (data, index) {
            _onDrawerItemClick(index);
          },
          onOpenDrawer: () {
            if (drawerData == null || drawerData.length <= 1) {
              loadDrawerData();
            }
          },
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("${drawerData[drawerIndex].name}", style: Style.buildTitleStyle()),
      actions: <Widget>[
        new IconButton( // action button
          icon: new Icon(Icons.swap_vertical_circle),
          onPressed: () {  },
        ),
        new PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              new PopupMenuItem(child: new Text("夜间模式")),
              new PopupMenuItem(child: new Text("设置选项")),
            ];
          },
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return new Container(
      color: bg_window,
      child: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return homeListAdapter.getWidget(context, index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: homeListAdapter.getItemCount(),
        controller: scrollController,
      ),
    );
  }
}
