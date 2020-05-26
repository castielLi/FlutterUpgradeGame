import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';

class adDividendDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  adDividendDetail({Key key,this.HUD}):super(key:key);
  _adDividendDetailState createState() => new _adDividendDetailState();
}

class _adDividendDetailState extends State<adDividendDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(280),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Container(

      ),
    );
  }
}