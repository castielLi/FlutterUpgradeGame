import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class SettingDetail extends StatefulWidget {
  @override
  _SettingDetailState createState() => new _SettingDetailState();
}

class _SettingDetailState extends State<SettingDetail> {
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
              buttonName: "账号及安全",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "用户协议",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "隐私条款",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "关于我们",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
            new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
              buttonName: "检查更新",textSize: SystemFontSize.settingTextFontSize,callback: (){

              },),
          ],
        ),
      ),
    );
  }
}