import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'route_handler.dart';

class UpgradeGameRoute {
  static String welcomePage = "/welcomePage";
  static String loginPage = "/loginPage";
  static String mainPage = "/mainPage";
  static String detailDialogPage = "/detailDialogPage";
  static String resourceDialogPage = "/resourceDialogPage";
  static String privacyTerms = "/privacyTermsPage";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FONUND!!!');
    });

    router.define(welcomePage, handler: welcomePageHandler);
    router.define(loginPage, handler: loginPageHandler);
    router.define(mainPage, handler: mainPageHandler);
    router.define(detailDialogPage, handler: detailDialogHandler);
    router.define(resourceDialogPage, handler: resourceDialogHandler);
    router.define(privacyTerms, handler: privacyTermsHandler);
  }
}
