import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/testPage/testPage.dart';

//import '../pages/detail_page.dart';
//config
Handler testPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return WelcomePage();
    });

