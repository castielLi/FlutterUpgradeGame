import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'dart:convert' as convert;

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool hadInit = false;

  void getRules() async{
    dynamic content = await FileStorage.getRule("rule");
    if(content == ""){
      BaseService.getRule((model){
        Global();
        Global.setBaseRule(model);
      });
    }else{
//      BaseRuleModel model = BaseRuleModel.fromJson(convert.jsonDecode(content));
//      Global();
//      Global.setBaseRule(model);
      BaseService.getRule((model){
        Global();
        Global.setBaseRule(model);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }

    this.getRules();

    ///防止多次进入
    hadInit = true;

    ///延迟2.5秒进入
    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      //直接进入首页
      Application.router
          .navigateTo(context, UpgradeGameRoute.loginPage, replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return new Container(
      color: SystemColor.primaryWhite,
      child: Stack(

        children: <Widget>[
          new Center(

            child:
            new Image(image: new AssetImage('resource/images/welcome.png')),
          ),
        ],
      ),
    );
  }
}