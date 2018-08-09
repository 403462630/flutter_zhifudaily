import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';
import 'package:flutter_zhifudaily/data/drawer_item.dart';

class HomeDrawer extends StatefulWidget {
  final List<DrawerItem> data;
  final int selectedIndex;
  final ItemClick drawerItemClick;
  final ItemCollectClick itemCollectClick;

  @override
  State<StatefulWidget> createState() {
    print("====HomeDrawer createState====");
    return new _HomeDrawerState();
  }

  HomeDrawer({
    Key key,
    this.data,
    this.selectedIndex = 0,
    this.drawerItemClick,
    this.itemCollectClick,
  }) : super(key: key);
}

class _HomeDrawerState extends State<HomeDrawer> with AutomaticKeepAliveClientMixin {
  HomeDrawerAdapter homeDrawerAdapter;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    this._selectedIndex = widget.selectedIndex;
    homeDrawerAdapter = new HomeDrawerAdapter(
      data: widget.data,
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
      selectedIndex: _selectedIndex,
    );
  }

  _updateItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      print("selectedIndex: $_selectedIndex");
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
