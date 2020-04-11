import 'package:flutter/material.dart';
import '../tabs/Tabs.dart';

class LoginPageThridPage extends StatefulWidget {
  LoginPageThridPage({Key key}) : super(key: key);

  @override
  _LoginPageThridPageState createState() => _LoginPageThridPageState();
}

class _LoginPageThridPageState extends State<LoginPageThridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('输入手机验证码')),
        body: Container(
          child: Column(
            children: <Widget>[
              Text('输入手机验证码'),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('完成'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Tabs(index: 0)),
                      (route) => route == null);
                },
              )
            ],
          ),
        ));
  }
}
