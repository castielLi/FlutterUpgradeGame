import 'package:flutter/material.dart';
import 'route_handler.dart';
import 'package:fluro/fluro.dart';

class NovaRouters {
  static String testPage = "/testPage";


  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          print('ERROR====>ROUTE WAS NOT FONUND!!!');
        });

    router.define(testPage, handler: testPageHandler);

  }
}
