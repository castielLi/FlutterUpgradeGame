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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginPageHide = false;
  bool registerPageHide = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final iDController = TextEditingController();
  final nameController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  ProgressHUD _progressHUD;
  bool _loading = false;

  var currentToken = "";

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
//    if (currentToken != null) {
//      this.showOrDismissProgressHUD();
//      LoginService.loginWithToken((model) {
//        this.showOrDismissProgressHUD();
//        if (model != null) {
//          Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model);
//          Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
//        }
//      });
//    }
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
      child: ProvideMulti(
          builder: (context, child, model) {
            return Stack(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(100), // 左
                      ScreenUtil().setHeight(600), // 上
                      ScreenUtil().setWidth(100), // 右
                      ScreenUtil().setHeight(400)), // 下
                  child: Stack(
                    children: [
                      Offstage(
                        offstage: loginPageHide,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "用户名",
                                controller: usernameController,
                                icon: Icon(Icons.account_box),
                              ),
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "密码",
                                controller: passwordController,
                                icon: Icon(Icons.lock),
                                obscureText: true,
                              ),
                              new RaisedButton(
                                  child: Text("登 录"),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    print("user:" + usernameController.text + ",password:" + passwordController.text);
                                    this.showOrDismissProgressHUD();
                                    LoginService.login("asdf", (model) {
                                      this.showOrDismissProgressHUD();
                                      if (model != null) {
                                        Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model);
                                        Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                                      }
                                    });
                                  }),
                              new GestureDetector(
                                child: new Image(
                                  image: AssetImage("resource/images/wechat.png"),
                                  width: ScreenUtil().setWidth(150),
                                  fit: BoxFit.fill,
                                ),
                                onTap: () {
                                  setState(() {
                                    loginPageHide = true;
                                    registerPageHide = false;
                                  });
                                  fluwx.sendWeChatAuth(scope: "snsapi_userinfo", state: "wechat_sdk_demo_test").then((data) {
                                    print(data);
                                  }).catchError((e) {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: registerPageHide,
                        child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          backgroundColor: Colors.transparent,
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "手机",
                                controller: phoneController,
                                inputType: TextInputType.number,
                                icon: Icon(Icons.phone),
                              ),
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "身份证",
                                controller: iDController,
                                icon: Icon(Icons.account_box),
                              ),
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "姓名",
                                controller: nameController,
                                icon: Icon(Icons.account_box),
                              ),
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "密码",
                                controller: registerPasswordController,
                                icon: Icon(Icons.lock),
                                obscureText: true,
                              ),
                              MyTextField(
                                height: ScreenUtil().setHeight(SystemButtonSize.inputDecorationHeight),
                                hintText: "确认密码",
                                controller: repeatPasswordController,
                                icon: Icon(Icons.lock),
                                obscureText: true,
                              ),
                              new RaisedButton(
                                  child: Text("注 册"),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    this.showOrDismissProgressHUD();
                                    LoginService.login("asdf", (model) {
                                      this.showOrDismissProgressHUD();
                                      if (model != null) {
                                        Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model);
                                        Application.router.navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _progressHUD
              ],
            );
          },
          requestedValues: [BaseUserInfoProvider]),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
