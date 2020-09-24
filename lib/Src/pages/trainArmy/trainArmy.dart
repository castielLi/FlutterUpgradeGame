import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adDialog.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/trainArmy/armySelectMatrix.dart';
import 'package:upgradegame/Src/pages/trainArmy/service/armyService.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

import 'model/attackModel.dart';

class TrainArmyDetail extends StatefulWidget {
  VoidCallback HUD;

  // attack, defence, reWatch
  String contentName;

  int winsupplies;
  int winwood;
  int winstone;

  List<List<int>> content;

  bool isFightWin;

  TrainArmyDetail({Key key, this.HUD, this.content, this.contentName, this.isFightWin = false, this.winstone = 0, this.winwood = 0, this.winsupplies = 0}) : super(key: key);

  _TrainArmyDetailState createState() => new _TrainArmyDetailState();
}

class _TrainArmyDetailState extends State<TrainArmyDetail> {
  ProgressHUD _progressHUD;
  int lastClickTime;
  bool _loading = false;
  int times = 0;

  @override
  void initState() {
    super.initState();
    AdDialog().setCallback(this.adFinishedCallback, this.adFailedCallback, this.adOperateFailedCallback, false);
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );
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

  void adOperateFailedCallback(int type) {
    if (this.times == 2) {
      this.times = 0;
      CommonUtils.showErrorMessage(msg: "广告观看失败,请稍后再试");
      return;
    }

    ///尝试次数加1
    this.times += 1;
    switch (type) {
      case 3:
        AdDialog().showAd(4, 1, "945445227");
        break;
      case 4:
        AdDialog().showAd(3, 2, "6031610694170610");
        break;
    }
  }

  void adFailedCallback() {
    CommonUtils.showErrorMessage(msg: "广告展示失败了,那就不看了!");
  }

  void adFinishedCallback() {
    CommonUtils.showSuccessMessage(msg: "谢谢您对部落格的支持");
  }

  void attack(BaseFightLineupProvider baseFightLineUpInfo, BaseUserInfoProvider baseUserInfo) {
    this.showOrDismissProgressHUD();
    ArmyService.attack(baseFightLineUpInfo.attack, (AttackModel model) {
      if (model != null) {
        this.showOrDismissProgressHUD();

        ///匹配获胜可能会显示广告
        if (model.displayad && model.win) {
          CommonUtils.showSuccessMessage(msg: "您战斗胜利了,看条广告休息下吧");
          int timeSecend = DateTime.now().second;
          if (timeSecend % 2 == 0) {
            AdDialog().showAd(3, 2, "6031610694170610");
          } else {
            AdDialog().showAd(4, 1, "945445227");
          }
        }
        baseFightLineUpInfo.attackReslut(model);
        baseUserInfo.attactResult(model.stoneamount, model.woodamount);
        var lineup = List<List<int>>();
        var list = convert.jsonDecode(model.lineup);
        for (int i = 0; i < list.length; i++) {
          var row = List<int>();
          for (int j = 0; j < list[i].length; j++) {
            row.add(list[i][j]);
          }
          lineup.add(row);
        }
        baseFightLineUpInfo.trainArmyContentName = 'reWatch';
        Navigator.push(context, PopWindow(pageBuilder: (context) {
          return TrainArmyDetail(
            // contentName: 'reWatch',
            content: lineup,
            isFightWin: model.win,
            winstone: model.winstone,
            winsupplies: model.winsupplies,
            winwood: model.winwood,
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (null == this.widget.content) {
      this.widget.content = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ];
    }

    return new Container(
      color: Colors.white,
      child: ProvideMulti(
        builder: (context, child, model) {
          BaseUserInfoProvider baseUserInfo = model.get<BaseUserInfoProvider>();
          BaseFightLineupProvider baseFightLineUpInfo = model.get<BaseFightLineupProvider>();
          if (null == this.widget.contentName || 'attack' == baseFightLineUpInfo.trainArmyContentName || 'defence' == baseFightLineUpInfo.trainArmyContentName) {
            this.widget.contentName = (null == baseFightLineUpInfo.trainArmyContentName || '' == baseFightLineUpInfo.trainArmyContentName) ? 'attack' : baseFightLineUpInfo.trainArmyContentName;
          }
          return Stack(
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
                // color:Colors.red,
                height: ScreenUtil().setHeight(230),
                width: ScreenUtil().setWidth(230),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(860), ScreenUtil().setWidth(100), ScreenUtil().setWidth(0), ScreenUtil().setWidth(0)),
                child: ImageButton(
                    height: ScreenUtil().setHeight(130),
                    width: ScreenUtil().setWidth(130),
                    imageUrl: "resource/images/cancelDialog.png",
                    callback: () {
                      Application.router.pop(context);
                      baseFightLineUpInfo.trainArmyContentName = null;
                      // this.widget.contentName = null;
                    }),
              ),

              Container(
                height: ScreenUtil().setHeight(1520),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(300), ScreenUtil().setWidth(0), ScreenUtil().setHeight(0)),
                child: Stack(
                  children: [
                    /// 进攻
                    Offstage(
                      offstage: 'attack' != this.widget.contentName,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(900),
                            height: ScreenUtil().setHeight(SystemIconSize.trainArmyIconSize * 5), //大于等于5个高度
                            child: ArmySelectMatrix(
                              itemSize: SystemIconSize.trainArmyIconSize,
                              armyBaseMatrix: baseFightLineUpInfo.attack,
                              attack: true,
                              reWatch: false,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '当前消耗 ',
                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                              ),
                              Image(image: new AssetImage('resource/images/wood.png'), width: ScreenUtil().setWidth(100)),
                              Text(
                                baseFightLineUpInfo.woodproportion.toString() + " ",
                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                              ),
                              Image(image: new AssetImage('resource/images/stone.png'), width: ScreenUtil().setWidth(100)),
                              Text(
                                baseFightLineUpInfo.stoneproportion.toString(),
                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                              ),
                            ],
                          ),
                          ImageButton(
                            buttonName: '开始匹配',
                            imageUrl: 'resource/images/upgradeButton.png',
                            height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                            width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                            callback: () {
                              // print(baseFightLineUpInfo.attackHeroCount);
                              if (baseFightLineUpInfo.attackHeroCount < 5) {
                                CommonUtils.showWarningMessage(msg: "您当前的进攻阵容英雄不足5个,请继续排兵布阵");
                                return;
                              }

                              if (baseFightLineUpInfo.supplies < 10) {
                                CommonUtils.showWarningMessage(msg: "您当前的物资不足10,无法进行匹配战斗");
                                return;
                              }

                              if (baseUserInfo.woodamount >= baseFightLineUpInfo.woodproportion && baseUserInfo.stoneamount >= baseFightLineUpInfo.stoneproportion) {
                                showDialog<Null>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return new AlertDialog(
                                      title: new Text('您确认要匹配战斗么?'),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text('取消'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        new FlatButton(
                                          child: new Text('确认'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            this.attack(baseFightLineUpInfo, baseUserInfo);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ).then((val) {
                                  print(val);
                                });
                              } else {
                                CommonUtils.showErrorMessage(msg: "您当前的资源不足,不能进行战斗匹配");
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imageUrl: "resource/images/upgradeButton.png",
                                height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                                width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                                buttonName: '进 攻',
                                callback: () {
                                  // setState(() {
                                  //   baseFightLineUpInfo.trainArmyContentName = 'attack';
                                  // });
                                },
                              ),
                              ImageButton(
                                imageUrl: "resource/images/upgradeButton.png",
                                height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                                width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                                buttonName: '防 守',
                                callback: () {
                                  setState(() {
                                    baseFightLineUpInfo.trainArmyContentName = 'defence';
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// 防守
                    Offstage(
                      offstage: 'defence' != this.widget.contentName,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(900),
                            height: ScreenUtil().setHeight(SystemIconSize.trainArmyIconSize * 5), //大于等于5个高度
                            child: ArmySelectMatrix(
                              itemSize: SystemIconSize.trainArmyIconSize,
                              armyBaseMatrix: baseFightLineUpInfo.protect,
                              attack: false,
                              reWatch: false,
                            ),
                          ),
                          ImageButton(
                            buttonName: '保存阵容',
                            imageUrl: 'resource/images/upgradeButton.png',
                            height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                            width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                            callback: () {
                              if (baseFightLineUpInfo.protectHeroCount < 5) {
                                CommonUtils.showWarningMessage(msg: "您当前的防守阵容英雄数量不足5个,请继续添加");
                                return;
                              }
                              if (baseFightLineUpInfo.protectHeroCount > 5) {
                                CommonUtils.showWarningMessage(msg: "最多只能排列5名士兵,请重新排兵布阵");
                                return;
                              }
                              if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 10000)) {
                                this.showOrDismissProgressHUD();
                                ArmyService.setProtectLineup(baseFightLineUpInfo.protect, (bool success) {
                                  this.showOrDismissProgressHUD();
                                  if (success) {
                                    CommonUtils.showSuccessMessage(msg: "设置防守阵容成功");
                                  }
                                });
                              } else {
                                CommonUtils.showWarningMessage(msg: '您操作的太快了，请隔十秒钟再操作');
                              }
                              this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ImageButton(
                                imageUrl: "resource/images/upgradeButton.png",
                                height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                                width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                                buttonName: '进 攻',
                                callback: () {
                                  setState(() {
                                    baseFightLineUpInfo.trainArmyContentName = 'attack';
                                  });
                                },
                              ),
                              ImageButton(
                                imageUrl: "resource/images/upgradeButton.png",
                                height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                                width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                                buttonName: '防 守',
                                callback: () {
                                  // setState(() {
                                  //   baseFightLineUpInfo.trainArmyContentName = 'defence';
                                  // });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// 回看
                    Offstage(
                      offstage: 'reWatch' != this.widget.contentName,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(900),
                              height: ScreenUtil().setHeight(SystemIconSize.trainArmyIconSize * 5), //大于等于5个高度
                              child: ArmySelectMatrix(
                                itemSize: SystemIconSize.trainArmyIconSize,
                                armyBaseMatrix: this.widget.content,
                                attack: false,
                                reWatch: true,
                              ),
                            ),
                            Image(
                              image: AssetImage('resource/images/' + (this.widget.isFightWin ? 'win' : 'lose').toString() + '.png'),
                              height: ScreenUtil().setHeight(250),
                              width: ScreenUtil().setWidth(650),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(image: new AssetImage('resource/images/volume.png'), width: ScreenUtil().setWidth(100)),
                                Text(
                                  this.widget.winsupplies.toString() + " ",
                                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                ),
                                Offstage(
                                  offstage: !this.widget.isFightWin,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(image: new AssetImage('resource/images/wood.png'), width: ScreenUtil().setWidth(100)),
                                      Text(
                                        this.widget.winwood.toString() + " ",
                                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                      ),
                                      Image(image: new AssetImage('resource/images/stone.png'), width: ScreenUtil().setWidth(100)),
                                      Text(
                                        this.widget.winstone.toString(),
                                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreLargerTextSize),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

  void changeContent(String name) {
    setState(() {
      this.widget.contentName = name;
    });
  }
}
