import 'package:flutter/material.dart';

//定义搜索页面
class SearchPage extends StatelessWidget {
  final Map arguments;

  //const SearchPage({this.arguments}) ;
  const SearchPage({Key key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
            '这是搜索页面实现-------->${this.arguments != null ? this.arguments["id"] : '0'}'),
      ),
      appBar: AppBar(
        title: Text('搜索页面'),
      ),
    );
  }
}
