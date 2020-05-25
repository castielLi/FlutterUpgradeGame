import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class TeamItem extends StatefulWidget{

  // 头像
  String avatarUrl;
  // 名称
  String name;
  // 日期
  String date;
  // 等级
  int level;
  // 现金收益
  double money;
  // T币收益
  double tCoin;

  TeamItem({Key key,this.avatarUrl,this.name,this.money,this.date,this.level,this.tCoin}):super(key:key);

  @override
  _TeamItem createState() => _TeamItem();

}

class _TeamItem extends State <TeamItem>{


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image(image: new AssetImage(this.widget.avatarUrl), height:ScreenUtil().setHeight(100),),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(this.widget.name,style: CustomFontSize.textStyle22,),
                Text(this.widget.date,style: CustomFontSize.textStyle16,)
              ],
            ),
          ],

        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(0),   // 左
              ScreenUtil().setHeight(0),  // 上
              ScreenUtil().setWidth(20),   // 右
              ScreenUtil().setHeight(0)),
          child:Text('¥'+this.widget.money.toInt().toString()+"("+this.widget.tCoin.toInt().toString()+')',style: CustomFontSize.textStyle16,),
        ),

      ],
    );
  }


}