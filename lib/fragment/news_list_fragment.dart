import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/news_list_adapter.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/data/stories.dart';
import 'package:flutter_zhifudaily/data/theme.dart';
import 'package:flutter_zhifudaily/style/color.dart';

class NewsListFragment extends StatefulWidget {
  final NewsTheme theme;

  NewsListFragment(this.theme);

  @override
  State<StatefulWidget> createState() {
    return new _NewsListFragmentState();
  }
}

class _NewsListFragmentState extends State<NewsListFragment> {

  NewsListAdapter _adapter;
  NewsTheme _theme;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _theme = widget.theme;
    _adapter = new NewsListAdapter(
      errorClick: () {
        _adapter.notifyLoading();
        setState(() {});
        loadMore();
      }
    );
    scrollController = new ScrollController();
    scrollController.addListener(() {
      ScrollPositionWithSingleContext position = scrollController.position;
      if (position.pixels > position.maxScrollExtent && !_adapter.isLoading()) {
        _adapter.notifyLoading();
        setState(() {});
        loadMore();
      }
    });
    loadData();
  }

  void loadData() async {
    Result<ThemeNews> result = await ZhiFuNewsApi().getThemeNewsList(_theme.id);
    if (result.isSuccess()) {
      setState(() {
        _adapter.notifyNormal();
        _adapter.themeNews = result.data;
        _adapter.data = _adapter.themeNews.stories;
      });
    }
  }

  void loadMore() async {
    if (_adapter.data != null && _adapter.data.isNotEmpty) {
      Result<List<Stories>> result = await ZhiFuNewsApi().getThemeNewsListMore(_theme.id, _adapter.data.last.id);
      setState(() {
        if (result.isSuccess()) {
          if (result.data == null || result.data.length == 0) {
            _adapter.notifyAll();
          } else {
            _adapter.notifyNormal();
            _adapter.themeNews.stories.addAll(result.data);
          }
        } else {
          print("loadMore error");
          _adapter.notifyError();
        }
      });
    }
  }

  @override
  void didUpdateWidget(NewsListFragment oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("NewsListFragment didUpdateWidget");
    if (_theme.id != widget.theme.id) {
      _theme = widget.theme;
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("NewsListFragment build size: ${_adapter.getItemCount()}");
    return new Container(
      color: bg_window,
      child: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _adapter.getWidget(context, index);
        },
        physics: BouncingScrollPhysics(),
        itemCount: _adapter.getItemCount(),
        controller: scrollController,
      ),
    );
  }
}