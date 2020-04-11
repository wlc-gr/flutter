import 'package:flutter/material.dart';

//button按钮演示
class MyButtonPage extends StatefulWidget {
  MyButtonPage({Key key}) : super(key: key);

  @override
  _MyButtonPageState createState() => _MyButtonPageState();
}

class _MyButtonPageState extends State<MyButtonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(title: Text('演示按钮页面')),
        body: Container(
          decoration: BoxDecoration(color: Colors.yellow),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          elevation: 500.0,
                          splashColor: Colors.blue,
                          child: Text('凸起按钮'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.people),
                          label: Text('按钮图标'))
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        elevation: 500.0,
                        splashColor: Colors.blue,
                        child: Text('凸起按钮'),
                        onPressed: () {},
                      ),
                    )),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("圆角按按钮"),
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10))
                      shape: CircleBorder(side: BorderSide(color: Colors.pink)),
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  RaisedButton(
                    // shape: CircleBorder(side: BorderSide(color: Colors.pink)),
                    onPressed: () {},
                    child: Text('第三行'),
                  )
                ])
              ]),
        ));
  }
}
