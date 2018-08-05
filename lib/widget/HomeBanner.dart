import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/widget/CircleIndicator.dart';
import 'package:flutter_zhifudaily/widget/FcPageView.dart';

class HomeBanner<T> extends StatefulWidget {
  final List<T> data;
  final int currentIndex;
  final bool isLoop;
  HomeBanner({
    Key key,
    this.data,
    this.currentIndex,
    this.isLoop: true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomeBannerState();
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
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new FcPageView(
          itemPage: (BuildContext context, int index) {
//            print("itemPage--index: $index");
            return new Image.asset("images/lake.jpeg", fit: BoxFit.fill);
          },
          currentIndex: currentIndex,
          data: widget.data,
          isLoop: widget.isLoop,
          timerSeconds: 5,
          onPageChanged: (index) {
//            print("onPageChanged--index: $index");
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