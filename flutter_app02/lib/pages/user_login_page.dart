import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import '../utils/sp_util.dart';
import '../models/models.dart';
import 'package:loading/loading.dart';

class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Image.asset(
              "images/ic_login_bg.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            LoginBody(),
          ],
        ));
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = new TextEditingController();
    TextEditingController _controllerPwd = new TextEditingController();
    //用户登录接口
    void _userLogin() {
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      if (username.isEmpty || username.length < 6) {
        Fluttertoast.showToast(
          msg: username.isEmpty ? "请输入用户名～" : "用户名至少6位～",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Fluttertoast.showToast(
          msg: password.isEmpty ? "请输入用户名～" : "用户名至少6位～",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
        return;
      }
      try {
        //TODO 调用用户登录接口 登录成功提示登录成功信息 1秒后页面跳传到主界面
        //TODO 调用用户登录接口 登录失败提示错误信息
      } catch (e) {}
    }

    //查询本地是否已存储用户信息
    UserModel userModel =
        SpUtil.getObj("user_model", (v) => UserModel.fromJson(v));
    _controllerName.text = userModel?.username ?? '';
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: Column(
              children: <Widget>[
            Loading(indicator: BallScaleIndicator(), size: 100.0,color: Colors.black),
                LoginItem(
                  controller: _controllerName,
                  prefixIcon: Icons.person,
                  hintText: "用户名",
                ),
                SizedBox(
                  height: 15,
                ),
                LoginItem(
                  controller: _controllerPwd,
                  prefixIcon: Icons.lock,
                  hasSuffixIcon: true,
                  hintText: "密码",
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text(
                      "忘记密码",
                      style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                    ),
                    onTap: () {
                      Fluttertoast.showToast(
                        msg: "请联系管理员～",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.black,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                      );

                    },
                  ),
                ),
                RoundButton(
                  text: '登录',
                  margin: EdgeInsets.only(top: 20),
                  onPressed: () {
                    _userLogin();
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    //TODO 页面跳转到用户注册页面
                    Fluttertoast.showToast(
                      msg: "功能开发中---",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.black,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                    );
                  },
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "用户注册",
                        style:
                            TextStyle(color: Color(0xFF999999), fontSize: 14)),
                    TextSpan(
                        text: "用户注册",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14))
                  ])),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key key,
    this.width,
    this.height = 50,
    this.margin,
    this.radius,
    this.bgColor,
    this.highlightColor,
    this.splashColor,
    this.child,
    this.text,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  final double radius;
  final Color bgColor;
  final Color highlightColor;
  final Color splashColor;

  final Widget child;

  final String text;
  final TextStyle style;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color _bgColor = bgColor ?? Theme.of(context).primaryColor;
    BorderRadius _borderRadius = BorderRadius.circular(radius ?? (height / 2));
    return new Container(
      width: width,
      height: height,
      margin: margin,
      child: new Material(
        borderRadius: _borderRadius,
        color: _bgColor,
        child: new InkWell(
          borderRadius: _borderRadius,
          onTap: () => onPressed(),
          child: child ??
              new Center(
                child: new Text(
                  text,
                  style:
                      style ?? new TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
        ),
      ),
    );
  }
}

class LoginItem extends StatefulWidget {
  const LoginItem(
      {Key key,
      this.prefixIcon,
      this.hasSuffixIcon = false,
      this.hintText,
      this.controller})
      : super(key: key);

  final IconData prefixIcon;
  final bool hasSuffixIcon;
  final String hintText;
  final TextEditingController controller;

  @override
  _LoginItemState createState() => _LoginItemState();
}

class _LoginItemState extends State<LoginItem> {
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    this._obscureText = widget.hasSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          iconSize: 28,
          icon: Icon(widget.prefixIcon),
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
            child: TextField(
                obscureText: this._obscureText,
                controller: widget.controller,
                style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle:
                        TextStyle(color: Color(0xFF999999), fontSize: 14),
                    suffixIcon: widget.hasSuffixIcon
                        ? IconButton(
                            icon: Icon(
                                this._obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF666666)),
                            onPressed: () {
                              setState(() {
                                this._obscureText = !this._obscureText;
                              });
                            },
                          )
                        : null,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffdedede))),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffdedede))))))
      ],
    );
  }
}
