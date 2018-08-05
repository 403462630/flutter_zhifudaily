import 'dart:async';

import 'package:flutter/material.dart';

typedef Widget CreatePage(BuildContext context, int index);

class FcPageView<T> extends StatefulWidget {
  final PageController pageController;
  final List<T> data;
  final int currentIndex;
  final CreatePage itemPage;
  final ValueChanged<int> onPageChanged;
  final bool isLoop;
  final int timerSeconds;

  FcPageView({
    Key key,
    this.data,
    int currentIndex,
    @required this.itemPage,
    this.onPageChanged,
    this.isLoop: false,
    this.timerSeconds,
    PageController pageController,
  }) : pageController = pageController == null ? new PageController(initialPage: isLoop ? (currentIndex + 1) : currentIndex) : pageController,
        currentIndex = isLoop ? currentIndex + 1 : currentIndex,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _FcPageViewState();
  }
}

class _FcPageViewState extends State<FcPageView> {
  bool _flag = false; // 防止频繁调用jumpToPage方法，导致Stack Overflow error
  Timer _timer;
  int _timerSeconds;
  int _getItemCount() {
    return widget.data == null || widget.data.length == 0 ? 0 : (widget.data.length + (widget.isLoop ? 2 : 0));
  }

  @override
  void initState() {
    super.initState();
    this._timerSeconds = widget.timerSeconds;
    _initTimer();
  }

  @override
  void didUpdateWidget(FcPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_timerSeconds != widget.timerSeconds) {
      _timerSeconds = widget.timerSeconds;
      _initTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    int size = _getItemCount();
    return new NotificationListener(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification) {
          _checkLoopPage();
        }
      },
      child: new PageView.builder(
        onPageChanged: (int page) {},
        controller: widget.pageController,
        itemBuilder: (context, index) {
          return widget.itemPage(context, _getDataIndex(index));
        },
        itemCount: size,
      ),
    );
  }

  int _getDataIndex(int index) {
    if (widget.isLoop) {
      if (index == 0) {
        return _getItemCount() - 2 - 1;
      } else if (index == _getItemCount() - 1) {
        return 0;
      } else {
        return index - 1;
      }
    } else {
      return index;
    }
  }

  void _checkLoopPage() {
    int page = widget.pageController.page.round();
    if (widget.isLoop) {
      int index = 0;
      if (page == 0) {
        if (!_flag) {
          _flag = true;
          index = _getItemCount() - 2;
          widget.pageController.jumpToPage(index);
        }
      } else if (page == _getItemCount() - 1) {
        if (!_flag) {
          _flag = true;
          index = 1;
          widget.pageController.jumpToPage(1);
        }
      } else {
        _flag = false;
        index = page.toInt() - 1;
        if (widget.onPageChanged != null) {
          widget.onPageChanged(index);
        }
      }
    } else {
      if (widget.onPageChanged != null) {
        widget.onPageChanged(page);
      }
    }
  }
  
  void _initTimer() {
    _timer?.cancel();
    if (_timerSeconds != null && _timerSeconds > 0) {
//      print("_initTimer");
      _timer = new Timer.periodic(Duration(seconds: _timerSeconds), (timer) {
        if (widget.pageController.hasClients) {
          int page = widget.pageController.page.round();
          widget.pageController.animateToPage(page + 1, duration: Duration(milliseconds: 250), curve: Curves.linear);
        }
      });
    }
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
