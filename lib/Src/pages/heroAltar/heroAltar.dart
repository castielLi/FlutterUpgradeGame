import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'heroAltalItem.dart';

class HeroAltal extends StatefulWidget {
  @override
  VoidCallback HUD;

  HeroAltal({Key key, this.HUD}) : super(key: key);

  _HeroAltalState createState() => new _HeroAltalState();
}

class _HeroAltalState extends State<HeroAltal> {
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Provide<BaseUserInfoProvider>(
          builder: (context, child, baseUserInfo) {
        List<Heroes> heros = baseUserInfo.hero;
        List<int> warriors = [];
        List<int> hunters = [];
        List<int> shamans = [];
        if (null != baseUserInfo) {
          for (int i = 0; i < heros.length; i++) {
            if (heros[i].type == Heroes.WARRIOR) {
              warriors.add(heros[i].days);
              continue;
            }
            if (heros[i].type == Heroes.HUNTER) {
              hunters.add(heros[i].days);
              continue;
            }
            if (heros[i].type == Heroes.SHAMAN) {
              shamans.add(heros[i].days);
            }
          }
        }

        return new Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(80), // 左
              ScreenUtil().setHeight(350), // 上
              ScreenUtil().setWidth(80), // 右
              ScreenUtil().setHeight(200)),
          child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: <Widget>[
              HeroAltalItem(
                heroImageUrl: 'resource/images/warrior.png',
                description: '战士:守卫家园',
                revenueUp: 10,
                remainDays: warriors,
              ),
              HeroAltalItem(
                heroImageUrl: 'resource/images/hunter.png',
                description: '猎人:在野外获取食物',
                revenueUp: 10,
                remainDays: hunters,
              ),
              HeroAltalItem(
                heroImageUrl: 'resource/images/shaman.png',
                description: '萨满:保佑你的灵魂',
                revenueUp: 10,
                remainDays: shamans,
              ),
            ],
          ),
        );
      }),
    );
  }
}
