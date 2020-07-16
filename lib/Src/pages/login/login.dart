import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Src/pages/login/service/loginService.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'model/LoginResponseModel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //注册页面
  final trueNameController = TextEditingController();
  final phoneController = TextEditingController();
  final iDController = TextEditingController();
  final accountController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  ProgressHUD _progressHUD;
  bool _loading = false;

  var currentToken = "";
  var currentVerfied = false;
  bool userVerified = true;

  void initState() {
    super.initState();
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );
    this.initParams();
  }

  initParams() async {
    currentToken = await LoginService.getToken();
    currentVerfied = await LoginService.getVerified();
    if (currentToken != null && currentVerfied) {
      this.showOrDismissProgressHUD();
      LoginService.loginWithToken((model) {
        this.showOrDismissProgressHUD();
        if (model != null) {
          Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model);
          Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
        }
      });
    }
  }

  void showOrDismissProgressHUD() {
    setState(() {
      if (_loading) {
        _progressHUD.state.dismiss();
      } else {
        _progressHUD.state.show();
      }

      _loading = !_loading;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.black,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ProvideMulti(
            builder: (context, child, model) {
              return Stack(
                children: <Widget>[
                  ///登录界面
                  new Offstage(
                    offstage: !this.userVerified,
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(0), ScreenUtil().setWidth(100), ScreenUtil().setHeight(0)),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(800)),
                        child: Column(
                          children: [
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: usernameController,
                              hintText: '用户名:',
                              icon: Icon(Icons.person),
                            ),
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: passwordController,
                              hintText: '密码:',
                              icon: Icon(Icons.lock),
                              obscureText: true,
                            ),
                            new RaisedButton(
                                child: Text("登 录"),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  this.showOrDismissProgressHUD();
                                  LoginService.loginWithAccount("account", "password", (LoginReponseModel model) {
                                    this.showOrDismissProgressHUD();
                                    if (model != null) {
                                      ///初始化用户
                                      Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model.userinfo);
                                      Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                                    }
                                  });
                                }),
                            new GestureDetector(
                              child: new Image(
                                image: AssetImage("resource/images/wechat.png"),
                                width: ScreenUtil().setWidth(SystemButtonSize.inputDecorationHeight),
                                fit: BoxFit.fill,
                              ),
                              onTap: () {
                                this.showOrDismissProgressHUD();
                                LoginService.login("asdf", (LoginReponseModel model) {
                                  this.showOrDismissProgressHUD();
                                  if (model != null) {
                                    if (model.verified) {
                                      ///初始化用户
                                      Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model.userinfo);
                                      Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                                    } else {
                                      ///初始化用户
                                      Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model.userinfo);
                                      setState(() {
                                        this.userVerified = false;
                                      });
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///实名认证界面
                  new Offstage(
                    offstage: this.userVerified,
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(0), ScreenUtil().setWidth(100), ScreenUtil().setHeight(0)),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: ScreenUtil().setHeight(500)),
                        child: Column(
                          children: [
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: trueNameController,
                              hintText: '真实姓名:',
                              icon: Icon(Icons.person),
                            ),
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: phoneController,
                              hintText: '电话:',
                              icon: Icon(Icons.phone),
                              inputType: TextInputType.number,
                            ),
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: iDController,
                              hintText: '身份证件:',
                              icon: Icon(Icons.account_box),
                            ),
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: accountController,
                              hintText: '账号:',
                              icon: Icon(Icons.email),
                            ),
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: registerPasswordController,
                              hintText: '密码:',
                              icon: Icon(Icons.lock),
                              obscureText: true,
                            ),
                            new MyTextField(
                              height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                              controller: repeatPasswordController,
                              hintText: '确认密码:',
                              icon: Icon(Icons.lock),
                              obscureText: true,
                            ),
                            new RaisedButton(
                                child: Text("注 册"),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  this.showOrDismissProgressHUD();
                                  LoginService.setUserInfo("", "", "", "", "", (bool success) {
                                    if (success) {
                                      Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                                    }
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _progressHUD
                ],
              );
            },
            requestedValues: [BaseUserInfoProvider]),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
