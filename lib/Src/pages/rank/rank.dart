import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(120),   // 左
            ScreenUtil().setHeight(400),  // 上
            ScreenUtil().setWidth(120),   // 右
            ScreenUtil().setHeight(220)), // 下
        color: Colors.blue,
        child:ListView.builder(
            itemCount: 10,
//                itemExtent: 30,
            itemBuilder: (BuildContext context, int index){
              return ListTile(title: Text("$index"));
            }
        ),


//        new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text('T币 提现'),
//            ListView.builder(
//                itemCount: 10,
////                itemExtent: 30,
//                itemBuilder: (BuildContext context, int index){
//                  return ListTile(title: Text("$index"));
//                }
//            ),
//          ],
//        ),
      ),
    );
  }
}