import 'package:flutter/material.dart';

typedef Widget CreatePage(BuildContext context, int index);

// ignore: must_be_immutable
class LoopPageView<T> extends StatelessWidget {
  final PageController _pageController;
  final List<T> data;
  final int currentIndex;
  final CreatePage itemPage;
  final ValueChanged<int> onPageChanged;
  final bool isLoop;
  bool _flag = false; // 防止频繁调用jumpToPage方法，导致Stack Overflow error

  LoopPageView({
    Key key,
    this.data,
    int currentIndex,
    @required this.itemPage,
    this.onPageChanged,
    this.isLoop: false,
  }) : _pageController = new PageController(initialPage: (isLoop ? currentIndex + 1 : currentIndex)),
        currentIndex = isLoop ? currentIndex + 1 : currentIndex,
        super(key: key);

  int _getItemCount() {
    return data == null || data.length == 0 ? 0 : (data.length + (isLoop ? 2 : 0));
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
        controller: _pageController,
        itemBuilder: (context, index) {
          return itemPage(context, _getDataIndex(index));
        },
        itemCount: size,
      ),
    );
  }

  int _getDataIndex(int index) {
    if (isLoop) {
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
    int page = _pageController.page.round();
    if (isLoop) {
      int index = 0;
      if (page == 0) {
        if (!_flag) {
          _flag = true;
          index = _getItemCount() - 2;
          _pageController.jumpToPage(index);
        }
      } else if (page == _getItemCount() - 1) {
        if (!_flag) {
          _flag = true;
          index = 1;
          _pageController.jumpToPage(1);
        }
      } else {
        _flag = false;
        index = page.toInt() - 1;
        if (onPageChanged != null) {
          onPageChanged(index);
        }
      }
    } else {
      if (onPageChanged != null) {
        onPageChanged(page);
      }
    }
  }
}

