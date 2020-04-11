import 'dart:ffi';

import 'package:flutter/material.dart';
import '../consts/Consts.dart';

//定义首页页面
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400.0,
        height: 400.0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Consts.SEARRCH,
                    arguments: {'id': 123}); //命名路由
              },
              child: Text('跳转到搜索页面'),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Consts.FROM); //命名路由
              },
              child: Text('跳转到表单页面'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Consts.APP_BAR); //命名路由
              },
              child: Text('AppBarDemoPage_s'),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Consts.LOGIN_FIRST);
              },
              child: Text('用户注册'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('跳转到TabController'),
              onPressed: () {
                Navigator.pushNamed(context, Consts.TAB_CONTROLELR);
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('提示框'),
              onPressed: () {
                Navigator.pushNamed(context, '/mybutton');
              },
            )
          ],
        ));
  }
}
