import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/animated_button.dart';
import '../pages/will_pop_scopeTestRoute.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../pages/step_processPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import '../config/httpHeaders.dart';

//import 'package:base_library/base_library.dart';
import 'package:flustars/flustars.dart';
import '../utils/DioHelper.dart';

import 'package:common_utils/common_utils.dart';
import '../pages/pull_to_refresh.dart';

class MyDialogPage extends StatefulWidget {
  @override
  _MyDialogPageState createState() => _MyDialogPageState();
}

class _MyDialogPageState extends State<MyDialogPage> {
  double percentage = 0.0;

  //定义变量
  ProgressDialog pr;

  // 屏幕宽
  double _screenWidth = 0.0;

// 屏幕高
  double _screenHeight = 0.0;
  WidgetUtil widgetUtil = new WidgetUtil();

  @override
  void dispose() {
    widgetUtil = null;
    this.pr = null;
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _screenWidth = ScreenUtil.getInstance().screenWidth;
    _screenHeight = ScreenUtil.getInstance().screenHeight;
  }

  _showAlertDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          double screenWidth = ScreenUtil.getScreenW(context);
// 屏幕高
          double screenHeight = ScreenUtil.getScreenH(context);
          Rect rect = WidgetUtil.getWidgetBounds(context);
          return AlertDialog(
            title: Text('提示信息 '),
//            titleTextStyle: TextStyle(fontSize: 20, color: Colors.green),
            content: Text(
                'screenWidth=${this._screenWidth},screenHeight=${this._screenHeight}?'),
//            contentTextStyle:
//                TextStyle(fontSize: 20, backgroundColor: Colors.black),
            // backgroundColor: Colors.lightGreen,
//            shape: CircleBorder(side: BorderSide(width: 10,color: Colors.white)),
            actions: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: FlatButton(
                      child: Text('取消'),
                      onPressed: () {
                        print("取消");
                        Navigator.of(context).pop('cancle');
                        print(MoneyUtil.changeF2Y(860,
                            format: MoneyFormat.NORMAL));
                        print(MoneyUtil.changeF2YWithUnit(860,
                            unit: MoneyUnit.YUAN));
                        //时间轴

                        String string = TimelineUtil.format(
                            DateTime(2020, 4).millisecondsSinceEpoch,
                            locale: 'zh',
                            dayFormat: DayFormat.Simple);
                        print('------$string');

                        print(NumUtil.add(10.999, 10));
                        //拼音工具类型
                        print(PinyinHelper.getPinyin('王来财', separator: ""));
                        print(ChineseHelper.convertCharToSimplifiedChinese(
                            'wanglaicai'));
                        print(ChineseHelper.convertCharToTraditionalChinese(
                            'wanglaicai'));
                        //正则
                        //定时任务
                      },
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  print("确定");
                  Navigator.of(context).pop('ok');
                },
              )
            ],
          );
        });
    print('----------${result}');
  }

  _showSimpleDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('请选择一项'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('选择A'),
                onPressed: () {
                  print("A");
                  Navigator.pop(context, 'A');
                },
              ),
              Divider(
                color: Colors.black38,
              ),
              SimpleDialogOption(
                child: Text('选择B'),
                onPressed: () {
                  print("B");
                  Navigator.pop(context, 'B');
                },
              ),
              Divider(
                color: Colors.black38,
              ),
              SimpleDialogOption(
                child: Text('选择C'),
                onPressed: () {
                  print("C");
                  Navigator.pop(context, 'C');
                },
              ),
              Divider(
                color: Colors.black38,
              ),
            ],
          );
        });
    print('------_showSimpleDialog----------${result}');
  }

  _modalBottomSheetDialog() async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          Rect rect = WidgetUtil.getWidgetBounds(context);
          return Container(
            height: 220,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('分享A'),
                  onTap: () {
                    Navigator.pop(context, '分享A');
                    print('--------_modalBottomSheetDialog------分享A--------');
                    print('--------_modalBottomSheetDialog------$rect--------');
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: Text('分享B'),
                  onTap: () {
                    Navigator.pop(context, '分享B');
                    print('--------_modalBottomSheetDialog------分享B--------');
                    print('--------_modalBottomSheetDialog------$rect--------');
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  title: Text('分享C'),
                  onTap: () {
                    Navigator.pop(context, '分享C');
                    print('--------_modalBottomSheetDialog------分享C--------');
                    print('--------_modalBottomSheetDialog------$rect--------');
                  },
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          );
        });
    print('-------_modalBottomSheetDialog  $result---------');
  }

  _networkGiffyDialog() {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  'http://ww4.sinaimg.cn/large/85cccab3tw1esjsvpc9iyg20dw07iwrt.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text("高清美女GIF图片",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)),
              description: Text(
                '''This is a granny eating chocolate dialog box.
            This library helps you easily create fancy giffy dialog''',
                textAlign: TextAlign.center,
              ),
              entryAnimation: EntryAnimation.TOP_LEFT,
              onCancelButtonPressed: () {
                Navigator.pop(context, 'onCancelButtonPressed');
                print("onCancelButtonPressed");
              },
              onOkButtonPressed: () {
                Navigator.pop(context, 'onOkButtonPressed');
                print("onOkButtonPressed");
              },
            ));
  }

  showDebugPrint() {
    debugPrint('Print from Callback Function');
  }

  void showAlertDialogOnOkCallback(String title, String msg,
      DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOPSLIDE,
      dialogType: dialogType,
      tittle: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green.shade900,
      btnOkOnPress: onOkPress,
    ).show();
  }

  _showAwesomeDialog() {
    AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'INFO',
            desc:
                'Dialog description here..................................................',
            btnCancelOnPress: () {},
            btnOkOnPress: showDebugPrint)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Download, isDismissible: true, showLogs: true);
    pr.style(
        message: 'Downloading file...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Scaffold(
      appBar: AppBar(title: Text('Dialog')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('alert弹出框-AlertDialog'),
              onPressed: _showAlertDialog,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('select弹出框-SimpleDialog'),
              onPressed: _showSimpleDialog,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('actionSheet底部弹出框-ShowModalBottomSheet'),
              onPressed: _modalBottomSheetDialog,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Fluttertoast'),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: "提示信息",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.black,
                  gravity: ToastGravity.BOTTOM,
                  textColor: Colors.white,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Giffy Dialogs第三方库'),
              onPressed: _networkGiffyDialog,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('awesome_dialog 第三方库'),
              onPressed: _showAwesomeDialog,
            ),
            SizedBox(
              height: 20,
            ),
            AnimatedButton(
              text: 'Info Dialog',
              pressEvent: () {
                AwesomeDialog(
                        context: context,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        tittle: 'INFO',
                        desc:
                            'Dialog description here..................................................',
                        btnCancelOnPress: () {},
                        btnOkOnPress: showDebugPrint)
                    .show();
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('导航返回拦截WillPopScope'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => WillPopScopeTestRoute()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('progress_dialog'),
              onPressed: () {
                pr.show();
                Future.delayed(Duration(seconds: 2)).then((onvalue) {
                  this.percentage += 30.0;
                  print(this.percentage);
                  this.pr.update(
                        progress: percentage,
                        message: "Please wait...",
                        progressWidget: Container(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator()),
                        maxProgress: 100.0,
                        progressTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400),
                        messageTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 19.0,
                            fontWeight: FontWeight.w600),
                      );
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    this.percentage += 30.0;
                    this.pr.update(
                        progress: percentage, message: "Few more seconds...");
                    print(this.percentage);
                    Future.delayed(Duration(seconds: 2)).then((value) {
                      this.percentage += 30.0;
                      this.pr.update(
                          progress: percentage, message: "Almost done...");
                      print(this.percentage);
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        pr.hide().whenComplete(() {
                          print(this.pr.isShowing());
                        });
                        this.percentage = 0.0;
                      });
                    });
                  });
                });
                Future.delayed(Duration(seconds: 10)).then((onvalue) {
                  print("PR status  ${pr.isShowing()}");
                  if (this.pr.isShowing()) {
                    this.pr.hide().then((ishidden) {
                      print(ishidden);
                    });
                    print("PR status  ${pr.isShowing()}");
                  }
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('step_progress'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => MyStepProgressPage()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Dio网络请求'),
              onPressed: () async {
//                DioHelper().setConfig(HttpConfig(
//                    options: DioHelper.addBaseUrl("http://192.168.1.102:3000"),
//                    interceptors: [LogInterceptor(responseBody: false)]));
                var result = await DioHelper()
                    .getAsync(url: "/basicComponents/pc/sys/user/find");
                print('-------------------------> $result');
              },
            ),
            RaisedButton(
              child: Text('下拉刷新和上拉分页'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PullToRefreshPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
