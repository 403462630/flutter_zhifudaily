import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/style/dimen.dart';
import 'package:flutter_zhifudaily/utils/RouteUtil.dart';
import 'package:flutter_zhifudaily/widget/circle_indicator.dart';
import 'package:flutter_zhifudaily/widget/fc_page_view.dart';
import 'package:flutter_zhifudaily/data/stories.dart';

typedef void HomeBannerChanged(int index);

// 暂时只能用DataController保存和更新数据, 因为_HomeBannerState 总是被重新创建，无法保存数据
class _DataController<TopStories> {
  List<TopStories> data;
  int currentIndex;
  _DataController(this.data, this.currentIndex);
}

class HomeBanner extends StatefulWidget {
  final _DataController<TopStories> _dataController;
  final bool isLoop;
  final HomeBannerChanged onBannerChanged;
  HomeBanner({
    Key key,
    List<TopStories> data,
    int currentIndex,
    this.isLoop: true,
    this.onBannerChanged,
  }) : _dataController = new _DataController(data, currentIndex), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBanner> {
  void updateCurrentIndex(int index) {
    setState(() {
      if (widget.onBannerChanged != null) {
        widget.onBannerChanged(index);
      }
      widget._dataController.currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    print("homebanner initState currentIndex: $widget.dataController.currentIndex");
  }

  @override
  void didUpdateWidget(HomeBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("homebanner didUpdateWidget");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("homebanner didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    print("homebanner dispose");
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new FcPageView(
          itemPage: (BuildContext context, int index) {
            return new Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                new SizedBox.expand(
                  child: new GestureDetector(
                    onTap: () {
                      gotoNewsDetailPage(context, widget._dataController.data[index].id);
                    },
                    child: new Image.network(widget._dataController.data[index].image, fit: BoxFit.fill),
                  ),
                ),
                new Container(
                  height: 50.0,
                  child: new DefaultTextStyle(
                    child: new Text(widget._dataController.data[index].title),
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: text_size_normal,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                ),
              ],
            );
          },
          currentIndex: widget._dataController.currentIndex,
          data: widget._dataController.data,
          isLoop: widget.isLoop,
          timerSeconds: 5,
          onPageChanged: (index) {
//            print("onPageChanged--index: $index");
            updateCurrentIndex(index);
          },
        ),
        new CircleIndicator(
          size: widget._dataController.data != null ? widget._dataController.data.length : 0,
          currentIndex: widget._dataController.currentIndex,
          style: new CircleIndicatorStyle(
            margin: EdgeInsets.only(bottom: 5.0),
          ),
        ),
      ],
    );
  }
}