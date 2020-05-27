import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  MarketDetail({Key key,this.HUD}):super(key:key);
  _MarketDetailState createState() => new _MarketDetailState();
}

class _MarketDetailState extends State<MarketDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.yellow,
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(120),   // 左
          ScreenUtil().setHeight(400),  // 上
          ScreenUtil().setWidth(120),   // 右
          ScreenUtil().setHeight(220)), // 下
      child: new Container(

      ),
    );
  }
}