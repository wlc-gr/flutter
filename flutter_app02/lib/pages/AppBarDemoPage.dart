import 'package:flutter/material.dart';

//定义头部导航栏
class AppBarDemoPage extends StatefulWidget {
  AppBarDemoPage({Key key}) : super(key: key);

  @override
  _AppBarDemoPageState createState() => _AppBarDemoPageState();
}

class _AppBarDemoPageState extends State<AppBarDemoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.backup),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        appBar: AppBar(
          title: Text('AppBarDemoPage_s'),
          leading: IconButton(
            tooltip: '提示信息ss',
            icon: Icon(Icons.settings),
            hoverColor: Colors.red,
            onPressed: () {
              print('click');
            },
          ),
          bottom: TabBar(
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: '推荐'),
              Tab(text: '热门'),
              Tab(text: '推荐1'),
              Tab(text: '热门1'),
              Tab(text: '推荐2'),
              Tab(text: '热门2')
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
              ListTile(title: Text('推荐页面')),
            ],
          ),
          ListView(
            children: <Widget>[
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
              ListTile(title: Text('热门页面')),
            ],
          )
        ]),
      ),
    );
  }
}
