import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'heroAltalItem.dart';

class HeroAltal extends StatefulWidget {

  @override
  VoidCallback HUD;
  HeroAltal({Key key,this.HUD}):super(key:key);
  _HeroAltalState createState() => new _HeroAltalState();
}

class _HeroAltalState extends State<HeroAltal> {
  // 获取数据
  static int yesterdayRevenue = 1928;
  static int totalRevenue = 2928;
  static int heroInNetwork  = 99910;
  static int productionToday = 9100;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80),   // 左
          ScreenUtil().setHeight(350),  // 上
          ScreenUtil().setWidth(80),   // 右
          ScreenUtil().setHeight(200)),
      child: ListView(
        padding: EdgeInsets.only(top:0),
        children: <Widget>[
          HeroAltalItem(heroImageUrl:'resource/images/warrior.png',description: '战士:守卫家园',revenueUp: 10,heroCount: 4,remainDays: 38,),
          HeroAltalItem(heroImageUrl:'resource/images/hunter.png',description: '猎人:在野外获取食物',revenueUp: 10,heroCount: 4,remainDays: 38,),
          HeroAltalItem(heroImageUrl:'resource/images/shaman.png',description: '萨满:保佑你的灵魂',revenueUp: 10,heroCount: 4,remainDays: 38,),
        ],
      ),
    );
  }
}