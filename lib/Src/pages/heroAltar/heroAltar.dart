import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'heroAltarItem.dart';

class HeroAltar extends StatefulWidget {
  @override
  VoidCallback HUD;

  HeroAltar({Key key, this.HUD}) : super(key: key);

  _HeroAltarState createState() => new _HeroAltarState();
}

class _HeroAltarState extends State<HeroAltar> {
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        List<Heroes> heroes = baseUserInfo.hero;
        List<int> warriors = [];
        List<int> hunters = [];
        List<int> shamans = [];
        if (null != baseUserInfo) {
          heroes.forEach((hero) {
            switch (hero.type) {
              case Heroes.WARRIOR:
                warriors.add(hero.days);
                break;
              case Heroes.HUNTER:
                hunters.add(hero.days);
                break;
              case Heroes.SHAMAN:
                shamans.add(hero.days);
            }
          });
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
              HeroAltarItem(
                heroImageUrl: 'resource/images/warrior.png',
                description: '战士:守卫家园',
                revenueUp: 10,
                remainDays: warriors,
                heroType: Heroes.WARRIOR,
                HUD: this.widget.HUD,
              ),
              HeroAltarItem(
                heroImageUrl: 'resource/images/hunter.png',
                description: '猎人:在野外获取食物',
                revenueUp: 10,
                remainDays: hunters,
                heroType: Heroes.HUNTER,
                HUD: this.widget.HUD,
              ),
              HeroAltarItem(
                heroImageUrl: 'resource/images/shaman.png',
                description: '萨满:保佑你的灵魂',
                revenueUp: 10,
                remainDays: shamans,
                heroType: Heroes.SHAMAN,
                HUD: this.widget.HUD,
              ),
            ],
          ),
        );
      }),
    );
  }
}
