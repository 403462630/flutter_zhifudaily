import 'package:flutter/material.dart';

abstract class BaseAdapter<T> {
  List<T> data;

  BaseAdapter({this.data});

  int getItemCount() {
    return data == null ? 0 : data.length;
  }

  int getItemType(int position) {
    return 0;
  }

  Widget getWidget(BuildContext context, int position) {
    return onCreateWidget(context, getItemType(position));
  }

  Widget onCreateWidget(BuildContext context, int type);
}