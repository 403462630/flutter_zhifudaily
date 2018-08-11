
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/base_adapter.dart';

abstract class StateBaseAdapter<T> extends BaseAdapter<T> {
  static const int _TYPE_NONE = -1000;
  static const int _TYPE_LOADING = -1001;
  static const int _TYPE_EMPTY = -1002;
  static const int _TYPE_ALL = -1003;
  static const int _TYPE_ERROR = -1004;

  int _currentState = _TYPE_NONE;
  String emptyHint;
  String errorHint;
  String allHint;
  String loadingHint;
  TextStyle hintStyle;
  StateBaseAdapter({
    List<T> data,
    this.emptyHint = "暂无数据",
    this.errorHint = "加载出错",
    this.allHint = "没有更多",
    this.loadingHint = "正在加载...",
    this.hintStyle = const TextStyle(
      fontSize: 13.0,
      color: Color(0xffcccccc),
    ),
  }) : super(data: data);

  bool isNormal() {
    return _currentState == _TYPE_NONE;
  }

  bool isLoading() {
    return _currentState == _TYPE_LOADING;
  }

  bool isEmpty() {
    return _currentState == _TYPE_EMPTY;
  }

  bool isAll() {
    return _currentState == _TYPE_ALL;
  }

  bool isError() {
    return _currentState == _TYPE_ERROR;
  }

  void notifyNormal() {
    _currentState = _TYPE_NONE;
  }

  void notifyLoading() {
    _currentState = _TYPE_LOADING;
  }

  void notifyEmpty() {
    _currentState = _TYPE_EMPTY;
  }

  void notifyAll() {
    _currentState = _TYPE_ALL;
  }

  void notifyError() {
    _currentState = _TYPE_ERROR;
  }


  @override
  int getItemCount() {
    return getDataCount() + 1;
  }

  @protected
  int getStatePosition() {
    return getItemCount() - 1;
  }

  @protected
  @override
  int getItemType(int position) {
    if (position == getStatePosition()) {
      return _currentState;
    } else {
      return getStateItemType(position);
    }
  }

  @protected
  int getStateItemType(int position) {
    return 0;
  }

  @protected
  @override
  Widget onCreateWidget(BuildContext context, int type, int position) {
    if (type == _TYPE_NONE) {
      return onCreateNoneWidget(context, position);
    } else if (type == _TYPE_LOADING) {
      return onCreateLoadingWidget(context, position);
    } else if (type == _TYPE_EMPTY) {
      return onCreateEmptyWidget(context, position);
    } else if (type == _TYPE_ERROR) {
      return onCreateErrorWidget(context, position);
    } else if (type == _TYPE_ALL) {
      return onCreateAllWidget(context, position);
    } else {
      return onStateCreateWidget(context, type, position);
    }
  }

  @protected
  Widget onCreateLoadingWidget(BuildContext context, int position) {
    return new Container(
      height: 40.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new CupertinoActivityIndicator(),
          Padding(padding: EdgeInsets.only(left: 10.0)),
          new Text(loadingHint, style: hintStyle)
        ],
      ),
    );
  }

  @protected
  Widget onCreateEmptyWidget(BuildContext context, int position) {
    return _createCurrentStateWidget(emptyHint);
  }

  @protected
  Widget onCreateErrorWidget(BuildContext context, int position) {
    return _createCurrentStateWidget(errorHint);
  }

  @protected
  Widget onCreateAllWidget(BuildContext context, int position) {
    return _createCurrentStateWidget(allHint);
  }

  Widget _createCurrentStateWidget(String text) {
    return new Container(
      height: 40.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new SizedBox(
            height: 0.5,
            width: 30.0,
            child: new Container(
              color: Color(0xffcccccc),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 12.0)),
          new Text(text, style: hintStyle),
          Padding(padding: EdgeInsets.only(left: 12.0)),
          new SizedBox(
            height: 0.5,
            width: 30.0,
            child: new Container(
              color: Color(0xffcccccc),
            ),
          ),
        ],
      ),
    );
  }

  @protected
  Widget onCreateNoneWidget(BuildContext context, int position) {
    return new Padding(padding: EdgeInsets.only(left: 0.0));
  }

  @protected
  Widget onStateCreateWidget(BuildContext context, int type, int position);
}