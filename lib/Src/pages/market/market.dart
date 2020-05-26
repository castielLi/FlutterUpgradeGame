import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  MarketDetail({Key key,this.HUD}):super(key:key);
  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
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