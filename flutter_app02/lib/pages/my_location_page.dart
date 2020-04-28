import 'package:flutter/material.dart';
import 'package:amap_location/amap_location.dart';

class MyLocationPage extends StatefulWidget {
  @override
  _MyLocationPageState createState() => _MyLocationPageState();
}

class _MyLocationPageState extends State<MyLocationPage> {
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     _getLocation();
  }

  Future _getLocation() async {
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    var result = await AMapLocationClient.getLocation(true);
    print('${result.latitude}');
    print('${result.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("高德定位"),);
  }
}
