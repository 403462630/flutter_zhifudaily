import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/editor_list_adapter.dart';
import 'package:flutter_zhifudaily/data/editor.dart';

class EditorListPage extends StatefulWidget {
  final List<Editor> data;

  const EditorListPage({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _EditorListPageState();
  }
}

class _EditorListPageState extends State<EditorListPage> {
  EditorListAdapter _adapter;

  @override
  void initState() {
    super.initState();
    _adapter = new EditorListAdapter(
      data: widget.data
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("主编"),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _adapter.getWidget(context, index);
        },
        itemCount: _adapter.getItemCount(),
      ),
    );
  }
}
