import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';
import 'package:flutter_zhifudaily/data/drawer_item.dart';
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
  GlobalKey<ScaffoldState> homeDrawerKey = new GlobalKey();
  List<DrawerItem> drawerData;

  @override
  void initState() {
    super.initState();
    homeListAdapter = new HomeListAdapter(
      bannerData: [1, 2, 3, 4, 5],
      data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
      currentIndex: 0,
    );
    drawerData = [
      new DrawerItem("首页", true),
      new DrawerItem("日常心里学", false),
      new DrawerItem("用户推荐日报", false),
      new DrawerItem("电影日报", false),
      new DrawerItem("不许无聊", false),
      new DrawerItem("设计日报", false),
      new DrawerItem("大公司日报", false),
      new DrawerItem("财经日报", false),
      new DrawerItem("互联网安全", false),
      new DrawerItem("开始游戏", false),
      new DrawerItem("音乐日报", false),
      new DrawerItem("动漫日报", false),
      new DrawerItem("体育日报", false)];
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
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("${drawerData[drawerIndex].title}", style: Style.buildTitleStyle()),
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
      ),
    );
  }
}
