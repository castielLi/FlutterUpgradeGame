import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';
import 'package:upgradegame/Src/pages/market/marketBid.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  MarketDetail({Key key,this.HUD}):super(key:key);
  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
  bool showCoin = false;
  bool showWood = true;
  bool showStone = false;

  void changeTabs({bool displayCoin,bool displayWood,bool displayStone}){
    setState(() {
      showCoin = displayCoin;
      showWood = displayWood;
      showStone = displayStone;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
//      color: Colors.yellow,
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(120),   // 左
          ScreenUtil().setHeight(400),  // 上
          ScreenUtil().setWidth(100),   // 右
          ScreenUtil().setHeight(220)), // 下
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 120,imageWidth: 240,
                  iconUrl:'resource/images/gold.png',iconHeight: 90,iconWidth: 90,buttonName: 'T币',textSize: 22,callback: (){
                    print('T币');
                    changeTabs(displayCoin:true, displayWood:false, displayStone: false);
                  },),
                ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 120,imageWidth: 240,
                  iconUrl:'resource/images/wood.png',iconHeight: 90,iconWidth: 90,buttonName: '木材',textSize: 22,callback: (){
                    print('木材');
                    changeTabs(displayCoin:false, displayWood:true, displayStone: false);
                  },),
                ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 120,imageWidth: 240,
                  iconUrl:'resource/images/stone.png',iconHeight: 90,iconWidth: 90,buttonName: '石材',textSize: 22,callback: (){
                    print('石材');
                    changeTabs(displayCoin:false, displayWood:false, displayStone: true);
                  },),
              ],
            ),
          ),
          Container(
//            color: Colors.red,
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(840),
            child: Offstage(
              offstage: !this.showWood,
              child: MarketBidItem(rankName: '木材',),
            ),
          ),
        ],

      ),
    );
  }
}