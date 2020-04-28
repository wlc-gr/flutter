import 'package:flutter/material.dart';
import 'my_device_info.dart';
import 'my_location_page.dart';

class DeviceAndLocationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("演示设备与地理位置信息"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('获取设备信息'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MyDeviceInfo()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  child: Text('获取地理位置信息'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => MyLocationPage()));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
