import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/widget/CircleIndicator.dart';
import 'package:flutter_zhifudaily/utils/ToastUtil.dart';

class HomeBanner<T> extends StatefulWidget {
  final PageController pageController = new PageController();
  final List<T> data;

  HomeBanner({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomeBannerState();
  }

  void setCurrentIndex(int index) {
    pageController.jumpToPage(index);
  }
}

class _HomeBannerState extends State<HomeBanner> {
  int currentIndex = 0;

  void _updateCurrentIndex(int index) {
    this.currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int size = widget.data.length;

    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new PageView.builder(

//          children: _newImagePages(context, size),
          onPageChanged: (int page) {
            showToast("page $page");
            _updateCurrentIndex(page);
          },
          controller: widget.pageController,
          itemBuilder: (context, index) {
            print("index: $index");
            return new Image.asset("images/lake.jpeg", fit: BoxFit.fill);
          },
          itemCount: 10,

//          childrenDelegate: new SliverChildBuilderDelegate(
//            (context, index) => new Image.asset("images/lake.jpeg", fit: BoxFit.fill),
//            childCount: 10,
//          ),
        ),
        new CircleIndicator(
          size: 10,
          currentIndex: currentIndex,
          style: new CircleIndicatorStyle(
            margin: EdgeInsets.only(bottom: 5.0),
          ),
        ),
      ],
    );
  }

  List<Widget> _newImagePages(BuildContext context, int size) {
    List<Widget> widgets = [];
    for (int i = 0; i < size; i++) {
      widgets.add(new Image.asset("images/lake.jpeg", fit: BoxFit.fill));
    }
    return widgets;
  }
}