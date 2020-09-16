import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/detailDialog.dart';
import 'package:upgradegame/Src/pages/main/common/buildingButton.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/trainArmy.dart';
import 'package:upgradegame/Src/provider/baseDialogClickProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class FightPage extends StatefulWidget {
  @override
  _FightPageState createState() => new _FightPageState();
}

class _FightPageState extends State<FightPage> {
  bool mainBuilding = true;
  bool mainBuildingCoin = false;
  double autoProfitSharing = 0.00;
  double perFiveSecondProfit = 0.00;
  Timer adShareTimer;
  Timer productTCoin10;
  Timer productTCoin60;
  Timer deviceIdTimer;
  StreamSubscription stream;
  StreamSubscription notification;
  StreamSubscription systemStatus;

  ProgressHUD _progressHUD;
  bool _loading = false;
  int lastClickTime;

  // bool isFightPage = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: ProvideMulti(
        builder: (context, child, model) {
          BaseUserInfoProvider baseUserInfo = model.get<BaseUserInfoProvider>();
          if (baseUserInfo.tobecollectedcoin > 0) {
            this.mainBuildingCoin = false;
            this.mainBuilding = true;
          } else {
            this.mainBuildingCoin = true;
            this.mainBuilding = false;
          }
          return Stack(
            children: <Widget>[
              new Image(
                image: new AssetImage('resource/images/mainBackground.png'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),

              ///资源栏
              new Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(SystemScreenSize.mainPageSignalBarHeight)),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(0), ScreenUtil().setWidth(20), ScreenUtil().setHeight(0)),
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new ResourceWidget(
                                amount: baseUserInfo.TCoinAmount.toString(),
                                iconSize: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                                imageUrl: "resource/images/coin.png",
                              ),
                              flex: 1,
                            ),
                            new Expanded(
                              child: new ResourceWidget(
                                amount: baseUserInfo.WoodAmount.toString(),
                                iconSize: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                                imageUrl: "resource/images/wood.png",
                              ),
                              flex: 1,
                            ),
                            new Expanded(
                              child: new ResourceWidget(
                                amount: baseUserInfo.StoneAmount.toString(),
                                iconSize: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                                imageUrl: "resource/images/stone.png",
                              ),
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      flex: 7,
                    ),
                    new Expanded(
                      child: new Container(
                        height: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize),
                        child: new Stack(
                          children: <Widget>[
                            new Center(
                              child: Image(
                                image: new AssetImage('resource/images/userInfo.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                            new Center(
                              child: new UserImageButton(
                                size: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize),
                                buttonName: "",
                                textSize: SystemFontSize.operationTextFontSize,
                                imageUrl: "",
                                netWorkImageUrl: baseUserInfo.avatar,
                                netWorkImage: true,
                                callback: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),

              Stack(
                children: [
                  new Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize + SystemScreenSize.mainPageSignalBarHeight)),
                    height: ScreenUtil().setHeight(SystemIconSize.mainPageFunctionBarIconSize),
                    width: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize * 2),
                    child: new GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      children: [
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "排行榜",
                          imageUrl: "resource/images/rank.png",
                          textSize: SystemFontSize.operationTextFontSize,
                          callback: () {
                            if (!Provide.value<BaseDialogClickProvider>(context).hasClickDialog) {
                              Provide.value<BaseDialogClickProvider>(context).setDialogShow();
                              Navigator.push(context, PopWindow(pageBuilder: (context) {
                                return DetailDialog(
                                  height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                  width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                  childWidgetName: 'rankDetail',
                                  title: "排行榜",
                                );
                              }));
                            }
                          },
                        ),
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "消息",
                          textSize: SystemFontSize.operationTextFontSize,
                          imageUrl: "resource/images/team.png",
                          callback: () {
                            if (!Provide.value<BaseDialogClickProvider>(context).hasClickDialog) {
                              Provide.value<BaseDialogClickProvider>(context).setDialogShow();
                              Navigator.push(context, PopWindow(pageBuilder: (context) {
                                return DetailDialog(
                                  height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                  width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                  childWidgetName: 'marketDetail',
                                  title: "消 息",
                                );
                              }));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      ///兵营
                      new Container(
                        height: ScreenUtil().setHeight(650),
                        width: ScreenUtil().setWidth(650),
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(535)), //(1920-650)/2
                        child: BuildingButton(
                          height: ScreenUtil().setHeight(650),
                          width: ScreenUtil().setWidth(650),
                          imageUrl: "resource/images/armyCamp.png",
                          name: '兵 营',
                          namePadding: 450,
                          fontSize: SystemFontSize.mainBuildingTextFontSize,
                          callback: () {
                            if (!Provide.value<BaseDialogClickProvider>(context).hasClickDialog) {
                              Provide.value<BaseDialogClickProvider>(context).setDialogShow();
                              Navigator.push(context, PopWindow(pageBuilder: (context) {
                                return DetailDialog(
                                  height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                  width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                  childWidgetName: 'armyCampDetail',
                                  title: "兵 营",
                                );
                              }));
                            }
                          },
                        ),
                      ),

                      ///训练场
                      new Container(
                        height: ScreenUtil().setHeight(660),
                        width: ScreenUtil().setWidth(660),
                        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(410), ScreenUtil().setHeight(1150), ScreenUtil().setWidth(0), ScreenUtil().setHeight(0)),
                        child: BuildingButton(
                          height: ScreenUtil().setHeight(660),
                          width: ScreenUtil().setWidth(660),
                          imageUrl: "resource/images/trainArmy.png",
                          name: '训练场',
                          namePadding: 450,
                          fontSize: SystemFontSize.mainBuildingTextFontSize,
                          callback: () {
                            if (!Provide.value<BaseDialogClickProvider>(context).hasClickDialog) {
                              Provide.value<BaseDialogClickProvider>(context).setDialogShow();
                              Navigator.push(context, PopWindow(pageBuilder: (context) {
                                return TrainArmyDetail();
                              }));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ///战 斗
              Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(1670), ScreenUtil().setWidth(770), ScreenUtil().setHeight(0)),
                child: BuildingButton(
                  height: ScreenUtil().setHeight(250),
                  width: ScreenUtil().setWidth(250),
                  imageUrl: "resource/images/fightButtonBack.png",
                  name: "返 回",
                  fontSize: SystemFontSize.otherBuildingTextFontSize,
                  namePadding: 100,
                  callback: () {
                    /// 防止重复点击
                    if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
                      Provide.value<BaseDialogClickProvider>(context).setDialogHide();
                      Application.router.pop(context);
                      this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                    }
                  },
                ),
              ),
              _progressHUD
            ],
          );
        },
        requestedValues: [BaseUserInfoProvider],
      ),
    );
  }
}
