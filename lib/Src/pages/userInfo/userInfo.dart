import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/userInfo/userResourceDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeDetail.dart';

class UserInfoDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  final changeTitleCallback;
  final displayOriginalTitleCallback;

  UserInfoDetail({Key key,this.HUD,this.changeTitleCallback,this.displayOriginalTitleCallback}):super(key:key);
  _UserInfoDetailState createState() => new _UserInfoDetailState();
}

class _UserInfoDetailState extends State<UserInfoDetail> {

  bool userInfoHide = false;
  bool tradeDetailHide = true;
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(280),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: this.userInfoHide,
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new UserResourceDetail(
                    imageUrl: "resource/images/avatar.png",
                    amountCash: "100000",
                  ),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "账号及安全",textSize: SystemFontSize.settingTextFontSize,callback: (){

                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "交易明细",textSize: SystemFontSize.settingTextFontSize,callback: (){
                    setState(() {
                      tradeDetailHide = false;
                      userInfoHide = true;
                    });
                    this.widget.changeTitleCallback("交易明细");
                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "提现记录",textSize: SystemFontSize.settingTextFontSize,callback: (){

                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "t币明细",textSize: SystemFontSize.settingTextFontSize,callback: (){

                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "客服中心",textSize: SystemFontSize.settingTextFontSize,callback: (){

                    },),
                ],
              ),
            ),
          ),
          new Offstage(
            offstage: this.tradeDetailHide,
            child: new TradeDetail(HUD: this.widget.HUD,viewCallback: (){
              setState(() {
                tradeDetailHide = true;
                userInfoHide = false;
              });
              this.widget.displayOriginalTitleCallback();
            },),
          )
        ],
      )
    );
  }
}