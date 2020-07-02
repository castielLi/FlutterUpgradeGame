import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/login/service/loginService.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:progress_hud/progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      new RaisedButton(
                          child: Text("login"),
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
                  )),
                  margin: EdgeInsets.only(top: 200),
                ),
                _progressHUD
              ],
            );
          },
          requestedValues: [BaseUserInfoProvider]),
    );
  }
}
