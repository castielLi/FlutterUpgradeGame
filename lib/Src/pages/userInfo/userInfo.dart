import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class UserInfoDetail extends StatefulWidget {
  @override
  _UserInfoDetailState createState() => new _UserInfoDetailState();
}

class _UserInfoDetailState extends State<UserInfoDetail> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
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
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "交易明细",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "提现记录",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "攻 略",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "实名认证",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "客服中心",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
          ],
        ),
      ),
    );
  }
}