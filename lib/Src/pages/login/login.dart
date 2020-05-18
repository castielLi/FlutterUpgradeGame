import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return new Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          new Container(
            child:Center(
              child:
              new RaisedButton(onPressed: (){
                Application.router
                    .navigateTo(context, UpgradeGameRoute.mainPage, clearStack: true);
              }),
            ),
          ),
        ],
      ),
    );
  }
}