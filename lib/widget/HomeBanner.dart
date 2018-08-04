import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/widget/CircleIndicator.dart';
import 'package:flutter_zhifudaily/widget/FcPageView.dart';

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

  void updateCurrentIndex(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new LoopPageView(
          itemPage: (BuildContext context, int index) {
            print("itemPage--index: $index");
            return new Image.asset("images/lake.jpeg", fit: BoxFit.fill);
          },
          currentIndex: 0,
          data: widget.data,
          isLoop: true,
          onPageChanged: (index) {
            print("onPageChanged--index: $index");
            updateCurrentIndex(index);
          },
        ),
        new CircleIndicator(
          size: widget.data.length,
          currentIndex: currentIndex,
          style: new CircleIndicatorStyle(
            margin: EdgeInsets.only(bottom: 5.0),
          ),
        ),
      ],
    );
  }
}