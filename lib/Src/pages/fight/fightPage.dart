import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/detailDialog.dart';
import 'package:upgradegame/Src/pages/fight/service/fightService.dart';
import 'package:upgradegame/Src/pages/main/common/buildingButton.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/trainArmy.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class FightPage extends StatefulWidget {
  @override
  _FightPageState createState() => new _FightPageState();
}

class _FightPageState extends State<FightPage> {
  // bool mainBuilding = true;
  // bool mainBuildingCoin = false;
  // double autoProfitSharing = 0.00;
  // double perFiveSecondProfit = 0.00;
  // Timer adShareTimer;
  // Timer productTCoin10;
  // Timer productTCoin60;
  // Timer deviceIdTimer;
  // StreamSubscription stream;
  // StreamSubscription notification;
  // StreamSubscription systemStatus;

  ProgressHUD _progressHUD;
  bool _loading = false;
  int lastClickTime;

  @override
  void initState() {
    super.initState();
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.initFightInfo();
    });
  }

  void initFightInfo() {
    this.showOrDismissProgressHUD();
    FightService.getFightInfo((model) {
      this.showOrDismissProgressHUD();
      if (model != null) {
        Provide.value<BaseFightLineupProvider>(context).initSupplies(model);
        Provide.value<BaseFightLineupProvider>(context).initLiuneupProvider(model);
        if (model.protectlineup == "") {
          CommonUtils.showWarningMessage(msg: "您还没设置防守阵容,为了不造成不必要的损失,请设置防守整容");
        }
      }
    });
  }

  void showOrDismissProgressHUD() {
    setState(() {
      if (_loading) {
        _progressHUD.state.dismiss();
      } else {
        _progressHUD.state.show();
      }

      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: ProvideMulti(
        builder: (context, child, model) {
          BaseUserInfoProvider baseUserInfo = model.get<BaseUserInfoProvider>();
          BaseFightLineupProvider baseFightInfo = model.get<BaseFightLineupProvider>();
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
                    height: ScreenUtil().setHeight(SystemIconSize.mainPageFunctionBarIconSize * 2 + 50),
                    width: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize * 5),
                    child: new GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      children: [
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "排行榜",
                          imageUrl: "resource/images/rank.png",
                          textSize: SystemFontSize.operationTextFontSize,
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return DetailDialog(
                                height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                childWidgetName: 'fightRankDetail',
                                title: "排行榜",
                              );
                            }));
                          },
                        ),
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "消息",
                          textSize: SystemFontSize.operationTextFontSize,
                          imageUrl: "resource/images/message.png",
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return DetailDialog(
                                height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                childWidgetName: 'messageDetail',
                                title: "消 息",
                              );
                            }));
                          },
                        ),
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "商城",
                          imageUrl: "resource/images/rank.png",
                          textSize: SystemFontSize.operationTextFontSize,
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return DetailDialog(
                                height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                childWidgetName: 'storeDetail',
                                title: "商 城",
                              );
                            }));
                          },
                        ),
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "回收",
                          textSize: SystemFontSize.operationTextFontSize,
                          imageUrl: "resource/images/recycle.png",
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return DetailDialog(
                                height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                childWidgetName: 'recycleDetail',
                                title: "回 收",
                              );
                            }));
                          },
                        ),
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "必读",
                          textSize: SystemFontSize.operationTextFontSize,
                          imageUrl: "resource/images/mustReadFightPage.png",
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return DetailDialog(
                                height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                childWidgetName: 'fightRaidersDetail',
                                title: "必 读",
                              );
                            }));
                          },
                        ),
                        new UserImageButton(
                          size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          buttonName: "刷新",
                          textSize: SystemFontSize.operationTextFontSize,
                          imageUrl: "resource/images/refresh.png",
                          callback: () {
                            this.initFightInfo();
                          },
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(810), ScreenUtil().setHeight(210), ScreenUtil().setWidth(0), ScreenUtil().setHeight(0)),
                    width: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarSmallIconSize * 3),
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        new Image(
                          image: new AssetImage("resource/images/volume.png"),
                          width: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarSmallIconSize),
                          height: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                        ),
                        new Text(
                          (null == baseFightInfo.supplies ? '' : baseFightInfo.supplies).toString(),
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      ///兵营
                      new Container(
                        height: ScreenUtil().setHeight(550),
                        width: ScreenUtil().setWidth(550),
                        margin: EdgeInsets.only(top: ScreenUtil().setHeight(550)), //(1920-650)/2
                        child: BuildingButton(
                          height: ScreenUtil().setHeight(450),
                          width: ScreenUtil().setWidth(450),
                          imageUrl: "resource/images/armyCamp.png",
                          name: '兵 营',
                          namePadding: 320,
                          fontSize: SystemFontSize.mainBuildingTextFontSize,
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return DetailDialog(
                                height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                childWidgetName: 'armyCampDetail',
                                title: "兵 营",
                              );
                            }));
                          },
                        ),
                      ),

                      ///训练场
                      new Container(
                        height: ScreenUtil().setHeight(500),
                        width: ScreenUtil().setWidth(560),
                        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(410), ScreenUtil().setHeight(940), ScreenUtil().setWidth(0), ScreenUtil().setHeight(0)),
                        child: BuildingButton(
                          height: ScreenUtil().setHeight(400),
                          width: ScreenUtil().setWidth(460),
                          imageUrl: "resource/images/trainArmy.png",
                          name: '训练场',
                          namePadding: 350,
                          fontSize: SystemFontSize.mainBuildingTextFontSize,
                          callback: () {
                            Navigator.push(context, PopWindow(pageBuilder: (context) {
                              return TrainArmyDetail(
                                HUD: this.showOrDismissProgressHUD,
                              );
                            }));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ///返 回
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
                      Application.router.pop(context);
                      this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                      baseFightInfo.clearData();
                    }
                  },
                ),
              ),
              _progressHUD
            ],
          );
        },
        requestedValues: [BaseUserInfoProvider, BaseFightLineupProvider],
      ),
    );
  }
}
