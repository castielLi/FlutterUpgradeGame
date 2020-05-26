import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Src/pages/AdDividend/adPool.dart';

class AdDividendDetail extends StatefulWidget {

  @override
  VoidCallback HUD;
  AdDividendDetail({Key key,this.HUD}):super(key:key);
  _AdDividendDetailState createState() => new _AdDividendDetailState();
}

class _AdDividendDetailState extends State<AdDividendDetail> {
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
      child: Column(
        children: <Widget>[
          AdPool(heroImageUrl:'resource/images/warrior.png',poolName:'勇士',yesterdayRevenue: yesterdayRevenue,totalRevenue: totalRevenue,heroInNetwork: heroInNetwork,productionToday: productionToday,),
          AdPool(heroImageUrl:'resource/images/hunter.png',poolName:'猎人',yesterdayRevenue: yesterdayRevenue,totalRevenue: totalRevenue,heroInNetwork: heroInNetwork,productionToday: productionToday,),
          AdPool(heroImageUrl:'resource/images/shaman.png',poolName:'萨满',yesterdayRevenue: yesterdayRevenue,totalRevenue: totalRevenue,heroInNetwork: heroInNetwork,productionToday: productionToday,),
        ],
      ),
    );
  }
}