import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Src/pages/userInfo/withDraw.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/userInfo/userResourceDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/account/account.dart';
import 'package:upgradegame/Src/pages/userInfo/withdraw/withdrawDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/serverCenter/serverCenterDetail.dart';

class UserInfoDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  final changeTitleCallback;
  VoidCallback displayOriginalTitleCallback;

  UserInfoDetail({Key key, this.HUD, this.changeTitleCallback, this.displayOriginalTitleCallback}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(80), // 左
            ScreenUtil().setHeight(280), // 上
            ScreenUtil().setWidth(80), // 右
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
                      withdrawCallback: () {
                        switchPageBetweenFatherAndSon(sonPageName: "提现");
                        this.widget.changeTitleCallback("提 现");
                      },
                    ),
                    ButtonsList(
                      buttonWidth: ScreenUtil().setWidth(900),
                      buttonHeight: ScreenUtil().setHeight(190),
                      buttonBackgroundImageUrl: 'resource/images/settingButtonBackground.png',
                      textSize: SystemFontSize.settingTextFontSize,
                      isColumn: true,
                      buttons: [
                        ImageTextButton(
                          buttonName: '账号及安全',
                          callback: () {
                            switchPageBetweenFatherAndSon(sonPageName: "账号及安全");
                            this.widget.changeTitleCallback("账号及安全");
                          },
                        ),
                        ImageTextButton(
                          buttonName: '交易明细',
                          callback: () {
                            switchPageBetweenFatherAndSon(sonPageName: "交易明细");
                            this.widget.changeTitleCallback("交易明细");
                          },
                        ),
                        ImageTextButton(
                          buttonName: '提现记录',
                          callback: () {
                            switchPageBetweenFatherAndSon(sonPageName: "提现记录");
                            this.widget.changeTitleCallback("提现记录");
                          },
                        ),
                        ImageTextButton(
                          buttonName: '客服中心',
                          callback: () {
                            switchPageBetweenFatherAndSon(sonPageName: "客服中心");
                            this.widget.changeTitleCallback("客服中心");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            ///账号及安全
            new Offstage(
              offstage: "账号及安全" != buttonName,
              child: new AccountDetail(
                HUD: this.widget.HUD,
                viewCallback: () {
                  switchPageBetweenFatherAndSon();
                  this.widget.displayOriginalTitleCallback();
                },
              ),
            ),

            ///交易明细
            new Offstage(
              offstage: "交易明细" != buttonName,
              child: new TradeDetail(
                HUD: this.widget.HUD,
                viewCallback: () {
                  switchPageBetweenFatherAndSon();
                  this.widget.displayOriginalTitleCallback();
                },
              ),
            ),

            ///提现明细
            new Offstage(
              offstage: "提现记录" != buttonName,
              child: new WithDrawDetail(
                HUD: this.widget.HUD,
                viewCallback: () {
                  switchPageBetweenFatherAndSon();
                  this.widget.displayOriginalTitleCallback();
                },
              ),
            ),
//          ///t币明细
//          new Offstage(
//            offstage: "账号及安全"!=buttonName,
//            child: new TCoinDetail(HUD: this.widget.HUD,viewCallback: (){
//              showUserInfoDetail();
//              this.widget.displayOriginalTitleCallback();
//            },),
//          ),
            ///客服中心
            new Offstage(
              offstage: "客服中心" != buttonName,
              child: new ServerCenter(
                HUD: this.widget.HUD,
                viewCallback: () {
                  switchPageBetweenFatherAndSon();
                  this.widget.displayOriginalTitleCallback();
                },
              ),
            ),
            ///提现
            new Offstage(
              offstage: "提现" != buttonName,
              child: new Withdraw(
                HUD: this.widget.HUD,
                viewCallback: () {
                  switchPageBetweenFatherAndSon();
                  this.widget.displayOriginalTitleCallback();
                },

              ),
            ),
          ],
        ));
  }
}
