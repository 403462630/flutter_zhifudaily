import 'package:flutter/material.dart';

abstract class BaseAdapter<T> {
  List<T> data;

  BaseAdapter({this.data});

  int getItemCount() {
    return getDataCount();
  }

  int getDataCount() {
    return data == null ? 0 : data.length;
  }

  T getItem(int position) {
    return data != null && data.length > position ? data[position] : null;
  }

  @protected
  int getItemType(int position) {
    return 0;
  }

  Widget getWidget(BuildContext context, int position) {
    return onCreateWidget(context, getItemType(position), position);
  }

  @protected
  Widget onCreateWidget(BuildContext context, int type, int position);
}