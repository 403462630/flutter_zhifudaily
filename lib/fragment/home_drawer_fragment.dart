import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';
import 'package:flutter_zhifudaily/api/zhi_hu_news_api.dart';
import 'package:flutter_zhifudaily/data/result.dart';
import 'package:flutter_zhifudaily/data/theme.dart';

// 暂时只能用DataController保存和更新数据, 因为State 总是被重新创建，无法保存数据, 用AutomaticKeepAliveClientMixin 有bug
class _DataController {
  List<NewsTheme> data = [null]; // null 表示首页
  NewsTheme currentTheme;

  _DataController({
    this.currentTheme
  });

  bool hasData() {
    return data != null && data.length > 2;
  }

  void copyData(_DataController dataController) {
    data = dataController.data;
  }
}

class HomeDrawerFragment extends StatefulWidget {
  final _DataController _dataController;
  final ItemClick drawerItemClick;
  final ItemCollectClick itemCollectClick;

  @override
  State<StatefulWidget> createState() {
    print("====HomeDrawerFragment createState====");
    return new HomeDrawerFragmentState();
  }

  HomeDrawerFragment({
    Key key,
    NewsTheme currentTheme,
    this.drawerItemClick,
    this.itemCollectClick,
  }) : _dataController = new _DataController(currentTheme: currentTheme), super(key: key);
}

class HomeDrawerFragmentState extends State<HomeDrawerFragment> {
  HomeDrawerAdapter _adapter;

  @override
  void initState() {
    super.initState();
    print("initState");
    _initAdapter();
    if (!widget._dataController.hasData()) {
      _adapter.notifyLoading();
      _loadData();
    }
  }

  void _initAdapter() {
    _adapter = new HomeDrawerAdapter(
      data: widget._dataController.data,
      selectedIndex: _findNewsThemeIndex(),
      itemClick: (data, index) {
        _updateItemSelected(data);
        if (widget.drawerItemClick != null) {
          widget.drawerItemClick(data, index);
        }
      },
      collectClick: (data, index) {
        if (widget.itemCollectClick != null) {
          widget.itemCollectClick(data, index);
        }
      },
      errorClick: () {
        setState(() {
          _adapter.notifyLoading();
        });
        _loadData();
      },
    );
  }

  @override
  void didUpdateWidget(HomeDrawerFragment oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      widget._dataController.copyData(oldWidget._dataController);
    }
  }

  _loadData() async {
    Result<ThemeResult> result = await ZhiFuNewsApi().getThemeList();
    print("loadDrawerData");
    if (result.isSuccess()) {
      _updateData([null]..addAll(result.data.others));
    } else {
      setState(() {
        _adapter.notifyError();
      });
    }
  }

  _updateData(List<NewsTheme> data) {
    setState(() {
      widget._dataController.data.clear();
      widget._dataController.data.addAll(data);
      _adapter.notifyNormal();
      _adapter.data = widget._dataController.data;
    });
  }

  _updateItemSelected(NewsTheme data) {
    setState(() {
      widget._dataController.currentTheme = data;
      _adapter.selectedIndex = _findNewsThemeIndex();
    });
  }

  int _findNewsThemeIndex() {
    if (!widget._dataController.hasData() || widget._dataController.currentTheme == null) {
      return 0;
    } else {
      return widget._dataController.data.indexWhere((item) {
        return item == widget._dataController.currentTheme || (item != null && item.id == widget._dataController.currentTheme.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("====HomeDrawerFragment build====");
    return new Container(
      color: Colors.white,
      width: 300.0,
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return _adapter.getWidget(context, index);
        },
        itemCount: _adapter.getItemCount(),
      ),
    );
  }
}
