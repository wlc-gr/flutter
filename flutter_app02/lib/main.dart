import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './routes/Routes.dart';
import './config/httpHeaders.dart';
import 'utils/DioHelper.dart';
import 'package:dio/dio.dart';
import 'utils/sp_util.dart';
import 'package:flustars/flustars.dart' hide SpUtil;
import 'utils/global.dart';

void main() {
  Global.init(() {
    runApp(MyApp2());
  });
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  void initState() {
    super.initState();
    _initDio();
  }

//初始化网络请求
  void _initDio() {
    BaseOptions baseOptions = DioHelper.addBaseUrl('http://test.sunxung.cn:3083');
    String cookie = SpUtil.getString('app_token');
    if (ObjectUtil.isNotEmpty(cookie)) {
      Map<String, dynamic> _headers = new Map();
      _headers["Cookie"] = cookie;
      baseOptions.headers = _headers;
    }else{
      Map<String, dynamic> _headers = new Map();
      _headers["Cookie"] = "user_login_name=wanglaicai; test_sid=03133f510efc4e149425e33b9d073746";
      baseOptions.headers = _headers;
    }
    HttpConfig config =
        new HttpConfig(options: baseOptions, interceptors: [LogInterceptor()]);
    DioHelper().setConfig(config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        //此处
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF666666),
        accentColor: Color(0xFF666666),
        indicatorColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: '路由导航',
      initialRoute: '/my_dialog',
      onGenerateRoute: onGenerateRoute,
//        theme: ThemeData(primarySwatch: Colors.green)
    );
  }
}
