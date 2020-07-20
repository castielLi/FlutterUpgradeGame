import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adDialog.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adDialog.dart';
import 'dart:convert' as convert;

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  bool hadInit = false;

  void initBaseWidget(){
    AdDialog();
  }

  void getRules() async{
    dynamic content = await FileStorage.getContent("rule");
    if(content == ""){
      BaseService.getRule((model){
        if(model!=null){
          Global();
          Global.setBaseRule(model);
        }
      });
    }else{
//      BaseRuleModel model = BaseRuleModel.fromJson(convert.jsonDecode(content));
//      Global();
//      Global.setBaseRule(model);
      BaseService.getRule((model){
        if(model!=null){
          Global();
          Global.setBaseRule(model);
        }
      });
    }
  }

  adCallback(){
    Application.router
        .navigateTo(context, UpgradeGameRoute.loginPage, replace: true,clearStack: true);
  }

  adFailedCallback(){
    Application.router
        .navigateTo(context, UpgradeGameRoute.loginPage, replace: true,clearStack: true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getRules();
    this.initBaseWidget();
    ///显示开屏广告
    AdDialog().showAd(1, 1);
    AdDialog().setCallback(this.adCallback,this.adFailedCallback,true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }



//    ///防止多次进入
//    hadInit = true;
//
//    ///延迟2.5秒进入
//    new Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
//      //直接进入首页
//      Application.router
//          .navigateTo(context, UpgradeGameRoute.loginPage, replace: true);
//    });
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