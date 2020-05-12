import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:fluro/fluro.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Src/pages/welcome/welcomePage.dart';
import 'package:upgradegame/Common/app/initAppBaseSetting.dart';
import 'dart:async';



void main() {
  var providers = Providers();
//  var couponProvide = CouponProvide();
//  var protocolProvide = ProtocolProvide();
//  var currentIndexProvide = CurrentIndexProvide();
//  var carProvide = CartProvide();
//  providers
//    ..provide(Provider<CartProvide>.value(carProvide))
//    ..provide(Provider<CouponProvide>.value(couponProvide))
//    ..provide(Provider<ProtocolProvide>.value(protocolProvide))
//    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
//
  runZoned(() {
    runApp(ProviderNode(child: UpgradeGameApp(), providers: providers));
//    PaintingBinding.instance.imageCache.maximumSize = 100; //对app内图片缓存大小处理
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


