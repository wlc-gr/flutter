import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final String title;

  FormPage({Key key, this.title = '表单'}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState(title: this.title);
}

class _FormPageState extends State<FormPage> {
  String title;

  _FormPageState({this.title = '表单'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.backup),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(title: Text('我是一个表单')),
            SizedBox(
              height: 10.0,
            ),
            ListTile(title: Text('我是一个表单')),
            SizedBox(
              height: 10.0,
            ),
            ListTile(title: Text('我是一个表单')),
            SizedBox(
              height: 10.0,
            ),
            ListTile(title: Text('我是一个表单')),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        appBar: AppBar(
          title: Text(this.title),
        ));
  }
}
