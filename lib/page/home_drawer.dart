import 'package:flutter/material.dart';
import 'package:flutter_zhifudaily/adapter/home_drawer_adapter.dart';

class HomeDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _HomeDrawerState();
  }

}

class _HomeDrawerState extends State<HomeDrawer> {
  HomeDrawerAdapter homeDrawerAdapter;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    homeDrawerAdapter = new HomeDrawerAdapter(
      data: [
        "日常心里学",
        "用户推荐日报",
        "电影日报",
        "不许无聊",
        "设计日报",
        "大公司日报",
        "财经日报",
        "互联网安全",
        "开始游戏",
        "音乐日报",
        "动漫日报",
        "体育日报"],
      itemClick: (data, index) {
        _updateItemSelected(index);
      }
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
