import 'package:flutter/material.dart';

class MyTextFieldPage extends StatefulWidget {
  MyTextFieldPage({Key key}) : super(key: key);

  @override
  _MyTextFieldPageState createState() => _MyTextFieldPageState();
}

class _MyTextFieldPageState extends State<MyTextFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              child: TextField(),
              padding: EdgeInsets.all(10),
            ),
            Padding(
              child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '请输入用户名',
                      icon: Icon(Icons.people))),
              padding: EdgeInsets.all(10),
            ),
            Padding(
              child: TextField(
                decoration: InputDecoration(
                    hintText: '多行文本',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.pink))),
                maxLines: 4,
              ),
              padding: EdgeInsets.all(10),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  print(val);
                },
                obscureText: true,
                decoration: InputDecoration(labelText: '密码'),
              ),
            )
          ],
        ),
        appBar: AppBar(
          title: Text('表单演示页面'),
        ));
  }
}
