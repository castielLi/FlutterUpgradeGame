import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/pages/rank/rankItem.dart';
import 'package:upgradegame/Common/app/config.dart';


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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child:
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Image(image: new AssetImage('resource/images/yellowButton.png'),height: ScreenUtil().setHeight(160),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(image: new AssetImage('resource/images/gold.png'),height: ScreenUtil().setHeight(150),),
                            Text('T币',style: CustomFontSize.textStyle30,),
                          ],
                        ),
                      ],
                    ),

                    onTap: (){print('点击T币');},
                  ),
                  GestureDetector(
//                    child:
//                    Container(
//                      decoration: BoxDecoration(
//                        image: DecorationImage(
//                          image: new AssetImage('resource/images/yellowButton.png'),
//                          fit:BoxFit.fill,
//                        ),
//                      ),
//                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Image(image: new AssetImage('resource/images/yellowButton.png'),height: ScreenUtil().setHeight(160),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(image: new AssetImage('resource/images/withdraw.png'),height: ScreenUtil().setHeight(110),),
                            Text('提现',style: CustomFontSize.textStyle30,),
                          ],
                        ),
                      ],
                    ),
                    onTap: (){print('点击提现');},
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(800),
              height: ScreenUtil().setHeight(840),
              child:
                ListView.builder(
                  itemCount: 10,
                  itemExtent: ScreenUtil().setHeight(170),
                  padding: EdgeInsets.only(top:0),
                  itemBuilder: (BuildContext context, int index){
                    // 获取排名数据
                    int count = index+1;
                    if (count>5){count = 5;}
                    String imageUrl = 'resource/images/rank$count.png';
                    int value = 5919-index;
                    return RankItem(imageUrl: imageUrl,avatarUrl: 'resource/images/avatar.png',
                    rankName: '黄小龙',value: value,);
                  },
              ),
            ),

          ],
        ),


      ),
    );
  }
}