import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//定义分类页面
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              indicatorColor: Colors.yellow,
              unselectedLabelColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              dragStartBehavior: DragStartBehavior.start,
              onTap: (indx) {
                print(indx);
              },
              tabs: <Widget>[
                Tab(text: '动画ss'),
                Tab(text: '电影'),
                Tab(text: '电视剧'),
              ],
            ),
            // bottom: TabBar(
            //   tabs: <Widget>[
            //     Tab(text: '动画ss'),
            //     Tab(text: '电影'),
            //     Tab(text: '电视剧'),
            //   ],
            // ),
          ),
          body: TabBarView(children: <Widget>[
            ListView(
              children: <Widget>[
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
              ],
            ),
            ListView(
              children: <Widget>[
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
                ListTile(title: Text("这是一个文本")),
              ],
            )
          ])),
    );
  }
}
