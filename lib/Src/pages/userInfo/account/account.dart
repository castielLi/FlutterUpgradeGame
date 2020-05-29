import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;
  AccountDetail({Key key,this.HUD,this.viewCallback}):super(key:key);
  _AccountDetailState createState() => new _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(0),   // 左
          ScreenUtil().setHeight(120),  // 上
          ScreenUtil().setWidth(0),   // 右
          ScreenUtil().setHeight(150),
      ),
      color:Colors.lightBlue,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(),
//          TextField(),
        ],
      ),
//      Stack(
//        children: <Widget>[
//          new Container(
//            child:Center(
//              child:
//              new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "返回",imageUrl: "resource/images/upgradeButton.png",callback: (){
//                print('点击升级');
////                this.widget.HUD();
//                this.widget.viewCallback();
//              },),
//            ),
//          ),
//        ],
//      ),
    );
  }
}