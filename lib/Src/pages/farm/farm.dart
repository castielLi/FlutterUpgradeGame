import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/common/model/baseRuleModel.dart';
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
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(child:
        Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
      int levelFrom = baseUserInfo.Farmlevel;
      int level = baseUserInfo.Farmlevel + 1;

      Farm farmBuildingRule = Global.getFarmBuildingRule()[level - 1];
      AdSetting adSetting = Global.getAdSettingRule();
      int neededCoin = farmBuildingRule.tcoinamount;
      int watchedAd = baseUserInfo.ad.farm;
      int maxWatchableAd = adSetting.farm;
      int speedUpPercent = farmBuildingRule.product;

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
              margin: EdgeInsets.fromLTRB(
                  ScreenUtil().setWidth(20), // 左
                  ScreenUtil().setHeight(0), // 上
                  ScreenUtil().setWidth(0), // 右
                  ScreenUtil().setHeight(0)), // 下
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('LV $levelFrom > LV $level',
                      textAlign: TextAlign.left,
                      style: CustomFontSize.textStyle30),
                  Text('升级所需资料', style: CustomFontSize.textStyle30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Image(
                          image: new AssetImage('resource/images/gold.png'),
                          height: ScreenUtil().setHeight(100)),
                      Text(
                        '$neededCoin ',
                        style: CustomFontSize.textStyle30,
                      ),
                    ],
                  ),
                  Text('观看广告获取升级资源', style: CustomFontSize.textStyle22),
                ],
              ),
            ),
            AdIconRow(
              countInOneRow: maxWatchableAd,
              adIconHeight: ScreenUtil().setHeight(150),
              imageUrlWatched: 'resource/images/adWatched.png',
              imageUrlUnwatch: "resource/images/adUnwatch.png",
              alreadyWatched: watchedAd,
            ),
            new Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '每次采石场和伐木场提速 $speedUpPercent%',
                        style: CustomFontSize.textStyle22,
                      ),
                    ],
                  ),
                  Text('今日观看次数 $watchedAd/$maxWatchableAd',
                      style: CustomFontSize.textStyle22),
                ],
              ),
            ),
            new ImageButton(
              height: ScreenUtil().setHeight(200),
              width: ScreenUtil().setWidth(400),
              buttonName: "升 级",
              imageUrl: "resource/images/upgradeButton.png",
              callback: () {
                print('点击升级');
              },
            ),
          ],
        ),
      );
    }));
  }
}
