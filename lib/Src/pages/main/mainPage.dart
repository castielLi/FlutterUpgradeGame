//import 'dart:html';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/main/model/takeCoinModel.dart';
import 'package:upgradegame/Src/pages/main/service/mainService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/main/common/dividendPart.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:upgradegame/Common/event/errorEvent.dart';
import 'package:upgradegame/Common/http/configSetting.dart';

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
  StreamSubscription stream;


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

    int dTime = time - zeroTime;
    int dPer = int.parse(((time - zeroTime) / 5000).toStringAsFixed(0));

    ///保留两位小数
    autoProfitSharing = dPer * perFiveSecondProfit;
    return autoProfitSharing.toStringAsFixed(2);
  }

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

    stream = ConfigSetting.eventBus.on<HttpErrorEvent>().listen((event) {
      this.errorHandleFunction(event.code, event.message);
    });

    ///每5秒更改一次广告分红  要将分红分成17280份
    this.adShareTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      ///当前时间戳
      setState(() {
        autoProfitSharing += perFiveSecondProfit;
      });
    });

    ///系统自动判断是否需要产生t币
    this.productTCoin10 = Timer.periodic(Duration(seconds: 10), (timer) {
      int timeMinute = DateTime.now().minute;

      /// 前九分钟  userinfo请求 获取用户最新的资源动态
      if (timeMinute >= 0 && timeMinute <= 9) {
        MainService.getBaseInfo((userInfoModel) {
          Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(userInfoModel);
        });
      }
    });

    this.productTCoin60 = Timer.periodic(Duration(seconds: 60), (timer) {
      int timeMinute = DateTime.now().minute;

      /// 十分钟进行一次 userinfo请求 获取用户最新的资源动态
      if (timeMinute >= 10 && (timeMinute % 10 == 0)) {
        MainService.getBaseInfo((userInfoModel) {
          Provide.value<BaseUserInfoProvider>(context).initBaseUserInfo(userInfoModel);
        });
      }
    });
  }

  void handleLoginFailed(){
    CommonUtils.showSystemErrorMessage(
        msg: '账号在其他设备登录 \\ 授权登录失败 \\ 登录过期');
    Application.router.navigateTo(context, UpgradeGameRoute.loginPage,clearStack: true);
  }

  ///网络错误
  void errorHandleFunction(int code, message) {
    switch (code) {
      case 401:
        this.handleLoginFailed();
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(this.adShareTimer != null){
      this.adShareTimer.cancel();
    }

    if(this.productTCoin10 != null){
      this.productTCoin10.cancel();
    }

    if(this.productTCoin60 != null){
      this.productTCoin60.cancel();
    }
    stream.cancel();
    stream = null;
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
                image: new AssetImage('resource/images/mainBackgroud.png'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),

              ///资源栏
              new Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(SystemIconSize.mainPageSignalBarHeight)),
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
                                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                                      params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'userInfoDetail', "title": "个人信息"});
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 2,
                    )
                  ],
                ),
              ),

              ///功能栏
              new Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize + SystemIconSize.mainPageSignalBarHeight)),
                height: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize * 2),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        children: <Widget>[
                          new UserImageButton(
                            size: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarIconSize),
                            buttonName: "排行榜",
                            imageUrl: "resource/images/rank.png",
                            textSize: SystemFontSize.operationTextFontSize,
                            callback: () {
                              Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage, params: {
                                'height': ScreenUtil().setHeight(1660),
                                'width': ScreenUtil().setWidth(1020),
                                'childName': 'rankDetail',
                                "title": "排行榜",
                              });
                            },
                          ),
                          new UserImageButton(
                            size: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarIconSize),
                            buttonName: "团队",
                            textSize: SystemFontSize.operationTextFontSize,
                            imageUrl: "resource/images/team.png",
                            callback: () {
                              Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                                  params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'teamDetail', "title": "团 队"});
                            },
                          ),
                          new UserImageButton(
                            size: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarIconSize),
                            buttonName: "商城",
                            textSize: SystemFontSize.operationTextFontSize,
                            imageUrl: "resource/images/marketStores.png",
                            callback: () {
                              Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                                  params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'storeDetail', "title": "商 城"});
                            },
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      height: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarIconSize),
                      child: new DividendPart(
                        imageTitle: "分红",
                        imageUrl: "resource/images/dividend.png",
                        imageHeight: ScreenUtil().setHeight(SystemIconSize.mainPageResourceBarIconSize),
                        imageWidth: ScreenUtil().setWidth(SystemIconSize.mainPageResourceBarIconSize),
                        title: "今日分红",
                        amount: "¥" + (autoProfitSharing == 0.00 ? this.displayInitProfitSharing() : autoProfitSharing.toStringAsFixed(2)),
                        callback: () {
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                              params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'adDividendDetail', "title": "广告分红"});
                        },
                      ),
                    ),
                    new Container(
                      child: new Column(
                        children: [
                          new Container(
                            // 设置加公告的宽度
                            width: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarSmallIconSize * 2),
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.7),
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new Image(
                                  image: new AssetImage("resource/images/volume.png"),
                                  width: ScreenUtil().setWidth(SystemIconSize.mainPageStatusBarSmallIconSize),
                                  height: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                                ),
                                new Text(
                                  baseUserInfo.voucher.toString(),
                                  textAlign: TextAlign.left,
                                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                ),
                              ],
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              new UserImageButton(
                                size: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                                buttonName: "设置",
                                textSize: SystemFontSize.operationTextFontSize,
                                imageUrl: "resource/images/setting.png",
                                callback: () {
                                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                                      params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'settingDetail', "title": "设 置"});
                                },
                              ),
                              new UserImageButton(
                                size: ScreenUtil().setHeight(SystemIconSize.mainPageStatusBarSmallIconSize),
                                buttonName: "公告",
                                textSize: SystemFontSize.operationTextFontSize,
                                imageUrl: "resource/images/announcement.png",
                                callback: () {
                                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                                      params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'announcementDetail', "title": "公 告"});
                                },
                              ),
                            ],
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
                    child: new Stack(
                      children: <Widget>[
                        ImageButton(
                          height: ScreenUtil().setHeight(630),
                          width: ScreenUtil().setWidth(600),
                          imageUrl: "resource/images/mainBuilding.png",
                          callback: () {
                            Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                                params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'mainBuildingDetail', "title": "主 城"});
                          },
                        ),
                        Container(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(420)),
                            child: Center(
                              child: Text(
                                "主 城",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.mainBuildingTextFontSize)),
                              ),
                            ))
                      ],
                    )),
              ),

              ///主城金币点击
              new Offstage(
                offstage: this.mainBuildingCoin,
                child: new Container(
                    margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(330), ScreenUtil().setHeight(660), ScreenUtil().setWidth(170), ScreenUtil().setHeight(670)),
                    child: new Stack(
                      children: <Widget>[
                        ImageButton(
                          height: ScreenUtil().setHeight(630),
                          width: ScreenUtil().setWidth(600),
                          imageUrl: "resource/images/mainBuildingCoin.png",
                          callback: () {
                            this.showOrDismissProgressHUD();
                            MainService.takeCoin((TakeCoinModel model) {
                              this.showOrDismissProgressHUD();
                              baseUserInfo.takeCoin(model.tcoinamount, model.woodamount, model.stoneamount);
                            });
                          },
                        ),
                        Container(
                            padding: EdgeInsets.only(top: ScreenUtil().setHeight(420)),
                            child: Center(
                              child: Text(
                                "主 城",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.mainBuildingTextFontSize)),
                              ),
                            ))
                      ],
                    )),
              ),

              ///英雄祭坛
              new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(590), ScreenUtil().setHeight(1250), ScreenUtil().setWidth(170), ScreenUtil().setHeight(360)),
                  child: new Stack(
                    children: <Widget>[
                      ImageButton(
                        height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                        width: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                        imageUrl: "resource/images/herosBuilding.png",
                        callback: () {
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                              params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'heroAltar', "title": "英雄祭坛"});
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(190)),
                          child: Center(
                            child: Text(
                              "英雄祭坛",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.otherBuildingTextFontSize)),
                            ),
                          ))
                    ],
                  )),

              ///采石场
              new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(590), ScreenUtil().setHeight(1550), ScreenUtil().setWidth(170), ScreenUtil().setHeight(80)),
                  child: new Stack(
                    children: <Widget>[
                      ImageButton(
                        height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                        width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                        imageUrl: "resource/images/stoneBuilding.png",
                        callback: () {
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage, params: {
                            'height': ScreenUtil().setHeight(1660),
                            'width': ScreenUtil().setWidth(1020),
                            'childName': 'stoneDetail',
                            "title": "采石场",
                          });
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(200)),
                          child: Center(
                            child: Text(
                              "采石场",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.otherBuildingTextFontSize)),
                            ),
                          ))
                    ],
                  )),

              ///伐木场
              new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(1330), ScreenUtil().setWidth(700), ScreenUtil().setHeight(300)),
                  child: new Stack(
                    children: <Widget>[
                      ImageButton(
                        height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                        width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                        imageUrl: "resource/images/fellingBuilding.png",
                        callback: () {
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage, params: {
                            'height': ScreenUtil().setHeight(1660),
                            'width': ScreenUtil().setWidth(1020),
                            'childName': 'sawmillDetail',
                            "title": "伐木场",
                          });
                        },
                      ),
//                ImageButton(height:ScreenUtil().setHeight(340),width: ScreenUtil().setWidth(380),imageUrl: "resource/images/fellingBuilding.png",callback: (){
////            name = "";
//                  print(this.widget.name);
//                },),
                      Container(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(190)),
                          child: Center(
                            child: Text(
                              "伐木场",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.otherBuildingTextFontSize)),
                            ),
                          ))
                    ],
                  )),

              ///农场
              new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(980), ScreenUtil().setWidth(680), ScreenUtil().setHeight(630)),
                  child: new Stack(
                    children: <Widget>[
                      ImageButton(
                        height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                        width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                        imageUrl: "resource/images/farmBuilding.png",
                        callback: () {
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                              params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'farmDetail', "title": "农 场"});
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(190)),
                          child: Center(
                            child: Text(
                              "农 场",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.otherBuildingTextFontSize)),
                            ),
                          ))
                    ],
                  )),

              ///市场
              new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(620), ScreenUtil().setWidth(680), ScreenUtil().setHeight(990)),
                  child: new Stack(
                    children: <Widget>[
                      ImageButton(
                        height: ScreenUtil().setHeight(SystemIconSize.mainPageIconSize),
                        width: ScreenUtil().setWidth(SystemIconSize.mainPageIconSize),
                        imageUrl: "resource/images/marketBuilding.png",
                        callback: () {
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,
                              params: {'height': ScreenUtil().setHeight(1660), 'width': ScreenUtil().setWidth(1020), 'childName': 'marketDetail', "title": "市 场"});
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(top: ScreenUtil().setHeight(170)),
                          child: Center(
                            child: Text(
                              "市 场",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.otherBuildingTextFontSize)),
                            ),
                          ))
                    ],
                  )),
              _progressHUD
            ],
          );
        },
        requestedValues: [BaseUserInfoProvider],
      ),
    );
  }
}
