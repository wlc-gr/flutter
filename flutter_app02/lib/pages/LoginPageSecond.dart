import 'package:flutter/material.dart';
import '../consts/Consts.dart';

class LoginPageSecond extends StatefulWidget {
  LoginPageSecond({Key key}) : super(key: key);

  @override
  _LoginPageSecondState createState() => _LoginPageSecondState();
}

class _LoginPageSecondState extends State<LoginPageSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('用户教育信息')),
        body: Container(
          child: Column(
            children: <Widget>[
              Text('输入用户教育信息'),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('下一步'),
                onPressed: () {
                  Navigator.pushNamed(context, Consts.LOGIN_THIRD);
                },
              )
            ],
          ),
        ));
  }
}
