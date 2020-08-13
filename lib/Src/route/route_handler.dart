import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/detailDialog.dart';
import 'package:upgradegame/Src/common/widget/resourceDialog/resourceDialog.dart';
import 'package:upgradegame/Src/pages/login/login.dart';
import 'package:upgradegame/Src/pages/main/mainPage.dart';
import 'package:upgradegame/Src/pages/privacyTerms/privacyTerms.dart';
import 'package:upgradegame/Src/pages/welcome/welcomePage.dart';

//config
Handler welcomePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WelcomePage();
});

Handler loginPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

Handler mainPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});

Handler detailDialogHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  double height = double.parse(params['height']?.first);
  double width = double.parse(params['width']?.first);
  String childName = params['childName']?.first;
  String title = params['title']?.first;
  return DetailDialog(
    height: height,
    width: width,
    childWidgetName: childName,
    title: title,
  );
});

Handler resourceDialogHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  double height = double.parse(params['height']?.first);
  double width = double.parse(params['width']?.first);
  return ResourceDialog(height: height, width: width);
});

Handler privacyTermsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PrivacyTermsPage();
});
