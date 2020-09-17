import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/armySelectMatrix.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class TrainArmyDetail extends StatefulWidget {
  VoidCallback HUD;

  TrainArmyDetail({Key key, this.HUD}) : super(key: key);

  _TrainArmyDetailState createState() => new _TrainArmyDetailState();
}

class _TrainArmyDetailState extends State<TrainArmyDetail> {
  ProgressHUD _progressHUD;
  int lastClickTime;
  bool attackDefencePageFlagSwitch = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: ProvideMulti(
        builder: (context, child, model) {
          BaseUserInfoProvider baseUserInfo = model.get<BaseUserInfoProvider>();
          BaseFightLineupProvider baseFightInfo = model.get<BaseFightLineupProvider>();
          return Stack(
            // alignment: Alignment.bottomCenter,
            children: <Widget>[
              new Image(
                image: new AssetImage('resource/images/mainBackground.png'),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              new Container(
                margin: EdgeInsets.only(top: 70),
                child: new Image(
                  image: new AssetImage('resource/images/trainArmyBackground.png'),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.fill,
                ),
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

              Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(300), ScreenUtil().setWidth(0), ScreenUtil().setHeight(0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(SystemIconSize.trainArmyIconSize * 5 + 10), //大于等于5个高度
                      child: ArmySelectMatrix(
                        itemSize: SystemIconSize.trainArmyIconSize,
                        // TODO 获取阵容
                        armyBaseMatrix: [
                          [0, 0, 3],
                          [0, 1, 0],
                          [0, 0, 2],
                          [3, 0, 1],
                          [0, 0, 0]
                        ],
                      ),
                    ),
                    Text(
                      '当前阵容消耗10金币',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Offstage(
                            offstage: this.attackDefencePageFlagSwitch,
                            child: ImageButton(
                              buttonName: '开始匹配',
                              imageUrl: 'resource/images/upgradeButton.png',
                              height: ScreenUtil().setHeight(230),
                              width: ScreenUtil().setWidth(515),
                              callback: () {
                                print('match');
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imageUrl: "resource/images/upgradeButton.png",
                                height: ScreenUtil().setHeight(180),
                                width: ScreenUtil().setWidth(410),
                                buttonName: '返 回',
                                callback: () {
                                  Application.router.pop(context);
                                },
                              ),
                              ImageButton(
                                imageUrl: "resource/images/upgradeButton.png",
                                height: ScreenUtil().setHeight(180),
                                width: ScreenUtil().setWidth(410),
                                buttonName: this.attackDefencePageFlagSwitch ? '攻 击' : '防 守',
                                callback: () {
                                  changePages();
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
              _progressHUD
            ],
          );
        },
        requestedValues: [BaseUserInfoProvider],
      ),
    );
  }

  void changePages() {
    setState(() {
      this.attackDefencePageFlagSwitch = !this.attackDefencePageFlagSwitch;
    });
  }
}
