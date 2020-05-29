import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:fluro/fluro.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/pages/welcome/welcomePage.dart';
import 'package:upgradegame/Common/app/initAppBaseSetting.dart';
import 'dart:async';
import 'package:upgradegame/Src/provider/provider.dart';



void main() {
  var providers = AppProvider.initAppProvider();
//
  runZoned(() {
    runApp(ProviderNode(child: UpgradeGameApp(), providers: providers));

  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class UpgradeGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //全局路由注入
    final router = Router();
    UpgradeGameRoute.configureRoutes(router);
    Application.router = router;

    return InitAppSetting(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //隐藏dubug图标
        ///实现退出那个页面就进入那个页面。
        routes: {
          '/': (context) {
            return WelcomePage();
          }
        },
      ),
    );
  }
}


