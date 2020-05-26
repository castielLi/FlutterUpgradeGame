import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/team/teamItem.dart';


class TeamDetail extends StatefulWidget {

  @override
  VoidCallback HUD;
  TeamDetail({Key key,this.HUD}):super(key:key);
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
//        color: Colors.blue,
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(120),   // 左
            ScreenUtil().setHeight(400),  // 上
            ScreenUtil().setWidth(120),   // 右
            ScreenUtil().setHeight(80)), // 下
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Expanded(child:
              new ImageTextButton(imageUrl: "resource/images/teamSwitchBackground.png",imageWidth: ScreenUtil().setWidth(400),imageHeight: ScreenUtil().setHeight(190),
                buttonName: "徒 弟",textSize: SystemFontSize.settingTextFontSize,callback: (){

                },),
              ),
              new Expanded(child:
              new ImageTextButton(imageUrl: "resource/images/teamSwitchBackground.png",imageWidth: ScreenUtil().setWidth(400),imageHeight: ScreenUtil().setHeight(190),
                buttonName: "徒 孙",textSize: SystemFontSize.settingTextFontSize,callback: (){

                },),
              )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(120)),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('日期',style: CustomFontSize.textStyle22,),
                  Text('现金 T币',style: CustomFontSize.textStyle22,),
                ],
              ),
            ),
            Container(
//              color: Colors.red,
              width: ScreenUtil().setWidth(800),
              height: ScreenUtil().setHeight(730),
              child:
              ListView.builder(
                itemCount: 10,
//                itemExtent: 52,
                padding: EdgeInsets.all(1.0),
                itemBuilder: (BuildContext context, int index){
                  // 获取数据
                  int value = 5919-index;
                  int tCoin = 5+index;
                  return TeamItem(avatarUrl: 'resource/images/avatar.png', name: '黄小龙',money: value.toDouble(),date: '20200508',level: 1,tCoin: tCoin.toDouble(),);
                },
              ),
            ),
            new ImageButton(height:ScreenUtil().setHeight(150),width: ScreenUtil().setWidth(400),buttonName: "邀 请",imageUrl: "resource/images/upgradeButton.png",callback: (){
              print('点击邀请');
            },),

          ],
        ),

      ),
    );
  }
}