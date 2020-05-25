import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/teamItem.dart';


class TeamDetail extends StatefulWidget {

  @override
  _TeamDetailState createState() => new _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(120),   // 左
            ScreenUtil().setHeight(400),  // 上
            ScreenUtil().setWidth(120),   // 右
            ScreenUtil().setHeight(220)), // 下
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ImageTextButton(imageUrl: "resource/images/woodButton.png",imageWidth:ScreenUtil().setWidth(360),imageHeight: ScreenUtil().setHeight(160),
                    buttonName: "徒弟",textSize: SystemFontSize.buttonTextFontSize,callback: (){
                    print(this.widget.toString());
                    },),
                  new ImageTextButton(imageUrl: "resource/images/woodButton.png",imageWidth:ScreenUtil().setWidth(360),imageHeight: ScreenUtil().setHeight(160),
                    buttonName: "徒孙",textSize: SystemFontSize.buttonTextFontSize,callback: (){
                      print(this.widget.toString());
                    },),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('日期',style: CustomFontSize.textStyle22,),
                Text('现金 T币',style: CustomFontSize.textStyle22,),
              ],
            ),
            Container(
              width: ScreenUtil().setWidth(800),
              height: ScreenUtil().setHeight(760),
              child:
              ListView.builder(
                itemCount: 10,
                itemExtent: 55,
                padding: EdgeInsets.all(1.0),
                itemBuilder: (BuildContext context, int index){
                  // 获取数据
                  int value = 5919-index;
                  return TeamItem(avatarUrl: 'resource/images/avatar.png', name: '黄小龙',money: value.toDouble(),date: '20200508',level: 1,tCoin: 5,);
                },
              ),
            ),

          ],
        ),


      ),
    );
  }
}