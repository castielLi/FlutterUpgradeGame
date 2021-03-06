import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/widget/confirmDialog/confirmDialog.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/detailDialog.dart';
import 'package:upgradegame/Src/common/widget/resourceDialog/resourceDialog.dart';
import 'package:upgradegame/Src/pages/fight/fightPage.dart';
import 'package:upgradegame/Src/pages/login/login.dart';
import 'package:upgradegame/Src/pages/main/mainPage.dart';
import 'package:upgradegame/Src/pages/privacyTerms/privacyTerms.dart';
import 'package:upgradegame/Src/pages/welcome/welcomePage.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/smallDetailDialog.dart';

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
  String termName = params['termName']?.first;
  return PrivacyTermsPage(
    termName: termName,
  );
});

Handler confirmDialogHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ConfirmDialog();
});
Handler fightPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FightPage();
});

Handler smallDetailDialogPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  double height = double.parse(params['height']?.first);
  double width = double.parse(params['width']?.first);
  String childName = params['childName']?.first;
  String title = params['title']?.first;
  int row = int.parse(params['row']?.first);
  int column = int.parse(params['width']?.first);
  return SmallDetailDialog(
    height: height,
    width: width,
    childWidgetName: childName,
    title: title,
    row:row,
    column: column,
  );
});
