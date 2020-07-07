import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
import 'package:upgradegame/Src/common/model/enum/adTypeEnum.dart';
import 'package:upgradegame/Src/common/model/enum/buildingEnum.dart';
import 'package:upgradegame/Src/common/model/userInfoAd.dart';
import 'package:upgradegame/Src/common/service/baseService.dart';
import 'package:upgradegame/Src/common/widget/adIcon/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';

class FarmDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  FarmDetail({Key key, this.HUD}) : super(key: key);

  _FarmDetailState createState() => new _FarmDetailState();
}

class _FarmDetailState extends State<FarmDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
      int levelFrom = 0;
      int level = 0;
      int neededCoin = 0;
      int watchedAd = 0;
      int maxWatchableAd = 0;
      int speedUpPercent = 0;
      Farm farmBuildingRule;
      AdSetting adSetting;
      if (null != baseUserInfo) {
        levelFrom = baseUserInfo.Farmlevel;
        level = baseUserInfo.Farmlevel + 1;
        farmBuildingRule = null == Global.getFarmBuildingRule() ? null : Global.getFarmBuildingRule()[level - 1];
        adSetting = Global.getAdSettingRule();
        if (null != farmBuildingRule) {
          neededCoin = farmBuildingRule.tcoinamount;
          speedUpPercent = farmBuildingRule.product;
        }
        watchedAd = null == baseUserInfo.ad ? 0 : baseUserInfo.ad.farm;
        maxWatchableAd = null == adSetting ? 5 : adSetting.farm;
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('LV $levelFrom > LV $level', textAlign: TextAlign.left, style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
                  Text('升级所需资料', style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Image(image: new AssetImage('resource/images/coin.png'), height: ScreenUtil().setHeight(100)),
                      Text(
                        '$neededCoin ',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.mainBuildingTextFontSize),
                      ),
                    ],
                  ),
                  Text('观看广告获取升级资源', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
                ],
              ),
            ),
            AdIconRow(
              countInOneRow: maxWatchableAd,
              adIconHeight: ScreenUtil().setHeight(SystemIconSize.adIconSize),
              imageUrlWatched: 'resource/images/adWatched.png',
              imageUrlUnwatch: "resource/images/adUnwatch.png",
              alreadyWatched: watchedAd,
              HUD: this.widget.HUD,
              type: AdTypeEnum.farm,
              watchSuccessCallBack: () {
                setState(() {
                  baseUserInfo.watchedAnAd(AdType.farm);
                  print("广告观看个数:" + baseUserInfo.ad.farm.toString());
                });
              },
            ),
            new Container(
              margin: EdgeInsets.only(left: ScreenUtil().setHeight(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '每次采石场和伐木场提速 $speedUpPercent%',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                      ),
                    ],
                  ),
                  Text('今日观看次数 $watchedAd/$maxWatchableAd', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
                ],
              ),
            ),
            new ImageButton(
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(400),
              buttonName: "升 级",
              imageUrl: "resource/images/upgradeButton.png",
              callback: () {
                if (null != baseUserInfo && null != farmBuildingRule) {
                  if (baseUserInfo.tcoinamount < farmBuildingRule.tcoinamount) {
                    CommonUtils.showErrorMessage(msg: "没有足够的资源升级");
                  } else {
                    this.widget.HUD();
                    BaseService.upgradeBuilding(BuildingEnum.farm.index, (model) {
                      this.widget.HUD();
                      if (model != null) {
                        Provide.value<BaseUserInfoProvider>(context).upgradeBuilding(model);
                      }
                    });
                  }
                }
              },
            ),
          ],
        ),
      );
    }));
  }
}
