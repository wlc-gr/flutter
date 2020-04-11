import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class FlutterCupertionPickerDemo extends StatefulWidget {
  @override
  _FlutterCupertionPickerDemoState createState() =>
      _FlutterCupertionPickerDemoState();
}

class _FlutterCupertionPickerDemoState
    extends State<FlutterCupertionPickerDemo> {
  bool _showTitle = true;
  final String MIN_DATETIME = '2010-05-12';
  final String MAX_DATETIME = '2021-11-25';
  final String INIT_DATETIME = '2019-05-17';
  DateTimePickerLocale _locale = DateTimePickerLocale.zh_cn;
  String _format = 'yyyy-MMMM-dd';
  TextEditingController _formatCtrl = TextEditingController();

  DateTime _dateTime;

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      pickerTheme: DateTimePickerTheme(
        showTitle: _showTitle,
        confirm: Text('确定', style: TextStyle(color: Colors.red)),
        cancel: Text('取消', style: TextStyle(color: Colors.cyan)),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: _dateTime,
      dateFormat: _format,
//      dateFormat: 'yyyy 年 MM 月 dd 日 EEE,H 时:m 分',
//      pickerMode: DateTimePickerMode.datetime,
      locale: _locale,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _dateTime = dateTime;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlutterCupertionPickerDemo')),
      body: InkWell(
          onTap: _showDatePicker,
          child: Center(
            child: Text('${this._dateTime}'),
          )),
    );
  }
}
