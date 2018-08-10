import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';
import 'package:flutter_zhifudaily/data/theme.dart';

typedef void OnOpenDrawer();

class HomeDrawer extends StatefulWidget {
  final List<NewsTheme> data;
  final int selectedIndex;
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
    this.data,
    this.selectedIndex = 0,
    this.drawerItemClick,
    this.itemCollectClick,
    this.onOpenDrawer,
  }) : super(key: key);
}

class HomeDrawerState extends State<HomeDrawer> with AutomaticKeepAliveClientMixin {
  HomeDrawerAdapter homeDrawerAdapter;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    this._selectedIndex = widget.selectedIndex;
    homeDrawerAdapter = new HomeDrawerAdapter(
      data: widget.data,
      selectedIndex: _selectedIndex,
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
    if (widget.onOpenDrawer != null) {
      widget.onOpenDrawer();
    }
  }

  updateData(List<NewsTheme> data) {
    setState(() {
      widget.data.clear();
      widget.data.addAll(data);
      homeDrawerAdapter.data = widget.data;
    });
  }

  _updateItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      homeDrawerAdapter.selectedIndex = _selectedIndex;
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

  @override
  bool get wantKeepAlive => true;
}
