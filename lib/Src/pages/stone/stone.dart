import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/common/model/enum/buildingEnum.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Src/common/widget/adIcon/adIconRow.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class StoneDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  StoneDetail({Key key, this.HUD}) : super(key: key);

  _StoneDetailState createState() => new _StoneDetailState();
}

class _StoneDetailState extends State<StoneDetail> {
  bool showStrategyPage = false;

  void upgradeBuilding() {
    this.widget.HUD();
    BaseService.upgradeBuilding(BuildingEnum.stone.index, (model) {
      this.widget.HUD();
      if (model != null) {
        CommonUtils.showSuccessMessage(msg: "升级成功");
        Provide.value<BaseUserInfoProvider>(context).upgradeBuilding(model);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
      int level = 0;
      Stone stoneBuildingRule;
      Stone currentStoneBuildingRule;
      Stone nextStoneBuildingRule;
      Adsetting adSetting;
      int needTCoin = 0;
      int woodPerAd = 0;
      int woodPerAdNextLevel = 0;
      int watchedAd = 0;
      int maxWatchableAd = 0;
      int needFarmLevel = 0;
      int tCoinAmount = baseUserInfo.TCoinAmount;
      int farmLevel = baseUserInfo.Farmlevel;
      if (null != baseUserInfo) {
        level = baseUserInfo.Stonelevel;
        stoneBuildingRule = null == Global.getStoneBuildingRule() ? null : Global.getStoneBuildingRule()[level];
        currentStoneBuildingRule = null == Global.getStoneBuildingRule() ? null : Global.getStoneBuildingRule()[level - 1];
        nextStoneBuildingRule = null == Global.getStoneBuildingRule() ? null : Global.getStoneBuildingRule()[level];
        adSetting = Global.getAdSettingRule();
        if (null != stoneBuildingRule) {
          needTCoin = stoneBuildingRule.tcoinamount;
          woodPerAd = currentStoneBuildingRule.product;
          woodPerAdNextLevel = nextStoneBuildingRule.product;
          needFarmLevel = stoneBuildingRule.farmlevel;
        }
        watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.stone;
        maxWatchableAd = null == adSetting ? 5 : adSetting.stone;
      }

      bool canUpdate() {
        if (baseUserInfo.tcoinamount < stoneBuildingRule.tcoinamount) {
          CommonUtils.showErrorMessage(msg: "金币不足");
          return false;
        }
        if (baseUserInfo.farmlevel < stoneBuildingRule.farmlevel) {
          CommonUtils.showErrorMessage(msg: "农场等级不足");
          return false;
        }
        return true;
      }

      return new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(80), // 左
            ScreenUtil().setHeight(350), // 上
            ScreenUtil().setWidth(80), // 右
            ScreenUtil().setHeight(100)), // 下
        child: Stack(
          children: [
            Offstage(
              offstage: this.showStrategyPage,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
//                    height: ScreenUtil().setHeight(1050),
                    width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
                    child: new Column(
                      children: [
                        new Container(
                          margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('当前等级 LV $level', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
                                  new GestureDetector(
                                    child: new Container(
                                      child: Image(image: new AssetImage('resource/images/howToPlay.png'), height: ScreenUtil().setHeight(100)),
                                    ),
                                    onTap: () {
                                      changePage();
                                    },
                                  ),
                                ],
                              ),
                              Text('升级条件', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image(image: new AssetImage('resource/images/coin.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                                  Text(
                                    '$needTCoin ',
                                    style: TextStyle(fontSize: SystemFontSize.buildingConditionTextFontSize, color: tCoinAmount >= needTCoin ? Colors.lightGreenAccent : Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image(image: new AssetImage('resource/images/farmBuilding.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                                  Text(
                                    'lv' + '$needFarmLevel ',
                                    style: TextStyle(fontSize: SystemFontSize.buildingConditionTextFontSize, color: farmLevel >= needFarmLevel ? Colors.lightGreenAccent : Colors.grey),
                                  ),
                                ],
                              ),
                              Text('观看广告获取升级材料', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                            ],
                          ),
                        ),
                        new AdIconRow(
                          countInOneRow: maxWatchableAd,
                          adIconHeight: ScreenUtil().setHeight(SystemIconSize.adIconSize),
                          imageUrlWatched: 'resource/images/adWatched.png',
                          imageUrlUnwatch: "resource/images/adUnwatch.png",
                          imageUrlWaiting: "resource/images/adWaiting.png",
                          HUD: this.widget.HUD,
                          type: AdTypeEnum.stone,
                          alreadyWatched: watchedAd,
                        ),
                        new Container(
                          margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '每次获取 ',
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                                  ),
                                  Image(
                                    image: new AssetImage('resource/images/stone.png'),
                                    height: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                                  ),
                                  Text(
                                    ' $woodPerAd',
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '下一级每次获取 ',
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                                  ),
                                  Image(
                                    image: new AssetImage('resource/images/stone.png'),
                                    height: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                                  ),
                                  Text(
                                    ' $woodPerAdNextLevel',
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                                  ),
                                ],
                              ),
                              Text('今日观看次数 $watchedAd/$maxWatchableAd', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  new ImageButton(
                    height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                    width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                    buttonName: "升 级",
                    imageUrl: "resource/images/upgradeButton.png",
                    callback: () {
                      if (canUpdate()) {
                        showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text('您确认要升级采石场么?'),
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
                                    this.upgradeBuilding();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((val) {
                          print(val);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: !this.showStrategyPage,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    height: ScreenUtil().setHeight(1050),
                    width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "采石场玩法介绍:",
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                          Text(
                            "生产“石材”（点击建筑观看广告,成功观看后产出，等级越高产出越高)",
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                          Text(
                            "观看广告:产生当前等级对应的资源,并获取广告贡献值",
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                          Text(
                            "升级:通过金币进行升级,升级有农场等级限制",
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new ImageButton(
                    height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                    width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                    buttonName: "返回",
                    imageUrl: "resource/images/upgradeButton.png",
                    callback: () {
                      changePage();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }));
  }

  void changePage() {
    setState(() {
      this.showStrategyPage = !this.showStrategyPage;
    });
  }
}
