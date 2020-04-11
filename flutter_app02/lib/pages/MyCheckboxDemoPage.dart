import 'package:flutter/material.dart';

class MyCheckboxDemoPage extends StatefulWidget {
  MyCheckboxDemoPage({Key key}) : super(key: key);

  @override
  _MyCheckboxDemoPageState createState() => _MyCheckboxDemoPageState();
}

class _MyCheckboxDemoPageState extends State<MyCheckboxDemoPage> {
  int _sex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('复选，单选')),
        body: Row(
          children: <Widget>[
            Flexible(
              child: ListView(
                children: <Widget>[
                  RadioListTile(
                      value: 1,
                      groupValue: this._sex,
                      onChanged: (val) {
                        this._sex = val;
                      }),
                  RadioListTile(
                      value: 1,
                      groupValue: this._sex,
                      onChanged: (val) {
                        this._sex = val;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  CheckboxListTile(
                      value: true,
                      onChanged: (valu) {},
                      title: Text("标题一"),
                      subtitle: Text('标题儿'),
                      secondary: Icon(Icons.help))
                ],
              ),
            )
          ],
        ));
  }
}
