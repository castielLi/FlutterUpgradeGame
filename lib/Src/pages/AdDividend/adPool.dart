import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class AdPool extends StatefulWidget{
  // 昨日收益
  int yesterdayRevenue;
  // 历史收益
  int totalRevenue;
  // 全网总数
  int heroInNetwork;
  // 今日产出
  int productionToday;

  String heroImageUrl;

  String poolName;

  AdPool({Key key,this.yesterdayRevenue,this.totalRevenue,this.heroInNetwork,this.productionToday,this.heroImageUrl,this.poolName}):super(key:key);

  @override
  _AdPool createState() => _AdPool();

}

class _AdPool extends State <AdPool>{
  var minTextStyle = TextStyle(fontSize: SystemFontSize.minMinTextSize, color: Colors.white, decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(900),
      height: ScreenUtil().setHeight(360),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/woodButton.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image(image: new AssetImage(this.widget.heroImageUrl),height: ScreenUtil().setHeight(250),width: ScreenUtil().setWidth(250),),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left:100),
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('昨日收益',style: minTextStyle,),
                    Text('历史收益',style: minTextStyle,),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('我的'+this.widget.poolName+'奖池',style: minTextStyle,),
                    Text(this.widget.yesterdayRevenue.toString(),style: minTextStyle,),
                    Text(this.widget.totalRevenue.toString(),style: minTextStyle,),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('全网总数',style: minTextStyle,),
                    Text(this.widget.heroInNetwork.toString(),style: minTextStyle,),
                    Text('今日产出',style: minTextStyle,),
                    Text(this.widget.productionToday.toString(),style: minTextStyle,),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );

  }


}