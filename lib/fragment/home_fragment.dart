import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_list_adapter.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/data/news.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/style/color.dart';
import 'package:flutter_zhifudaily/utils/RouteUtil.dart';
import 'package:flutter_zhifudaily/widget/progress_widget.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeFragmentState();
  }
}

class _HomeFragmentState extends State<HomeFragment> {
  HomeListAdapter homeListAdapter;
  ScrollController scrollController;
  ProgressWidgetType progressWidgetType;
  GlobalKey<RefreshIndicatorState> refreshKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    progressWidgetType = ProgressWidgetType.LOADING;
    homeListAdapter = new HomeListAdapter(
      currentIndex: 0,
      errorClick: () {
        homeListAdapter.notifyLoading();
        setState(() {});
        loadMore();
      },
      itemClick: (context, data) {
        gotoNewsDetailPage(context, data.id);
      }
    );
    scrollController = new ScrollController();
    scrollController.addListener(() {
      ScrollPositionWithSingleContext position = scrollController.position;
      if (position.pixels > position.maxScrollExtent && !homeListAdapter.isLoading()) {
        homeListAdapter.notifyLoading();
        setState(() {});
        loadMore();
      }
    });
    loadData();
  }

  /// 因为onRefresh 需要返回Future
  Future<Null> loadData() async {
    Result<HomeNews> result = await ZhiFuNewsApi().getHomeNewsList();
    setState(() {
      if (result.isSuccess()) {
        progressWidgetType = ProgressWidgetType.CONTENT;
        result.data.stories[0].date = result.data.date;
        homeListAdapter.data = result.data.stories;
        homeListAdapter.homeNews = result.data;
        homeListAdapter.notifyNormal();
      } else {
        progressWidgetType = ProgressWidgetType.ERROR;
      }
    });
    return null;
  }

  void loadMore() async {
    if (homeListAdapter.homeNews != null && homeListAdapter.homeNews.date != null) {
      Result<HomeNews> result = await ZhiFuNewsApi().getHomeNewsListMore(homeListAdapter.homeNews.date);
      setState(() {
        if (result.isSuccess()) {
          result.data.stories[0].date = result.data.date;
          homeListAdapter.homeNews.stories.addAll(result.data.stories);
          homeListAdapter.homeNews.date = result.data.date;
          homeListAdapter.notifyNormal();
        } else {
          homeListAdapter.notifyError();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ProgressWidget(
      type: progressWidgetType,
      errorClick: () {
        progressWidgetType = ProgressWidgetType.LOADING;
        setState(() {});
        loadData();
      },
      contentWidget: new Container(
        color: bg_window,
        child: new RefreshIndicator(
          child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return homeListAdapter.getWidget(context, index);
            },
            physics: BouncingScrollPhysics(),
            itemCount: homeListAdapter.getItemCount(),
            controller: scrollController,
          ),
          onRefresh: loadData,
        ),
      ),
    );
  }
}