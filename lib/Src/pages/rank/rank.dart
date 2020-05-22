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
    var textStyle = TextStyle(fontSize: 32.0, color: Colors.white,
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
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child:
//                      Stack(
//                        children: <Widget>[
//                          Image(image: new AssetImage('resource/images/rank/yellowButton.png'),
////                            width: MediaQuery.of(context).size.width,
////                            height: MediaQuery.of(context).size.height,
////                            fit: BoxFit.fill,
//                          ),
////                          Row(
////                            children: <Widget>[
////                              Image(image: new AssetImage('resource/images/rank/coin.png'),height: 40,),
//////                              Text('T币'),
////                            ],
////                          ),
//                        ],
//                      ),
                    new Image(image: new AssetImage('resource/images/rank/yellowButton.png'),height: 50,),
                    onTap: (){print('点击T币');},
                  ),
//                  GestureDetector(
//                    child: new Image(image: new AssetImage('resource/images/stone.png'),height: 50,),
//                    onTap: (){print('点击提现');},
//                  ),
                ],
              ),
            ),
//            Container(
//              child:ListView.builder(
//                  itemBuilder: null
//              ),
//            ),

          ],
        ),


      ),
    );
  }
}