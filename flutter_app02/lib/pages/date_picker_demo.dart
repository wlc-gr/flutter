import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class DatePickerDemo extends StatefulWidget {
  DatePickerDemo({Key key}) : super(key: key);

  @override
  _DatePickerDemoState createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  var now = DateTime.now();

  @override
  initState() {
    super.initState();
    print(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('演示时间日期组件'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/inner_datepicker");
                      },
                      child: Text('演示flutter内置时间日期组件')),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "/flutter_cupertino_date_pickerPage");
                      },
                      child: Text('演示第三方时间日期组件')),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/myswiper");
                      },
                      child: Text('演示第三方轮播图组件'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
