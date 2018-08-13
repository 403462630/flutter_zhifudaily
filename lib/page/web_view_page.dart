import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_zhifudaily/data/news.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/widget/progress_widget.dart';

class WebViewPage extends StatelessWidget {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  final String url;
  final String title;

  WebViewPage({
    Key key,
    @required this.url,
    this.title = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: new Text(title),
      ),
      withJavascript: true,
    );
  }
}
