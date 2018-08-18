import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/fragment/home_fragment.dart';
import 'package:flutter_zhifudaily/fragment/news_list_fragment.dart';
import 'package:flutter_zhifudaily/fragment/home_drawer_fragment.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/utils/ToastUtil.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  NewsTheme _currentTheme;
  bool isDark = false;
  GlobalKey<HomeDrawerFragmentState> drawerKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  void _onDrawerItemClick(NewsTheme data) {
    setState(() {
      this._currentTheme = data;
      Navigator.of(context).pop(); // close the drawer
    });
  }

  _updateItemCollect(NewsTheme data) {
    setState(() {
      data.isCollect = !data.isCollect;
    });
  }

  bool _isIndex() {
    return _currentTheme == null;
  }

  String _getTitle() {
    return _currentTheme == null ? "首页" : _currentTheme.name;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      drawer: new MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: new HomeDrawerFragment(
          key: drawerKey,
          currentTheme: _currentTheme,
          drawerItemClick: (data, index) {
            _onDrawerItemClick(data);
          },
          itemCollectClick: (data, index) {
            _updateItemCollect(data);
          },
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    List<Widget> actions = [];
    if (_isIndex()) {
      actions.add(new IconButton( // action button
        icon: new Icon(Icons.notifications, color: Colors.white),
        onPressed: () {
          showToast("暂无实现");
        },
      ));
      actions.add(new PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return [
            new PopupMenuItem(child: new Text("夜间模式"), value: 1),
            new PopupMenuItem(child: new Text("设置选项"), value: 2),
          ];
        },
        onSelected: (value) {
          if (value == 1) {
            isDark = !isDark;
            setState(() {});
          } else {
            showToast("暂无实现");
          }
        },
      ));
    } else {
      actions.add(new IconButton( // action button
        icon: new Icon(_currentTheme.isCollect ? Icons.remove_circle_outline : Icons.add_circle_outline, color: Colors.white),
        onPressed: () {
          _updateItemCollect(_currentTheme);
        },
      ));
    }
    return new AppBar(
      title: new Text(_getTitle(), style: Style.buildTitleStyle()),
      actions: actions,
      backgroundColor: isDark ? app_black : app_blue,
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isIndex()) {
      return new HomeFragment();
    } else {
      return new NewsListFragment(_currentTheme);
    }
  }
}
