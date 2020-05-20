import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class MainPage extends StatefulWidget {
  String name = "hello";
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Stack(

        children: <Widget>[
          new Image(image: new AssetImage('resource/images/mainBackgroud.png'),
            width: 1920,
            height: 1080,
            fit: BoxFit.fill,
          ),
          new ImageButton(height:ScreenUtil().setHeight(200),width: ScreenUtil().setWidth(400),buttonName: "hello",imageUrl: "resource/images/upgradeButton.png",callback: (){
//            name = "";
            Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
              'height': ScreenUtil().setHeight(1660),
              'width': ScreenUtil().setWidth(1020),
              'childName':'farmDetail'
            });
            print(this.widget.name);
          },),
        ],
      ),
    );
  }
}