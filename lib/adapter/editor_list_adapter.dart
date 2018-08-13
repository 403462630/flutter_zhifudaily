import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/base_adapter.dart';
import 'package:flutter_zhifudaily/data/editor.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';
import 'package:flutter_zhifudaily/utils/RouteUtil.dart';

class EditorListAdapter extends BaseAdapter<Editor> {

  EditorListAdapter({
    List<Editor> data
  }) : super(data: data);

  @override
  Widget onCreateWidget(BuildContext context, int type, int position) {
    Editor editor = getItem(position);
    print("editor: $editor");
    return new GestureDetector(
      onTap: () {
        print("onTap: ${editor.url}");
        gotoWebViewPage(context, editor.url, editor.name);
      },
      child: new Container(
        height: 60.0,
        padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              width: 45.0,
              height: 45.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: editor.avatar == null || editor.avatar.isEmpty ? Image.asset("images/ic_default_avatar.png") : NetworkImage(editor.avatar)
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10.0)),
            new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(editor.name == null ? "" : editor.name, style: new TextStyle(
                  color: app_black,
                  fontSize: text_size_medium,
                )),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                new Text(editor.bio == null ? "" : editor.bio, style: new TextStyle(
                  color: app_gray,
                  fontSize: text_size_small,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}