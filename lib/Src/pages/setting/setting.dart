import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/setting/raiders/raiders.dart';
import 'package:upgradegame/Src/pages/setting/protocol/protocol.dart';
import 'package:upgradegame/Src/pages/setting/private/private.dart';
import 'package:upgradegame/Src/pages/setting/aboutUs/aboutUs.dart';

class SettingDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  final changeTitleCallback;
  VoidCallback displayOriginalTitleCallback;
  SettingDetail({Key key,this.HUD,this.changeTitleCallback,this.displayOriginalTitleCallback}):super(key:key);
  _SettingDetailState createState() => new _SettingDetailState();
}

class _SettingDetailState extends State<SettingDetail> {

  bool settingHide = false;
  bool raidersHide = true;
  bool protocolHide = true;
  bool privateHide = true;
  bool aboutUsHide = true;

  void showSettingDetail(){
    setState(() {
      settingHide = false;
      raidersHide = true;
      protocolHide = true;
      privateHide = true;
      aboutUsHide = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(280),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(100)), // 下
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage:this.settingHide,
            child:  new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "攻 略",textSize: SystemFontSize.settingTextFontSize,callback: (){

                      setState(() {
                        settingHide = true;
                        raidersHide = false;
                      });
                      this.widget.changeTitleCallback("攻略");
                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "用户协议",textSize: SystemFontSize.settingTextFontSize,callback: (){
                      setState(() {
                        settingHide = true;
                        protocolHide = false;
                      });
                      this.widget.changeTitleCallback("用户协议");
                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "隐私条款",textSize: SystemFontSize.settingTextFontSize,callback: (){
                      setState(() {
                        settingHide = true;
                        privateHide = false;
                      });
                      this.widget.changeTitleCallback("隐私条款");
                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "关于我们",textSize: SystemFontSize.settingTextFontSize,callback: (){
                      setState(() {
                        settingHide = true;
                        aboutUsHide = false;
                      });
                      this.widget.changeTitleCallback("关于我们");
                    },),
                ],
              ),
            ),
          ),
          new Offstage(
            offstage: this.raidersHide,
            child: new RaidersDetail(HUD: this.widget.HUD,viewCallback: (){
              showSettingDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          new Offstage(
            offstage: this.protocolHide,
            child: new ProtocolDetail(HUD: this.widget.HUD,viewCallback: (){
              showSettingDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          new Offstage(
            offstage: this.privateHide,
            child: new PrivateDetail(HUD: this.widget.HUD,viewCallback: (){
              showSettingDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          new Offstage(
            offstage: this.aboutUsHide,
            child: new AboutUsDetail(HUD: this.widget.HUD,viewCallback: (){
              showSettingDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
        ],
      ),
    );
  }
}