import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';
import 'package:flutter_zhifudaily/style/style.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPage();
  }

}

class _LoginPage extends State<LoginPage> {
  GlobalKey<ScaffoldState> _pageKey = new GlobalKey();

  void _showTipMessage(String message) {
    _pageKey.currentState.showSnackBar(new SnackBar(content: new Text(message)));
    // not working, i don't know why
//    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _pageKey,
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }
  
  Widget buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text("登录", style: Style.buildTitleStyle()),
    );
  }
  
  Widget buildBody(BuildContext context) {
    return new SizedBox.expand(
      child: new Container(
        color: Color(0xff0479d8),
        child: new Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 130.0)),
            new Text("知乎日报", style: new TextStyle(
              color: Colors.white,
              fontSize: text_size_big,
            )),
            Padding(padding: EdgeInsets.only(top: 80.0)),
            new Text("使用微博登录", style: new TextStyle(
              color: Color(0xffb6e5fa),
              fontSize: text_size_small,
            )),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            new SizedBox(
              width: 300.0,
              height: 45.0,
              child: new RaisedButton.icon(
                onPressed: () {
                  _showTipMessage("暂无登录接口，此登录界面只是纯ui展示，仅提供一些交互体验");
                },
                icon: Image.asset("images/ic_sina.png", height: 20.0),
                label: new Text("新浪微博"),
                color: Colors.white,
              )
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            new SizedBox(
                width: 300.0,
                height: 45.0,
                child: new RaisedButton.icon(
                  onPressed: () {
                    _showTipMessage("暂无登录接口，此登录界面只是纯ui展示，仅提供一些交互体验");
                  },
                  icon: Image.asset("images/ic_tencent.png", height: 20.0),
                  label: new Text("腾讯微博", ),
                  color: Colors.white,

                )
            ),
            new Expanded(
              child: new Align(
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("登录即代表你同意", style: new TextStyle(
                      color: Color(0xff41a5e8),
                      fontSize: text_size_small,
                    )),
                    new Text("《知乎协议》", style: new TextStyle(
                      color: Color(0xffd1e8f2),
                      fontSize: text_size_small,
                    ))
                  ],
                ),
                alignment: Alignment.bottomCenter,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
          ],
        ),
      ),
    );
  }
}
