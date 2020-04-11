import 'package:flutter/material.dart';

class OtherButtonPage extends StatefulWidget {
  OtherButtonPage({Key key}) : super(key: key);

  @override
  _OtherButtonPageState createState() => _OtherButtonPageState();
}

class _OtherButtonPageState extends State<OtherButtonPage> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('其他按钮')),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                  icon: Icon(Icons.home),
                  iconSize: 50.0,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  style: TextStyle(color: Colors.yellow),
                  items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      this.dropdownValue = value;
                    });
                  }),
              SizedBox(
                height: 20,
              ),
              PopupMenuButton<String>(
                initialValue: '语文',
                icon: Icon(Icons.settings),
                onSelected: (val) {
                  print('$val');
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
                itemBuilder: (context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: '语文',
                      child: Text('语文'),
                    ),
                    PopupMenuItem<String>(
                      value: '数学',
                      child: Text('数学'),
                    ),
                    PopupMenuItem<String>(
                      value: '英语',
                      child: Text('英语'),
                    ),
                    PopupMenuItem<String>(
                      value: '生物',
                      child: Text('生物'),
                    ),
                    PopupMenuItem<String>(
                      value: '化学',
                      child: Text('化学'),
                    ),
                  ];
                },
              ),
              SizedBox(
                height: 10,
              ),
              BackButton(
                color: Colors.yellow,
                onPressed: () {
                  print('backbutton');
                },
              ),
              SizedBox(
                height: 10,
              ),
              CloseButton()
            ],
          ),
        ));
  }
}
