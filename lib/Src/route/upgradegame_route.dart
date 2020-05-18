import 'package:flutter/material.dart';
import 'route_handler.dart';
import 'package:fluro/fluro.dart';

class UpgradeGameRoute {
  static String welcomePage = "/welcomePage";
  static String loginPage = "/loginPage";
  static String mainPage = "/mainPage";
  static String detailDialogPage = "/detailDialogPage";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
        });

    router.define(welcomePage, handler: welcomePageHandler);
    router.define(loginPage, handler: loginPageHandler);
    router.define(mainPage, handler: mainPageHandler);
    router.define(detailDialogPage, handler: detailDialogHandler);

  }
}
