import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';


class FarmDetail extends StatefulWidget {

  @override
  _FarmDetailState createState() => new _FarmDetailState();
}

class _FarmDetailState extends State<FarmDetail> {
  // 获取数据
  static int level = 13;
  static int levelFrom = level-1;
  static int neededWood  = 2910;
  static int neededStone = 2910;
  static int coinPerHour = 291;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    var textStyleA = TextStyle(fontSize: 32.0, color: Colors.white,
        decoration: TextDecoration.none);
    var textStyleB = TextStyle(fontSize: 30.0, color: Colors.white,
        decoration: TextDecoration.none);
    var textStyleC = TextStyle(fontSize: 23.0, color: Colors.white,
        decoration: TextDecoration.none);

    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(150),   // 左
            ScreenUtil().setHeight(400),  // 上
            ScreenUtil().setWidth(150),   // 右
            ScreenUtil().setHeight(180)), // 下
        color: Colors.transparent,
        child: ListView(
          itemExtent: 60,// list高度
          children: <Widget>[
            Text('LV $levelFrom > LV $level',textAlign:TextAlign.left,style: textStyleA),
            Text('升级所需资料',style: textStyleA),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Image(image: new AssetImage('resource/images/wood.png'),
                    height:30),
                Text('$neededWood ',style: textStyleB,),
                new Image(image: new AssetImage('resource/images/stone.png'),
                    height:30),
                Text('$neededStone',style: textStyleB),
              ],
            ),
            Text('升级后产出:'+'$coinPerHour'+'T币一小时',style:textStyleC),
            new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "升 级",imageUrl: "resource/images/upgradeButton.png",callback: (){
              print('点击升级');
            },),
          ],
        ),
      ),
    );
  }
}