import 'package:flutter/material.dart';

class WillPopScopeTestRoute extends StatefulWidget {
  @override
  _WillPopScopeTestRouteState createState() => _WillPopScopeTestRouteState();
}

class _WillPopScopeTestRouteState extends State<WillPopScopeTestRoute> {
  DateTime _lastPressAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('1秒内连续按两次返回键退出')),
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressAt == null ||
              DateTime.now().difference(_lastPressAt) > Duration(seconds: 1)) {
            this._lastPressAt = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Text('1秒内连续按两次返回键退出'),
        ),
      ),
    );
  }
}
