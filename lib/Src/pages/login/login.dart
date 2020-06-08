import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      child: Provide<BaseUserInfoProvider>(
        builder: (context,child,baseUserInfo){
          return Stack(
            children: <Widget>[
              new Container(
                child:Center(
                  child:
                  new RaisedButton(onPressed: (){
                    this.showOrDismissProgressHUD();
                    LoginService.login((model){
                      this.showOrDismissProgressHUD();
                      Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(model);
                      Application.router
                          .navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
                    });
                  }),
                ),
              ),
              _progressHUD
            ],
          );
        },
      ),
    );
  }
  void toast(int type,int showType) async {
    try {
//      await platform.invokeMethod('showAd', <String, dynamic>{'type': type,"showType":showType,"posId":""});
    } on PlatformException catch (e) {
      print(e);
    }
  }
  void _onEvent(Object event) {
    print("event »ØÀ´ÁË³É¹¦");
  }

  void _onError(Object error) {
    print("event »ØÀ´ÁËÊ§°Ü");
  }
}