import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';
import 'package:upgradegame/Src/pages/rank/rankItem.dart';


class RankDetail extends StatefulWidget {

  @override
  VoidCallback HUD;
  RankDetail({Key key,this.HUD}):super(key:key);
  _RankDetailState createState() => new _RankDetailState();
}

class _RankDetailState extends State<RankDetail> {
  // 获取数据

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 160,imageWidth: 360,
                    iconUrl:'resource/images/gold.png',iconHeight: 140,iconWidth: 140,buttonName: 'T币',textSize: 29,callback: (){
                    print('T币');
                    },),

                  ImageTextButtonWithIcon(imageUrl: 'resource/images/yellowButton.png',imageHeight: 160,imageWidth: 360,
                    iconUrl:'resource/images/withdraw.png',iconHeight: 130,iconWidth: 130,buttonName: '提现',textSize: 29,callback: (){
                      print('提现');
                    },),
          ],
        ),
      ),
            Container(
              width: ScreenUtil().setWidth(800),
              height: ScreenUtil().setHeight(840),
              child: ListView.builder(
                itemCount: 10,
                itemExtent: ScreenUtil().setHeight(170),
                padding: EdgeInsets.only(top:0),
                itemBuilder: (BuildContext context, int index){
                  // 获取排名数据
                  int count = index+1;
                  if (count>5){count = 5;}
                  String imageUrl = 'resource/images/rank$count.png';
                  int value = 5919-index;
                  return RankItem(imageUrl: imageUrl,avatarUrl: 'resource/images/avatar.png', rankName: '黄小龙',value: value,);
                },
              ),
            ),
      ],

    ),
    );
  }
}