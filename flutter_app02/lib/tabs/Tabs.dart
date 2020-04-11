import 'package:flutter/material.dart';
import '../pages/HomePage.dart';
import '../pages/CategoryPage.dart';
import '../pages/SettingPage.dart';

//定义底部导航栏
class Tabs extends StatefulWidget {
  final int index;

  Tabs({this.index = 0});

  @override
  _TabsState createState() => _TabsState(index: this.index);
}

class _TabsState extends State<Tabs> {
  int index;
  int _currentIndex = 0;

  _TabsState({this.index = 0}) {
    this._currentIndex = index;
  }

  final List<Widget> _pagesList = [
    HomePage(),
    CategoryPage(),
    SettingPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('导航栏')),
      body: this._pagesList[this._currentIndex],
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: DrawerHeader(
                    child: Text('侧边栏'),
                    decoration: BoxDecoration(
                        border: Border.all(width: 5.0, color: Colors.red))))
          ]),
          ListTile(
              title: Text('菜单1'),
              leading: CircleAvatar(child: Icon(Icons.home))),
          Divider(
            color: Colors.blue,
          ),
          ListTile(
              title: Text('菜单2'),
              leading: CircleAvatar(child: Icon(Icons.people))),
          Divider(
            color: Colors.blue,
          ),
          ListTile(
              title: Text('菜单2'),
              leading: CircleAvatar(child: Icon(Icons.settings))),
          Divider(
            color: Colors.blue,
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          // selectedItemColor: Colors.blue,
          fixedColor: Colors.red,
          // unselectedItemColor: Colors.white,
          // selectedFontSize: 10.0,
          // unselectedFontSize: 10.0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 40.0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text('分类')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('设置')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('设置')),
          ]),
    );
  }
}
