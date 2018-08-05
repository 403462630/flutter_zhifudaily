import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/style/style.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/utils/ToastUtil.dart';
import 'package:flutter_zhifudaily/adapter/home_list_adapter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  HomeListAdapter homeListAdapter;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    homeListAdapter = new HomeListAdapter(
      bannerData: [1, 2, 3, 4, 5],
      data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
      currentIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
      drawer: buildDrawer(context),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return new Container(
      color: Colors.white,
      width: 300.0,
      child: new ListView(
        children: <Widget>[
          new ListTile(
            leading: new Icon(Icons.change_history),
            title: new Text('Change history'),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("首页", style: Style.buildTitleStyle()),
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
