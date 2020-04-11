import 'package:flutter/material.dart';
import '../consts/Consts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _falg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('用户基本信息填写')),
        body: Container(
          child: Column(
            children: <Widget>[
              Text('输入用户基本信息'),
              CheckboxListTile(
                value: true,
                onChanged: (val) {},
                title: Text('xxxx'),
                subtitle: Text('ssss'),
              ),
              SizedBox(
                height: 20,
              ),
              Radio(
                value: true,
                onChanged: (value) {
                  setState(() {
                    this._falg = value;
                  });
                },
                groupValue: _falg,
              ),
              Radio(
                value: false,
                onChanged: (value) {
                  setState(() {
                    this._falg = value;
                  });
                },
                groupValue: _falg,
              ),
              RaisedButton(
                child: Text('下一步'),
                onPressed: () {
                  //   Navigator.pushNamed(context, Consts.LOGIN_SECOND);
                  Navigator.pushReplacementNamed(context, Consts.LOGIN_SECOND);
                },
              )
            ],
          ),
        ));
  }
}
