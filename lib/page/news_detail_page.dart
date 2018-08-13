import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_zhifudaily/data/news.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/widget/progress_widget.dart';

class NewsDetailPage extends StatefulWidget {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  final int id;

  NewsDetailPage({
    Key key,
    @required this.id
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _NewsDetailPage();
  }
}

class _NewsDetailPage extends State<NewsDetailPage> {
  NewsDetail _newsDetail;
  ProgressWidgetType type;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    type = ProgressWidgetType.LOADING;
    loadDetail();
  }

  void loadDetail() async {
    Result<NewsDetail> result = await ZhiFuNewsApi().getNewsDetail(widget.id);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        if (result.isSuccess()) {
          _newsDetail = result.data;
          type = ProgressWidgetType.CONTENT;
          widget.flutterWebViewPlugin.reloadUrl(_newsDetail.shareUrl);
        } else {
          type = ProgressWidgetType.ERROR;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ProgressWidget(
      type: type,
      errorClick: () {
        type = ProgressWidgetType.LOADING;
        setState(() {});
        loadDetail();
      },
      contentWidget: new WebviewScaffold(
        url: _newsDetail == null ? "" : _newsDetail.shareUrl,
        appBar: new AppBar(
          title: new Text(_newsDetail == null ? "" : _newsDetail.title),
        ),
        withJavascript: true,
      ),
      loadingWidget: new Scaffold(
        appBar: new AppBar(
          title: new Text(""),
        ),
        body: new SizedBox.expand(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CupertinoActivityIndicator(),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                new Text("正在加载...", style: TextStyle(
                  fontSize: 13.0,
                  color: Color(0xffcccccc),
                ))
              ],
            )
        ),
      ),
    );
  }
}
