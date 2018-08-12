import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';
import 'package:flutter_zhifudaily/data/theme.dart';

typedef void OnOpenDrawer();

// 暂时只能用DataController保存和更新数据, 因为State 总是被重新创建，无法保存数据, 用AutomaticKeepAliveClientMixin 有bug
class _DataController {
  List<NewsTheme> data;
  int selectedIndex;

  _DataController(this.data, this.selectedIndex);

  bool hasData() {
    return data != null && data.length > 2;
  }
}

class HomeDrawer extends StatefulWidget {
  final _DataController _dataController;
  final ItemClick drawerItemClick;
  final ItemCollectClick itemCollectClick;
  final OnOpenDrawer onOpenDrawer;

  @override
  State<StatefulWidget> createState() {
    print("====HomeDrawer createState====");
    return new HomeDrawerState();
  }

  HomeDrawer({
    Key key,
    List<NewsTheme> data,
    int selectedIndex = 0,
    this.drawerItemClick,
    this.itemCollectClick,
    this.onOpenDrawer,
  }) : _dataController = new _DataController(data, selectedIndex), super(key: key);
}

class HomeDrawerState extends State<HomeDrawer> {
  HomeDrawerAdapter homeDrawerAdapter;

  @override
  void initState() {
    super.initState();
    homeDrawerAdapter = new HomeDrawerAdapter(
      data: widget._dataController.data,
      selectedIndex: widget._dataController.selectedIndex,
      itemClick: (data, index) {
        _updateItemSelected(index);
        if (widget.drawerItemClick != null) {
          widget.drawerItemClick(data, index);
        }
      },
      collectClick: (data, index) {
        if (widget.itemCollectClick != null) {
          widget.itemCollectClick(data, index);
        }
      },
    );
    if (!widget._dataController.hasData()) {
      homeDrawerAdapter.notifyLoading();
    }

    if (widget.onOpenDrawer != null) {
      widget.onOpenDrawer();
    }
  }

  updateData(List<NewsTheme> data) {
    setState(() {
      widget._dataController.data.clear();
      widget._dataController.data.addAll(data);
      homeDrawerAdapter.notifyNormal();
      homeDrawerAdapter.data = widget._dataController.data;
    });
  }

  _updateItemSelected(int index) {
    setState(() {
      widget._dataController.selectedIndex = index;
      homeDrawerAdapter.selectedIndex = widget._dataController.selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("====HomeDrawer build====");
    return new Container(
      color: Colors.white,
      width: 300.0,
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return homeDrawerAdapter.getWidget(context, index);
        },
        itemCount: homeDrawerAdapter.getItemCount(),
      ),
    );
  }
}
