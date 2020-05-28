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

  void changeTabs(String tab){
    setState(() {
      showCoin = false;
      showWood = false;
      showStone = false;
      switch(tab){
        case 'coin':{
          this.showCoin = true;
          break;
        }
        case 'wood':{
          this.showWood = true;
          break;
        }
        case 'stone':{
          this.showStone = true;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(120),   // 左
          ScreenUtil().setHeight(400),  // 上
          ScreenUtil().setWidth(100),   // 右
          ScreenUtil().setHeight(220)), // 下
      child: Column(
        children: <Widget>[
          Container(
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 120,imageWidth: 240,
                  iconUrl:'resource/images/gold.png',iconHeight: 90,iconWidth: 90,buttonName: 'T币',textSize: 22,callback: (){
                    print('T币');
                    changeTabs('coin');
                  },),
                ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 120,imageWidth: 240,
                  iconUrl:'resource/images/wood.png',iconHeight: 90,iconWidth: 90,buttonName: '木材',textSize: 22,callback: (){
                    print('木材');
                    changeTabs('wood');
                  },),
                ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 120,imageWidth: 240,
                  iconUrl:'resource/images/stone.png',iconHeight: 90,iconWidth: 90,buttonName: '石材',textSize: 22,callback: (){
                    print('石材');
                    changeTabs('stone');
                  },),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(900),
            padding: EdgeInsets.only(top:10),
            child: Stack(
              children: <Widget>[
                Offstage(
                  offstage: !this.showCoin,
                  child: ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index){
                          return MarketBidItem(avatarUrl:'resource/images/avatar.png',name: '黄小龙',bidType: 'gold',amount: 21231,needCoin: 192,);
                        }),
                ),
                Offstage(
                  offstage: !this.showWood,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index){
                        return MarketBidItem(avatarUrl:'resource/images/avatar.png',name: '黄小龙',bidType: 'wood',amount: 21231,needCoin: 192,);
                      }),
                ),
                Offstage(
                  offstage: !this.showStone,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index){
                        return MarketBidItem(avatarUrl:'resource/images/avatar.png',name: '黄小龙',bidType: 'stone',amount: 21231,needCoin: 192,);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
