import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/app/notificationEvent.dart';
import 'package:upgradegame/Common/event/errorEvent.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/model/globalSystemStatuesControl.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adTimer.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/detailDialog.dart';
import 'package:upgradegame/Src/pages/fight/fightPage.dart';
import 'package:upgradegame/Src/pages/main/common/buildingButton.dart';
import 'package:upgradegame/Src/pages/main/common/dividendPart.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/main/model/requestGetCoinModel.dart';
import 'package:upgradegame/Src/pages/main/model/takeCoinModel.dart';
import 'package:upgradegame/Src/pages/main/service/mainService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  displayInitProfitSharing() {
    ///当前时间戳
    int time = DateTime.now().millisecondsSinceEpoch;

    ///零点时间戳
    int zeroTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch;
    String profitSharing = Provide.value<BaseUserInfoProvider>(context).Todayprofitsharing;

    ///要将分红分成17280份  5秒为一份
    if (perFiveSecondProfit != "0") {
      perFiveSecondProfit = double.parse(profitSharing) / 17280;
    } else {
      perFiveSecondProfit = 0;
    }

//    int dTime = time - zeroTime;
    int dPer = int.parse(((time - zeroTime) / 5000).toStringAsFixed(0));

    ///保留两位小数
    autoProfitSharing = dPer * perFiveSecondProfit;
    return autoProfitSharing.toStringAsFixed(2);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///初始化在0-5分钟的时候前台自动去生成t币，并且请求后台进行计算
    RequestGetCoinModel();
    RequestGetCoinModel.setIfNeedCoin(true);
    AdTimer();
    GlobalSystemStatuesControl();

    ///初始化广告数据库
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdTimer.initCurrentDatabase(Provide.value<BaseUserInfoProvider>(context).displayname);
    });

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );

    ///获取401的监听
    stream = ConfigSetting.eventBus.on<HttpErrorEvent>().listen((event) {
      this.errorHandleFunction(event.code, event.message);
    });

    ///收到通知的监听
    notification = NotificationEvent().eventBus.on<RecieveNotificationEvent>().listen((message) {
//      Map<String, dynamic> model = convert.jsonDecode(message.message['extras']['cn.jpush.android.EXTRA']);
//      print(model);
    });

    systemStatus = GlobalSystemStatuesControl.instance.eventBus.on<SystemStatus>().listen((status) {
      if (status.active) {
        displayInitProfitSharing();
        this.startTimerProcess();
      } else {
        this.killAllTimer();
      }
    });

    ///后台绑定用户和极光的registerid
    this.deviceIdTimer = Timer.periodic(Duration(seconds: 20), (timer) {
      if (NotificationEvent().deviceId != "") {
        MainService.bindDeviceId(NotificationEvent().deviceId, (bool success) {
          if (success) {
            this.deviceIdTimer.cancel();
            this.deviceIdTimer = null;
          }
        });
      }
    });

    this.startTimerProcess();
  }

  void startTimerProcess() {
    ///每5秒更改一次广告分红  要将分红分成17280份
    this.adShareTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      ///当前时间戳
      setState(() {
        autoProfitSharing += perFiveSecondProfit;
      });
    });

    ///系统自动判断是否需要产生t币
    this.productTCoin10 = Timer.periodic(Duration(seconds: 30), (timer) {
      int timeMinute = DateTime.now().minute;

      /// 前九分钟  userinfo请求 获取用户最新的资源动态
      if (timeMinute >= 0 && timeMinute <= 5 && RequestGetCoinModel().ifNeedGetCoin) {
        int level = Provide.value<BaseUserInfoProvider>(context).Mainbuildlevel;

        int currentStoneAmount = Provide.value<BaseUserInfoProvider>(context).stoneamount;
        int currentWoodAmount = Provide.value<BaseUserInfoProvider>(context).woodamount;

        ///升级建筑规则
        Mainbuild mainBuildRule = Global.getMainBuildingRule()[level - 1];

        if (currentStoneAmount > mainBuildRule.consumestone && currentWoodAmount > mainBuildRule.woodamount) {
          MainService.requestBackendProductCoin((model) {
            Provide.value<BaseUserInfoProvider>(context).backendProductTCoin(model);
            RequestGetCoinModel.setIfNeedCoin(false);
          });
        }
      }
      if (timeMinute >= 58) {
        RequestGetCoinModel.setIfNeedCoin(true);
      }
    });

    this.productTCoin60 = Timer.periodic(Duration(seconds: 60), (timer) {
      int timeMinute = DateTime.now().minute;

      /// 3分钟进行一次 userinfo请求 获取用户最新的资源动态
      if (timeMinute % 3 == 0) {
        MainService.getBaseInfo((userInfoModel) {
          Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(userInfoModel);
        });
      }
    });
  }

  void handleLoginFailed() {
    CommonUtils.showSystemErrorMessage(msg: '账号在其他设备登录 \\ 授权登录失败 \\ 登录过期');
    MainService.localLogout((bool success) {
      Application.router.navigateTo(context, UpgradeGameRoute.loginPage, clearStack: true);
    });
  }

  ///网络错误
  void errorHandleFunction(int code, message) {
    switch (code) {
      case 401:
        this.handleLoginFailed();
        break;
    }
  }

  void killAllTimer() {
    if (this.adShareTimer != null) {
      this.adShareTimer.cancel();
    }

    if (this.productTCoin10 != null) {
      this.productTCoin10.cancel();
    }

    if (this.productTCoin60 != null) {
      this.productTCoin60.cancel();
    }
    if (this.deviceIdTimer != null) {
      this.deviceIdTimer.cancel();
    }
  }

  @override
  void dispose() {
    super.dispose();
    this.killAllTimer();
    stream.cancel();
    stream = null;
    systemStatus.cancel();
    systemStatus = null;
    notification.cancel();
    notification = null;
  }

  void setMainBuildingNormal() {
    setState(() {
      this.mainBuilding = false;
      this.mainBuildingCoin = true;
    });
  }

  void setMainBuildingCoin() {
    setState(() {
      this.mainBuildingCoin = false;
      this.mainBuilding = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                                callback: () {
                                  Navigator.push(context, PopWindow(pageBuilder: (context) {
                                    return DetailDialog(
                                        height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                        width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                        childWidgetName: 'userInfoDetail',
                                        title: "个人信息");
                                  }));
                                },
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
                  ///功能栏
                  new Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize + SystemScreenSize.mainPageSignalBarHeight)),
                    height: ScreenUtil().setHeight(SystemIconSize.mainPageFunctionBarIconSize * 3),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Container(
                          width: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize * 3),
                          child: new GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            crossAxisCount: 3,
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
                                      childWidgetName: 'rankDetail',
                                      title: "排行榜",
                                    );
                                  }));
                                },
                              ),
                              new UserImageButton(
                                size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                                buttonName: "团队",
                                textSize: SystemFontSize.operationTextFontSize,
                                imageUrl: "resource/images/team.png",
                                callback: () {
                                  Navigator.push(context, PopWindow(pageBuilder: (context) {
                                    return DetailDialog(
                                      height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                      width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                      childWidgetName: 'teamDetail',
                                      title: "团 队",
                                    );
                                  }));
                                },
                              ),
                              new UserImageButton(
                                size: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                                buttonName: "贡献值",
                                imageUrl: "resource/images/contribution.png",
                                textSize: SystemFontSize.operationTextFontSize,
                                callback: () {
                                  Navigator.push(context, PopWindow(pageBuilder: (context) {
                                    return DetailDialog(
                                      height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                      width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                      childWidgetName: 'contributionDetail',
                                      title: "贡献值",
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
                                  this.showOrDismissProgressHUD();
                                  MainService.getBaseInfo((userInfoModel) {
                                    this.showOrDismissProgressHUD();
                                    Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(userInfoModel);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          height: ScreenUtil().setWidth(SystemIconSize.mainPageFunctionBarIconSize),
                          child: new DividendPart(
                            imageTitle: "分红",
                            imageUrl: "resource/images/dividend.png",
                            imageHeight: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize),
                            imageWidth: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                            title: "今日分红",
                            amount: "¥" + (autoProfitSharing == 0.00 ? this.displayInitProfitSharing() : autoProfitSharing.toStringAsFixed(2)),
                            callback: () {
                              Navigator.push(context, PopWindow(pageBuilder: (context) {
                                return DetailDialog(
                                  height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                  width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                  childWidgetName: 'adDividendDetail',
                                  title: "广告分红",
                                );
                              }));
                            },
                          ),
                        ),
                        new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              new Row(
                                children: <Widget>[
                                  new UserImageButton(
                                    size: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                                    buttonName: "必读",
                                    textSize: SystemFontSize.operationTextFontSize,
                                    imageUrl: "resource/images/setting.png",
                                    callback: () {
                                      Navigator.push(context, PopWindow(pageBuilder: (context) {
                                        return DetailDialog(
                                          height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                          width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                          childWidgetName: 'settingDetail',
                                          title: "必 读",
                                        );
                                      }));
                                    },
                                  ),
                                  new UserImageButton(
                                    size: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                                    buttonName: "公告",
                                    textSize: SystemFontSize.operationTextFontSize,
                                    imageUrl: "resource/images/announcement.png",
                                    callback: () {
                                      Navigator.push(context, PopWindow(pageBuilder: (context) {
                                        return DetailDialog(
                                          height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                          width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                          childWidgetName: 'announcementDetail',
                                          title: "公 告",
                                        );
                                      }));
                                    },
                                  ),
                                ],
                              ),
                              new UserImageButton(
                                size: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                                buttonName: "活动",
                                textSize: SystemFontSize.operationTextFontSize,
                                imageUrl: "resource/images/activity.png",
                                callback: () {
                                  Navigator.push(context, PopWindow(pageBuilder: (context) {
                                    return DetailDialog(
                                      height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                                      width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                                      childWidgetName: 'activityDetail',
                                      title: "活 动",
                                    );
                                  }));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///主城
                  new Offstage(
                    offstage: this.mainBuilding,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(330), ScreenUtil().setHeight(660), ScreenUtil().setWidth(170), ScreenUtil().setHeight(670)),
                      child: BuildingButton(
                        height: ScreenUtil().setHeight(630),
                        width: ScreenUtil().setWidth(600),
                        imageUrl: "resource/images/mainBuilding.png",
                        name: '主 城',
                        namePadding: 420,
                        fontSize: SystemFontSize.mainBuildingTextFontSize,
                        callback: () {
                          Navigator.push(context, PopWindow(pageBuilder: (context) {
                            return DetailDialog(
                              height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                              width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                              childWidgetName: 'mainBuildingDetail',
                              title: "主 城",
                            );
                          }));
                        },
                      ),
                    ),
                  ),

                  ///主城金币点击
                  new Offstage(
                    offstage: this.mainBuildingCoin,
                    child: new Container(
                      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(330), ScreenUtil().setHeight(660), ScreenUtil().setWidth(170), ScreenUtil().setHeight(670)),
                      child: BuildingButton(
                        height: ScreenUtil().setHeight(630),
                        width: ScreenUtil().setWidth(600),
                        imageUrl: "resource/images/mainBuildingCoin.png",
                        name: '主 城',
                        namePadding: 420,
                        fontSize: SystemFontSize.mainBuildingTextFontSize,
                        callback: () {
                          this.showOrDismissProgressHUD();
                          MainService.takeCoin((TakeCoinModel model) {
                            this.showOrDismissProgressHUD();
                            baseUserInfo.takeCoin(model.tcoinamount, model.woodamount, model.stoneamount);
                          });
                        },
                      ),
                    ),
                  ),

                  ///英雄祭坛
                  new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(590), ScreenUtil().setHeight(1250), ScreenUtil().setWidth(170), ScreenUtil().setHeight(360)),
                    child: BuildingButton(
                      height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                      width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                      imageUrl: "resource/images/heroesBuilding.png",
                      name: '英雄祭坛',
                      namePadding: 200,
                      fontSize: SystemFontSize.otherBuildingTextFontSize,
                      callback: () {
                        Navigator.push(context, PopWindow(pageBuilder: (context) {
                          return DetailDialog(
                            height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                            width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                            childWidgetName: 'heroAltar',
                            title: "英雄祭坛",
                          );
                        }));
                      },
                    ),
                  ),

                  ///采石场
                  new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(590), ScreenUtil().setHeight(1550), ScreenUtil().setWidth(170), ScreenUtil().setHeight(80)),
                    child: BuildingButton(
                      height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                      width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                      imageUrl: "resource/images/stoneBuilding.png",
                      name: '采石场',
                      namePadding: 200,
                      fontSize: SystemFontSize.otherBuildingTextFontSize,
                      callback: () {
                        Navigator.push(context, PopWindow(pageBuilder: (context) {
                          return DetailDialog(
                            height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                            width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                            childWidgetName: 'stoneDetail',
                            title: "采石场",
                          );
                        }));
                      },
                    ),
                  ),

                  ///伐木场
                  new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(1330), ScreenUtil().setWidth(700), ScreenUtil().setHeight(300)),
                    child: BuildingButton(
                      height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                      width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                      imageUrl: "resource/images/fellingBuilding.png",
                      name: '伐木场',
                      namePadding: 190,
                      fontSize: SystemFontSize.otherBuildingTextFontSize,
                      callback: () {
                        Navigator.push(context, PopWindow(pageBuilder: (context) {
                          return DetailDialog(
                            height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                            width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                            childWidgetName: 'sawmillDetail',
                            title: "伐木场",
                          );
                        }));
                      },
                    ),
                  ),

                  ///农场
                  new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(980), ScreenUtil().setWidth(680), ScreenUtil().setHeight(630)),
                    child: BuildingButton(
                      height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                      width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                      imageUrl: "resource/images/farmBuilding.png",
                      name: '农 场',
                      namePadding: 190,
                      fontSize: SystemFontSize.otherBuildingTextFontSize,
                      callback: () {
                        Navigator.push(context, PopWindow(pageBuilder: (context) {
                          return DetailDialog(
                            height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                            width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                            childWidgetName: 'farmDetail',
                            title: "农 场",
                          );
                        }));
                      },
                    ),
                  ),

                  ///市场
                  new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(620), ScreenUtil().setWidth(680), ScreenUtil().setHeight(990)),
                    child: BuildingButton(
                      height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                      width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                      imageUrl: "resource/images/marketBuilding.png",
                      name: '市 场',
                      fontSize: SystemFontSize.otherBuildingTextFontSize,
                      namePadding: 170,
                      callback: () {
                        Navigator.push(context, PopWindow(pageBuilder: (context) {
                          return DetailDialog(
                            height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
                            width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                            childWidgetName: 'marketDetail',
                            title: "市 场",
                          );
                        }));
                      },
                    ),
                  ),
                ],
              ),

              ///战 斗
              Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(1670), ScreenUtil().setWidth(770), ScreenUtil().setHeight(0)),
                child: BuildingButton(
                  height: ScreenUtil().setHeight(250),
                  width: ScreenUtil().setWidth(250),
                  imageUrl: "resource/images/fightButton.png",
                  name: "战 斗",
                  fontSize: SystemFontSize.otherBuildingTextFontSize,
                  namePadding: 100,
                  callback: () {
                    Navigator.push(context, PopWindow(pageBuilder: (context) {
                      return FightPage();
                    }));
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
