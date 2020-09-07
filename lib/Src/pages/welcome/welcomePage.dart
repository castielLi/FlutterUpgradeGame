import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/storge/fileStore.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adDialog.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adTimer.dart';
import 'package:upgradegame/Src/provider/baseAdTimerProvider.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => new _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  void initBaseWidget() {
    AdDialog();
  }

  void getRules() async {
     BaseService.getRule((model) {
        if (model != null) {
          Global();
          Global.setBaseRule(model);
        }else{
          ///强制关闭程序
          SystemNavigator.pop();
        }
      });
     BaseService.getRule2((model){
        if (model != null) {
          Global();
          Global.setExtraRule(model);
        }else{
          ///强制关闭程序
          SystemNavigator.pop();
        }
      });
  }

  adCallback() {
    Application.router.navigateTo(context, UpgradeGameRoute.loginPage, replace: true, clearStack: true);
  }

  adFailedCallback() {
    Application.router.navigateTo(context, UpgradeGameRoute.loginPage, replace: true, clearStack: true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getRules();
    this.initBaseWidget();

    ///显示开屏广告
    AdDialog().showAd(1, 1,"POSIDtvy0gsf7zfm1");
    AdDialog().setCallback(this.adCallback, this.adFailedCallback,null, true);

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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resource/images/loginBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
