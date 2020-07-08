import 'package:flutter/material.dart';
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
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
    if (currentToken != null) {
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
      child: ProvideMulti(
          builder: (context, child, model) {
            return Stack(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(100), // 左
                      ScreenUtil().setHeight(600), // 上
                      ScreenUtil().setWidth(100), // 右
                      ScreenUtil().setHeight(600)), // 下
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.transparent,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(150),
                          padding: EdgeInsets.only(top: 5),
                          child: new Card(
                              child: new Container(
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: usernameController,
                                      decoration: new InputDecoration(hintText: '用户名:', border: InputBorder.none, prefixIcon: Icon(Icons.account_box)),
                                      onSubmitted: (String input) {
                                        input = usernameController.text;
                                      },
                                      // onChanged: onSearchTextChanged,
                                    ),
                                  ),
                                ),
                                new IconButton(
                                  icon: new Icon(Icons.cancel),
                                  color: Colors.grey,
                                  iconSize: 18.0,
                                  onPressed: () {
                                    usernameController.clear();
                                  },
                                ),
                              ],
                            ),
                          )),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(150),
                          padding: EdgeInsets.only(top: 5),
                          child: new Card(
                              child: new Container(
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller: passwordController,
                                      decoration: new InputDecoration(hintText: '密码:', border: InputBorder.none, prefixIcon: Icon(Icons.lock)),
                                      onSubmitted: (String input) {
                                        input = passwordController.text;
                                      },
                                      // onChanged: onSearchTextChanged,
                                    ),
                                  ),
                                ),
                                new IconButton(
                                  icon: new Icon(Icons.cancel),
                                  color: Colors.grey,
                                  iconSize: 18.0,
                                  onPressed: () {
                                    passwordController.clear();
                                  },
                                ),
                              ],
                            ),
                          )),
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
                            print("微信登录");
                            fluwx
                                .sendWeChatAuth(
                                scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
                                .then((data) {
                                  print(data);
                            })
                                .catchError((e) {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                _progressHUD
              ],
            );
          },
          requestedValues: [BaseUserInfoProvider]),
    );
  }
}
