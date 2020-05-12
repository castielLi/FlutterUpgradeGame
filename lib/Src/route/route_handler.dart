import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/welcome/welcomePage.dart';
import 'package:upgradegame/Src/pages/login/login.dart';

//import '../pages/detail_page.dart';
//config
Handler welcomePageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return WelcomePage();
    });


Handler loginPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    });