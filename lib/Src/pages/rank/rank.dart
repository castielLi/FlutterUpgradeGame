import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/adIconRow/adIconRow.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';


class RankDetail extends StatefulWidget {

  @override
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
    var textStyle = TextStyle(fontSize: 30.0, color: Colors.white,
        decoration: TextDecoration.none);

    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(120),   // 左
            ScreenUtil().setHeight(400),  // 上
            ScreenUtil().setWidth(120),   // 右
            ScreenUtil().setHeight(220)), // 下
//        color: Colors.blue,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.red,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child:
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Image(image: new AssetImage('resource/images/yellowButton.png'),height: 60,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(image: new AssetImage('resource/images/gold.png'),height: 45,),
                            Text('T币',style: textStyle,),
                          ],
                        ),
                      ],
                    ),

                    onTap: (){print('点击T币');},
                  ),
                  GestureDetector(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Image(image: new AssetImage('resource/images/yellowButton.png'),height: 60,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image(image: new AssetImage('resource/images/withdraw.png'),height: 40,),
                            Text('提现',style: textStyle,),
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
              color: Colors.blue,
              child:
//              Text('提现',style: textStyle,),

              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemExtent: 30,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(title: Text("$index",style: textStyle,));
                  },
              ),
            ),

          ],
        ),


      ),
    );
  }
}