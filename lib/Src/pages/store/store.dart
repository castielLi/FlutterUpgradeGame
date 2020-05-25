import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';

class StoreDetail extends StatefulWidget {
  @override
  _StoreDetailState createState() => new _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(280),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ProductItem(
              volumeAmount: "38",
              callback: (){

              },
              cashAmount: "10",
            ),
            new ProductItem(
              volumeAmount: "108",
              callback: (){

              },
              cashAmount: "50",
            ),
            new ProductItem(
              volumeAmount: "158",
              callback: (){

              },
              cashAmount: "70",
            ),
            new ProductItem(
              volumeAmount: "258",
              callback: (){

              },
              cashAmount: "100",
            )
          ],
        ),
      ),
    );
  }
}