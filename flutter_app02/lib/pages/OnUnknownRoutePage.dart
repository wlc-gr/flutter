import 'package:flutter/material.dart';

//定义
class OnUnknownRoutePage extends StatelessWidget {
  const OnUnknownRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('未定义路由或路由配置有误'),
      ),
      appBar: AppBar(
        title: Text('未定义路由或路由配置有误'),
      ),
    );
  }
}
