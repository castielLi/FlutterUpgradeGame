import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/textField/myTextField.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/login/model/WeChatLoginModel.dart';
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
    fluwx.weChatResponseEventHandler.listen((response) {
      this.showOrDismissProgressHUD();
      if (response.errCode.toString() == "0") {
        if (response is fluwx.WeChatAuthResponse) {
          LoginService.login(response.code, (LoginReponseModel model) {
            this.showOrDismissProgressHUD();
            if (model != null) {
              if (model.verified) {
                ///初始化用户
                Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model.userinfo);
                Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                fluwx.weChatResponseEventHandler.skip(1);
              } else {
                ///初始化用户
                Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model.userinfo);
                setState(() {
                  this.userVerified = false;
                });
              }
            }
          });
        }
      } else {
        CommonUtils.showErrorMessage(msg: "微信登录失败");
      }
    });
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
                                  String username = usernameController.text;
                                  String password = passwordController.text;
                                  if ("" == username || "" == password) {
                                    CommonUtils.showErrorMessage(msg: "输入不能为空");
                                    return;
                                  }
                                  this.showOrDismissProgressHUD();
//                                  LoginService.loginWithAccount(username, password, (LoginReponseModel model) {
                                  LoginService.loginWithAccount("lizj", "112233", (LoginReponseModel model) {
//                                  LoginService.loginWithAccount("shisheng", "123321", (LoginReponseModel model) {
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
//                                setState(() {
//                                  this.userVerified = false;
//                                });
                                fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test").then((data) {
                                  print(data);
                                }).catchError((e) {
                                  print(e);
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
                                  String name = trueNameController.text;
                                  String phone = phoneController.text;
                                  String iD = iDController.text;
                                  String account = accountController.text;
                                  String registerPassword = registerPasswordController.text;
                                  String repeatPassword = repeatPasswordController.text;
                                  bool isInputsEmpty = false;
                                  var inputs = [name, phone, iD, account, registerPassword, repeatPassword];
                                  inputs.forEach((input) {
                                    if ("" == input) {
                                      isInputsEmpty = true;
                                      return;
                                    }
                                  });
                                  if (isInputsEmpty) {
                                    CommonUtils.showErrorMessage(msg: "输入不能为空");
                                    return;
                                  }
                                  if (!RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$").hasMatch(phone)) {
                                    CommonUtils.showErrorMessage(msg: "请输入正确的手机号码");
                                    return;
                                  }
                                  if (!RegExp(r"^(\d{6})(18|19|20)?(\d{2})([01]\d)([0123]\d)(\d{3})(\d|X|x)?$").hasMatch(iD)) {
                                    CommonUtils.showErrorMessage(msg: "请输入正确的身份证号码");
                                    return;
                                  }
                                  if (registerPassword != repeatPassword) {
                                    CommonUtils.showErrorMessage(msg: "两次输入密码不一致");
                                    return;
                                  }
                                  this.showOrDismissProgressHUD();
                                  LoginService.setUserInfo(name, iD, phone, account, registerPassword, (bool success) {
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
