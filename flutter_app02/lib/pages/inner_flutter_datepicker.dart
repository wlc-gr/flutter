import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class InnerDatePickerPage extends StatefulWidget {
  @override
  _InnerDatePickerPageState createState() => _InnerDatePickerPageState();
}

class _InnerDatePickerPageState extends State<InnerDatePickerPage> {
  var _now = DateTime.now();

  var _now_time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

  _showDatePicker() async {
    var result = await showDatePicker(
      context: context,
      initialDate: this._now,
      firstDate: DateTime(1998),
      lastDate: DateTime(2220),
//      locale: Locale('zh'),
    );
    print(result);
    setState(() {
      this._now = result;
    });
    return result;
  }

  _showTimePicker() async {
    var result = await showTimePicker(context: context, initialTime: _now_time);
    print(result);
    setState(() {
      this._now_time = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter内置时间日期插件')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${formatDate(_now, [yyyy, '-', mm, '-', dd])}"),
                        Icon(Icons.arrow_drop_up),
                      ],
                    ),
                    onTap: _showDatePicker),
                InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('${_now_time?.format(context)}'),
                      ],
                    ),
                    onTap: _showTimePicker),
              ],
            )
          ],
        ));
  }
}
