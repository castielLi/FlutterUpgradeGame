import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';

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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          ///主城
          new Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(330), ScreenUtil().setHeight(660), ScreenUtil().setWidth(170), ScreenUtil().setHeight(670)),
            child: new Stack(
              children: <Widget>[
                ImageButton(height:ScreenUtil().setHeight(630),width: ScreenUtil().setWidth(600),imageUrl: "resource/images/mainBuilding.png",callback: (){
                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                    'height': ScreenUtil().setHeight(1660),
                    'width': ScreenUtil().setWidth(1020),
                    'childName':'farmDetail',
                    "title":"升 级"
                  });
                },),
                Container(
                    padding: EdgeInsets.only(top:ScreenUtil().setHeight(420)),
                    child:Center(
                      child: Text("主 城",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.mainBuildingTextFontSize),),
                    )
                )
              ],
            )
          ),
          ///英雄祭坛
          new Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(590), ScreenUtil().setHeight(1250), ScreenUtil().setWidth(170), ScreenUtil().setHeight(360)),
            child: new Stack(
              children: <Widget>[
//                ImageButton(height:ScreenUtil().setHeight(290),width: ScreenUtil().setWidth(240),imageUrl: "resource/images/herosBuilding.png",callback: (){
////            name = "";
//                  print(this.widget.name);
//                },),
                // 排行榜。暂时放到英雄祭坛
                ImageButton(height:ScreenUtil().setHeight(630),width: ScreenUtil().setWidth(600),imageUrl: "resource/images/mainBuilding.png",callback: (){
                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                    'height': ScreenUtil().setHeight(1660),
                    'width': ScreenUtil().setWidth(1020),
                    'childName':'rankDetail',
                  });
                },),
                Container(
                    padding: EdgeInsets.only(top:ScreenUtil().setHeight(190)),
                    child:Center(
                      child: Text("英雄祭坛",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.otherBuildingTextFontSize),),
                    )
                )
              ],
            )
          ),
          ///采石场
          new Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(590), ScreenUtil().setHeight(1550), ScreenUtil().setWidth(170), ScreenUtil().setHeight(80)),
            child: new Stack(
              children: <Widget>[
                ImageButton(height:ScreenUtil().setHeight(300),width: ScreenUtil().setWidth(250),imageUrl: "resource/images/stoneBuilding.png",callback: (){
//            name = "";
                  print(this.widget.name);
                },),
                Container(
                    padding: EdgeInsets.only(top:ScreenUtil().setHeight(200)),
                    child:Center(
                      child: Text("采石场",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.otherBuildingTextFontSize),),
                    )
                )

              ],
            )
          ),
          ///伐木场
          new Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(1330), ScreenUtil().setWidth(700), ScreenUtil().setHeight(300)),
            child: new Stack(
              children: <Widget>[
                ImageButton(height:ScreenUtil().setHeight(340),width: ScreenUtil().setWidth(380),imageUrl: "resource/images/fellingBuilding.png",callback: (){
//            name = "";
                  print(this.widget.name);
                },),
                Container(
                    padding: EdgeInsets.only(top:ScreenUtil().setHeight(190)),
                    child:Center(
                      child: Text("伐木场",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.otherBuildingTextFontSize),),
                    )
                )
              ],
            )
          ),
          ///农场
          new Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(980), ScreenUtil().setWidth(680), ScreenUtil().setHeight(630)),
            child: new Stack(
              children: <Widget>[
                ImageButton(height:ScreenUtil().setHeight(290),width: ScreenUtil().setWidth(340),imageUrl: "resource/images/farmBuilding.png",callback: (){
//            name = "";
                  print(this.widget.name);
                },),
                Container(
                    padding: EdgeInsets.only(top:ScreenUtil().setHeight(190)),
                    child:Center(
                      child: Text("农 场",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.otherBuildingTextFontSize),),
                    )
                )
              ],
            )
          ),
          ///市场
          new Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0), ScreenUtil().setHeight(620), ScreenUtil().setWidth(680), ScreenUtil().setHeight(990)),
            child: new Stack(
              children: <Widget>[
                ImageButton(height:ScreenUtil().setHeight(290),width: ScreenUtil().setWidth(310),imageUrl: "resource/images/marketBuilding.png",callback: (){
//            name = "";
                  print(this.widget.name);
                },),
                Container(
                    padding: EdgeInsets.only(top:ScreenUtil().setHeight(170)),
                    child:Center(
                      child: Text("市 场",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.otherBuildingTextFontSize),),
                    )
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}