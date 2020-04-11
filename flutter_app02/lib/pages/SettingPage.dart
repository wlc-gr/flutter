import 'package:flutter/material.dart';
import '../consts/Consts.dart';

// 定义设置页面
class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('按钮'),
          onPressed: () {
            Navigator.pushNamed(context, Consts.APP_BAR);
          },
        ),
      ],
    );
  }
}
