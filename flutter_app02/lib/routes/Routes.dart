import 'package:flutter/material.dart';
import '../consts/Consts.dart';
import '../pages/FormPage.dart';
import '../pages/OnUnknownRoutePage.dart';
import '../pages/SerchPage.dart';
import '../tabs/Tabs.dart';
import '../pages/AppBarDemoPage.dart';
import '../pages/LoginPage.dart';
import '../pages/LoginPageSecond.dart';
import '../pages/LoginPageThrid.dart';
import '../pages/TabContrllerPage.dart';
import '../pages/SnackBarPage.dart';
import '../pages/MyButtonPage.dart';
import '../pages/TextFiledPage.dart';
import '../pages/MyCheckboxDemoPage.dart';
import '../MyHomePage.dart';
import '../pages/other_button_demo.dart';
import '../pages/date_picker_demo.dart';
import '../pages/inner_flutter_datepicker.dart';
import '../pages/flutter_cupertino_date_pickerPage.dart';
import '../pages/swiper_page.dart';
import '../pages/my_dialog.dart';
import '../pages/my_shart_page.dart';
import '../pages/user_login_page.dart';
import '../pages/device_and_location_info.dart';

//配置路由
final routes = {
  Consts.HOME: (context) => Tabs(),
  Consts.FROM: (context) => FormPage(),
  Consts.SEARRCH: (context, {arguments}) => SearchPage(arguments: arguments),
  Consts.ONUNkNOWNROUTE: (context) => OnUnknownRoutePage(),
  Consts.APP_BAR: (context) => AppBarDemoPage(),
  Consts.LOGIN_SECOND: (context) => LoginPageSecond(),
  Consts.LOGIN_THIRD: (context) => LoginPageThridPage(),
  Consts.LOGIN_FIRST: (context) => LoginPage(),
  Consts.TAB_CONTROLELR: (context) => TabContrllerPage(),
  '/snackBarPage': (context) => SnackBarPage(),
  '/mybutton': (context) => MyButtonPage(),
  '/myTextFieldpage': (context) => MyTextFieldPage(),
  '/myCheckBoxPage': (context) => MyCheckboxDemoPage(),
  '/myHomePage': (context) =>
      MyHomePage(title: 'Flutter Code Input  Demo Home Page'),
  '/otherbutton': (context) => OtherButtonPage(),
  '/data_picker': (context) => DatePickerDemo(),
  '/inner_datepicker': (context) => InnerDatePickerPage(),
  '/flutter_cupertino_date_pickerPage': (context) =>
      FlutterCupertionPickerDemo(),
  '/myswiper': (context) => MySwiperPage(),
  '/my_dialog': (context) => MyDialogPage(),
  '/my_shart': (context) => MyShartPage(),
  '/user_login_page': (context) => UserLoginPage(),
  '/devide_or_location':(context)=>DeviceAndLocationInfo(),

};
//统一路由管理
var onGenerateRoute = (RouteSettings settings) {
  final String routeName = settings.name;
  final Function pageContentBuild = routes[routeName];
  if (null != pageContentBuild) {
    //带参路由
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuild(context, arguments: settings.arguments));
      return route;
    } else {
      //不带参路由
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuild(context));
      return route;
    }
  } else {
    final Route route = MaterialPageRoute(
        builder: (context) => routes[Consts.ONUNkNOWNROUTE](context));
    return route;
  }
};
