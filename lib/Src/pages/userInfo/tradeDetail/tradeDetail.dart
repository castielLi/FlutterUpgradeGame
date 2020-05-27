import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class TradeDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;
  TradeDetail({Key key,this.HUD,this.viewCallback}):super(key:key);
  _TradeDetailState createState() => new _TradeDetailState();
}

class _TradeDetailState extends State<TradeDetail> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          new Container(
            child:Center(
              child:
              new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "升 级",imageUrl: "resource/images/upgradeButton.png",callback: (){
                print('点击升级');
//                this.widget.HUD();
                this.widget.viewCallback();
              },),
            ),
          ),
        ],
      ),
    );
  }
}