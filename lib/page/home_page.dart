import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/fragment/home_fragment.dart';
import 'package:flutter_zhifudaily/fragment/news_list_fragment.dart';
import 'package:flutter_zhifudaily/page/home_drawer.dart';
import 'package:flutter_zhifudaily/style/style.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  GlobalKey<HomeDrawerState> homeDrawerKey = new GlobalKey();
  List<NewsTheme> drawerData; // 暂时只能放在homepage里，因为每次打开drawer都会重新创建HomeDrawerState，无法保持数据
  NewsTheme index;
  int drawerIndex = 0;

  @override
  void initState() {
    super.initState();
    index = new NewsTheme(name: "首页");
    drawerData = [index];
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
    if (drawerIndex == 0) {
      return new HomeFragment();
    } else {
      return new NewsListFragment(drawerData[drawerIndex]);
    }
  }
}
