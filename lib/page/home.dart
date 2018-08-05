import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/style/AppBarStyle.dart';
import 'package:flutter_zhifudaily/utils/ToastUtil.dart';
import 'package:flutter_zhifudaily/widget/HomeBanner.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("首页", style: AppBarStyle.buildTitleStyle(),),
    );
  }

  Widget buildBody(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          height: 200.0,
          child: new HomeBanner(
            data: [1, 2, 3, 4, 5, 6],
            currentIndex: currentIndex,
          ),
        ),
        new Expanded(
          child: new Column(
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.add), onPressed: () {
                setCurrentIndex(3);
              })
            ],
          ),
        ),
      ],
    );
  }
}
