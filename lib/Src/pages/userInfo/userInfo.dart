import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/event/userInfoEventBus.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashInfoModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/pages/userInfo/withDraw.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/userInfo/userResourceDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/account/account.dart';
import 'package:upgradegame/Src/pages/userInfo/withdraw/withdrawDetail.dart';
import 'package:upgradegame/Src/pages/userInfo/serverCenter/serverCenterDetail.dart';
import 'package:upgradegame/Src/provider/baseUserCashProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

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

  getUserCashInfo() {
    this.widget.HUD();
    UserInfoService.getUserCashInfo((CashInfoModel model) {
      this.widget.HUD();
      if (model != null) {
        Provide.value<BaseUserCashProvider>(context).initUserCashProvider(model);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    UserInfoHttpRequestEvent().off();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfoHttpRequestEvent();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.getUserCashInfo();
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
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Provide<BaseUserCashProvider>(builder: (context, child, cashInfo) {
          return Stack(
            children: <Widget>[
              new Offstage(
                offstage: this.userInfoHide,
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new UserResourceDetail(
//                        imageUrl: "resource/images/defaultAvatar.png",
                        imageUrl: baseUserInfo.avatar,
                        amountCash: cashInfo.cashAmount == null ? "0" : cashInfo.cashAmount.toString(),
                        withdrawCallback: () {
                          if (!cashInfo.hasWithdraw) {
                            switchPageBetweenFatherAndSon(sonPageName: "提现");
                            this.widget.changeTitleCallback("提 现");
                          } else {
                            CommonUtils.showWarningMessage(msg: "你已经发起了提现操作,若要取消操作请在客服中心联系管理员");
                          }
                        },
                      ),
                      ButtonsList(
                        buttonWidth: ScreenUtil().setWidth(900),
                        buttonHeight: ScreenUtil().setHeight(190),
                        buttonBackgroundImageUrl: 'resource/images/settingButtonBackground.png',
                        textSize: SystemFontSize.settingTextFontSize,
                        isColumn: true,
                        buttons: [
//                        ImageTextButton(
//                          buttonName: '账号及安全',
//                          callback: () {
//                            switchPageBetweenFatherAndSon(sonPageName: "账号及安全");
//                            this.widget.changeTitleCallback("账号及安全");
//                          },
//                        ),
                          ImageTextButton(
                            buttonName: 'T币明细',
                            callback: () {
                              switchPageBetweenFatherAndSon(sonPageName: "T币明细");
                              this.widget.changeTitleCallback("T币明细");
                              UserInfoHttpRequestEvent().emit("tcoinDetail");
                            },
                          ),
                          ImageTextButton(
                            buttonName: '现金记录',
                            callback: () {
                              switchPageBetweenFatherAndSon(sonPageName: "现金记录");
                              this.widget.changeTitleCallback("现金记录");
                              UserInfoHttpRequestEvent().emit("withdrawDetail");
                            },
                          ),
                          ImageTextButton(
                            buttonName: '客服中心',
                            callback: () {
                              switchPageBetweenFatherAndSon(sonPageName: "客服中心");
                              this.widget.changeTitleCallback("客服中心");
                              UserInfoHttpRequestEvent().emit("serverCenter");
                            },
                          ),
                          ImageTextButton(
                            buttonName: '退出登录',
                            callback: () {
                              UserInfoService.logout((bool success) {
                                if (success) {
                                  Application.router.navigateTo(context, UpgradeGameRoute.loginPage, clearStack: true);
                                }
                              });
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

              ///T币明细
              new Offstage(
                offstage: "T币明细" != buttonName,
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
                offstage: "现金记录" != buttonName,
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
          );
        });
      }),
    );
  }
}
