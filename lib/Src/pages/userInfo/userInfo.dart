import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/userInfo/withDraw.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/userInfo/userResourceDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/account/account.dart';
import 'package:upgradegame/Src/pages/userInfo/withdraw/withdrawDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/tcoinDetail/tcoinDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/serverCenter/serverCenterDetail.dart';

class UserInfoDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  final changeTitleCallback;
  VoidCallback displayOriginalTitleCallback;

  UserInfoDetail({Key key,this.HUD,this.changeTitleCallback,this.displayOriginalTitleCallback}):super(key:key);
  _UserInfoDetailState createState() => new _UserInfoDetailState();
}

class _UserInfoDetailState extends State<UserInfoDetail> {

  bool userInfoHide = false;
  String buttonName = '';

  switchPageBetweenFatherAndSon({String sonPageName}) {
    setState(() {
      // 子界面名称
      buttonName = sonPageName;
      // 父界面是否隐藏
      userInfoHide = (null != sonPageName && '' != sonPageName);
    });
  }
  bool tradeDetailHide = true;
  bool accountDetailHide = true;
  bool tCoinDetailHide = true;
  bool withdrawHide = true;//提现记录
  bool serverCenter = true;
  bool withdraw = true;   //提现

  void showUserInfoDetail(){
    setState(() {
      userInfoHide = false;
      tradeDetailHide = true;
      accountDetailHide = true;
      tCoinDetailHide = true;
      withdrawHide = true;
      serverCenter = true;
      withdraw = true;

    });
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
                    withdrawCallback: (){
                      setState(() {
                        userInfoHide = true;
                        withdraw = false;
                      });
                      this.widget.changeTitleCallback("提 现");
                    },
                  ),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "账号及安全",textSize: SystemFontSize.settingTextFontSize,callback: (){

                      setState(() {
                        userInfoHide = true;
                        accountDetailHide = false;
                      });
                      switchPageBetweenFatherAndSon(sonPageName: "账号及安全");
                      this.widget.changeTitleCallback("账号及安全");
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

                      setState(() {
                        userInfoHide = true;
                        withdrawHide = false;
                      });
                      this.widget.changeTitleCallback("提现记录");
                    },),
                  new ImageTextButton(imageUrl: "resource/images/settingButtonBackground.png",imageWidth: ScreenUtil().setWidth(900),imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "客服中心",textSize: SystemFontSize.settingTextFontSize,callback: (){
                      setState(() {
                        userInfoHide = true;
                        serverCenter = false;
                      });
                      this.widget.changeTitleCallback("客服中心");
                    },),
                ],
              ),
            ),
          ),
          ///账号及安全
          new Offstage(
            offstage: this.accountDetailHide,
            child: new AccountDetail(HUD: this.widget.HUD,viewCallback: (){
              showUserInfoDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          ///交易明细
          new Offstage(
            offstage: this.tradeDetailHide,
            child: new TradeDetail(HUD: this.widget.HUD,viewCallback: (){
              showUserInfoDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          ///提现明细
          new Offstage(
            offstage: this.withdrawHide,
            child: new WithDrawDetail(HUD: this.widget.HUD,viewCallback: (){
              showUserInfoDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          ///t币明细
          new Offstage(
            offstage: this.tCoinDetailHide,
            child: new TCoinDetail(HUD: this.widget.HUD,viewCallback: (){
              showUserInfoDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          ///客服中心
          new Offstage(
            offstage: this.serverCenter,
            child: new ServerCenter(HUD: this.widget.HUD,viewCallback: (){
              showUserInfoDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
          ///提现
          new Offstage(
            offstage: this.withdraw,
            child: new Withdraw(HUD: this.widget.HUD,viewCallback: (){
              showUserInfoDetail();
              this.widget.displayOriginalTitleCallback();
            },),
          ),
        ],
      )
    );
  }
}