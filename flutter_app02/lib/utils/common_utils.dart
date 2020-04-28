import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import './BaseConstant.dart';

class CommonUtils {
  //返回本地图片的路
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }

  //判断是否已登录系统
  static bool isLogin() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.keyAppToken));
  }
}
