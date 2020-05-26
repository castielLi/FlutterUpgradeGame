import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroAltarClock extends StatefulWidget{

  String imageUrl;
  int clockCount;
  int adIconHeight;

  HeroAltarClock({Key key,this.adIconHeight,this.clockCount,this.imageUrl}):super(key:key);
  @override
  _HeroAltarClockState createState() => _HeroAltarClockState();

}

class _HeroAltarClockState extends State<HeroAltarClock>{

  Widget buildList(){
    List <Widget> clockIconList = [];
    Widget content;
    for(int i=0;i<this.widget.clockCount;i++){
      clockIconList.add(
          Image(image: new AssetImage(this.widget.imageUrl), height:ScreenUtil().setHeight(this.widget.adIconHeight)),
      );
    }
    content = new Row(
//      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: clockIconList,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return buildList();
  }
}