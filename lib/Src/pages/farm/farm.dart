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

class FarmDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  FarmDetail({Key key, this.HUD}) : super(key: key);

  _FarmDetailState createState() => new _FarmDetailState();
}

class _FarmDetailState extends State<FarmDetail> {

  void upgradeBuilding(){
    this.widget.HUD();
    BaseService.upgradeBuilding(BuildingEnum.farm.index, (model) {
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
      int levelFrom = 0;
      int level = 0;
      int neededCoin = 0;
      int watchedAd = 0;
      int maxWatchableAd = 0;
      Farm farmBuildingRule;
      Adsetting adSetting;
      int needWoodLevel = 0;
      int needStoneLevel = 0;

      int tocinamount = baseUserInfo.TCoinAmount;
      int woodLevel = baseUserInfo.Woodlevel;
      int stoneLevel = baseUserInfo.Stonelevel;

      if (null != baseUserInfo) {
        levelFrom = baseUserInfo.Farmlevel;
        level = baseUserInfo.Farmlevel + 1;

        ///升级农场等级是从1级开始
        farmBuildingRule = null == Global.getFarmBuildingRule() ? null : Global.getFarmBuildingRule()[level - 1];

        adSetting = Global.getAdSettingRule();
        if (null != farmBuildingRule) {
          neededCoin = farmBuildingRule.tcoinamount;
          needWoodLevel = farmBuildingRule.woodlevel;
          needStoneLevel = farmBuildingRule.stonelevel;
        }

        ///农产的广告在每天0点12点18点的时候进行刷新

        int timeHour = DateTime.now().hour;
        if (timeHour >= 0 && timeHour < 12) {
          watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farmone;
          maxWatchableAd = null == adSetting ? 5 : adSetting.farmone;
        } else if (timeHour >= 12 && timeHour < 18) {
          watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farmtwo;
          maxWatchableAd = null == adSetting ? 5 : adSetting.farmtwo;
        } else {
          watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farmthree;
          maxWatchableAd = null == adSetting ? 5 : adSetting.farmthree;
        }
      }
      bool canUpdate() {
        if (baseUserInfo.tcoinamount < farmBuildingRule.tcoinamount) {
          CommonUtils.showErrorMessage(msg: "T币不足");
          return false;
        }
        if (baseUserInfo.stonelevel < farmBuildingRule.stonelevel) {
          CommonUtils.showErrorMessage(msg: "采石场等级不足");
          return false;
        }
        if (baseUserInfo.woodlevel < farmBuildingRule.woodlevel) {
          CommonUtils.showErrorMessage(msg: "伐木场等级不足");
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('当前等级 LV $levelFrom', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
                  Text('升级条件', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image(image: new AssetImage('resource/images/coin.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        '$neededCoin  ',
                        style: TextStyle(fontSize: SystemFontSize.buildingConditionTextFontSize, color: tocinamount >= neededCoin ? Colors.lightGreenAccent : Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image(image: new AssetImage('resource/images/fellingBuilding.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        'lv' + '$needWoodLevel ',
                        style: TextStyle(fontSize: SystemFontSize.buildingConditionTextFontSize, color: woodLevel >= needWoodLevel ? Colors.lightGreenAccent : Colors.grey),
                      ),
                      Image(image: new AssetImage('resource/images/stoneBuilding.png'), height: ScreenUtil().setHeight(SystemIconSize.adIconSize)),
                      Text(
                        'lv' + '$needStoneLevel ',
                        style: TextStyle(fontSize: SystemFontSize.buildingConditionTextFontSize, color: stoneLevel >= needStoneLevel ? Colors.lightGreenAccent : Colors.grey),
                      ),
                    ],
                  ),
                  Text('观看广告以随机获取材料', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
                ],
              ),
            ),
            AdIconRow(
              countInOneRow: maxWatchableAd,
              adIconHeight: ScreenUtil().setHeight(SystemIconSize.adIconSize),
              imageUrlWatched: 'resource/images/adWatched.png',
              imageUrlUnwatch: "resource/images/adUnwatch.png",
              imageUrlWaiting: "resource/images/adWaiting.png",
              alreadyWatched: watchedAd,
              HUD: this.widget.HUD,
              type: AdTypeEnum.farm,
            ),
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '每日0:00/12:00/18:00更新',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize),
                      ),
                    ],
                  ),
                  Text('本时段观看次数 $watchedAd/$maxWatchableAd', style: CustomFontSize.defaultTextStyle(SystemFontSize.otherBuildingTextFontSize)),
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
                        title: new Text('您确认要升级农场么?'),
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
      );
    }));
  }
}
