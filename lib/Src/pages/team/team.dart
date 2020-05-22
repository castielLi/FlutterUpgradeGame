import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class TeamDetail extends StatefulWidget {
  @override
  _TeamDetaillState createState() => new _TeamDetaillState();
}

class _TeamDetaillState extends State<TeamDetail> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(350),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(child:
              new ImageTextButton(imageUrl: "resource/images/teamSwitchBackground.png",imageWidth: ScreenUtil().setWidth(400),imageHeight: ScreenUtil().setHeight(190),
                buttonName: "徒 弟",textSize: SystemFontSize.settingTextFontSize,callback: (){

                },),
              ),
              new Expanded(child:
              new ImageTextButton(imageUrl: "resource/images/teamSwitchBackground.png",imageWidth: ScreenUtil().setWidth(400),imageHeight: ScreenUtil().setHeight(190),
                buttonName: "徒 孙",textSize: SystemFontSize.settingTextFontSize,callback: (){

                },),
              )
            ],
          ),

        ],
      ),
    );
  }
}