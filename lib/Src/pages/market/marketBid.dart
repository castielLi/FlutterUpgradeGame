import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class MarketBidItem extends StatefulWidget{

  //排名图标
  String imageUrl;
  // 头像
  String avatarUrl;
  // 名称
  String rankName;
  // 排名值
  int value;

  MarketBidItem({Key key,this.imageUrl,this.avatarUrl,this.rankName,this.value}):super(key:key);

  @override
  _MarketBidItem createState() => _MarketBidItem();

}

class _MarketBidItem extends State <MarketBidItem>{


  @override
  Widget build(BuildContext context) {

    return Text(this.widget.rankName);
  }


}