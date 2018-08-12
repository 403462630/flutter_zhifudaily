import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ProgressWidgetType {
  LOADING,
  CONTENT,
  EMPTY,
  ERROR
}

typedef void ProgressErrorClick();

class ProgressWidget extends StatelessWidget {

  final Widget loadingWidget;
  final Widget contentWidget;
  final Widget emptyWidget;
  final Widget errorWidget;

  final ProgressWidgetType type;

  final String emptyHint;
  final String errorHint;
  final String loadingHint;
  final TextStyle hintStyle;

  final ProgressErrorClick errorClick;

  ProgressWidget({
    Key key,
    this.loadingWidget,
    @required this.contentWidget,
    this.emptyWidget,
    this.errorWidget,
    this.type,
    this.emptyHint = "暂无数据",
    this.errorHint = "加载出错",
    this.loadingHint = "正在加载...",
    this.hintStyle = const TextStyle(
      fontSize: 13.0,
      color: Color(0xffcccccc),
    ),
    this.errorClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(type) {
      case ProgressWidgetType.LOADING:
        return loadingWidget != null ? loadingWidget : _createDefaultLoadingWidget();
      case ProgressWidgetType.EMPTY:
        return emptyWidget != null ? emptyWidget : _createDefaultEmptyWidget();
      case ProgressWidgetType.ERROR:
        return errorWidget != null ? errorWidget : _createDefaultErrorWidget();
      default:
        return contentWidget;
    }
  }

  Widget _createDefaultLoadingWidget() {
    return new SizedBox.expand(
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CupertinoActivityIndicator(),
          Padding(padding: EdgeInsets.only(left: 10.0)),
          new Text(loadingHint, style: hintStyle)
        ],
      )
    );
  }

  Widget _createDefaultEmptyWidget() {
    return new SizedBox.expand(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(emptyHint, style: hintStyle)
          ],
        )
    );
  }

  Widget _createDefaultErrorWidget() {
    return new SizedBox.expand(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              onTap: errorClick,
              child: new Text(errorHint, style: hintStyle),
            ),
          ],
        )
    );
  }
}
