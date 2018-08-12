import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_list_adapter.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/style/color.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeFragmentState();
  }
}

class _HomeFragmentState extends State<HomeFragment> {
  HomeListAdapter homeListAdapter;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    homeListAdapter = new HomeListAdapter(
      bannerData: [1, 2, 3, 4, 5],
      data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
      currentIndex: 0,
    );
    scrollController = new ScrollController();
    scrollController.addListener(() {
      ScrollPositionWithSingleContext position = scrollController.position;
      if (position.pixels > position.maxScrollExtent && !homeListAdapter.isLoading()) {
        homeListAdapter.notifyLoading();
        setState(() {});
        Timer(Duration(seconds: 5), () {
          setState(() {
            homeListAdapter.notifyNormal();
            homeListAdapter.data.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
          });
        });
      }
    });
  }

  void loadData() async {
//    ZhiFuNewsApi().
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: bg_window,
      child: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return homeListAdapter.getWidget(context, index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: homeListAdapter.getItemCount(),
        controller: scrollController,
      ),
    );
  }
}