import 'package:flutter/material.dart';

//使用TabControler
class TabContrllerPage extends StatefulWidget {
  TabContrllerPage({Key key}) : super(key: key);

  @override
  _TabContrllerPageState createState() => _TabContrllerPageState();
}

class _TabContrllerPageState extends State<TabContrllerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: <Widget>[
            Expanded(
              child: TabBar(
                tabs: <Widget>[
                  Tab(text: '推荐'),
                  Tab(text: '热门'),
                ],
              ),
            )
          ]),
          // backgroundColor: Colors.blue,
          // bottom: TabBar(
          //   tabs: <Widget>[
          //     Tab(text: '推荐'),
          //     Tab(text: '热门'),
          //   ],
          // )
        ),
        body: TabBarView(children: <Widget>[
          Row(
            children: <Widget>[
              Text('热门1'),
              Text('热门2'),
              Text('热门3'),
              Text('热门4'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('推荐1'),
              Text('推荐2'),
              Text('推荐3'),
              Text('推荐4'),
            ],
          )
        ]),
      ),
    );
  }
}
