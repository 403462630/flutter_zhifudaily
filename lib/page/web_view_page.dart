import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
