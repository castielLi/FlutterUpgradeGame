import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

import 'heroAltarClock.dart';

class HeroAltalItem extends StatefulWidget{
  // 描述
  String description;
  // 收益提高
  double revenueUp;
  // 英雄数量
  int heroCount;
  // 剩余天数
  int remainDays;

  String heroImageUrl;

  HeroAltalItem({Key key,this.description,this.revenueUp,this.heroCount,this.remainDays,this.heroImageUrl}):super(key:key);

  @override
  _HeroAltalItem createState() => _HeroAltalItem();

}

class _HeroAltalItem extends State <HeroAltalItem>{
  var minTextStyle = TextStyle(fontSize: SystemFontSize.minMinTextSize, color: Colors.white, decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return Column(

     children: <Widget>[
       Container(
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
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(this.widget.description,style: CustomFontSize.textStyle22,),
                 Text('效率：收益提高'+this.widget.revenueUp.toInt().toString()+'%',style: CustomFontSize.textStyle22,),
                 Text('期限：30天（可叠加）',style: CustomFontSize.textStyle22,),
               ],
             ),
           ],
         ),
       ),
       GestureDetector(
         child: Container(
           child:Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
               HeroAltarClock(imageUrl: 'resource/images/gold.png',clockCount: 4,adIconHeight: 100,),
               Text('战士*'+this.widget.heroCount.toString(),style: CustomFontSize.textStyle16,),
               Text('剩余'+this.widget.remainDays.toString()+'天',style: CustomFontSize.textStyle16,),

               Container(
                 width: ScreenUtil().setWidth(200),
                 height: ScreenUtil().setHeight(100),
                 padding: EdgeInsets.all(0),
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: new AssetImage('resource/images/upgradeButton.png'),
                     fit: BoxFit.fill,
                   ),
                 ),
                 child: Center(
                   child: Text('购 买',style: CustomFontSize.textStyle16,),
                 ),
               ),
             ],
           ),
         ),
         onTap: (){print('点击购买');},
       ),


     ],
    );

  }


}