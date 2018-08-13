import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  State<StatefulWidget> createState() {
    return new _NewsDetailPage();
  }
}

class _NewsDetailPage extends State<NewsDetailPage> {

  @override
  Widget build(BuildContext context) {
    widget.flutterWebViewPlugin.evalJavascript("document.body.innerHTML = 1");

    return new Container(
      child: new WebviewScaffold(
        url: "",
        appBar: new AppBar(
          title: new Text("Widget webview"),
        ),
        withJavascript: true,
      ),
    );
  }
}
