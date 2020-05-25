import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/main/common/resourceWidget.dart';
import 'package:upgradegame/Src/pages/main/common/userImageButton.dart';
import 'package:upgradegame/Src/pages/main/common/dividendPart.dart';

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
          ///资源栏
          new Container(
            height: ScreenUtil().setHeight(250),
            child: new Row(
              children: <Widget>[
                new Expanded(child:new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(80), ScreenUtil().setWidth(20), ScreenUtil().setHeight(20)),
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(child: new ResourceWidget(
                        amount: "100000100",
                        size: ScreenUtil().setHeight(130),
                        imageUrl: "resource/images/gold.png",
                      ),flex: 1,),
                      new Expanded(child: new ResourceWidget(
                        amount: "100000",
                        size: ScreenUtil().setHeight(130),
                        imageUrl: "resource/images/wood.png",
                      ),flex: 1,),
                      new Expanded(child: new ResourceWidget(
                        amount: "100000",
                        size: ScreenUtil().setHeight(130),
                        imageUrl: "resource/images/stone.png",
                      ),flex: 1,)
                    ],
                  ),
                ),
                flex: 7,),
                new Expanded(child: new Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                  height: ScreenUtil().setHeight(150),
                  child: new Stack(
                    children: <Widget>[
                      new Image(image: new AssetImage('resource/images/userInfo.png'),
                        fit: BoxFit.fill,
                      ),
                      new Center(
                        child:
                        new UserImageButton(size:ScreenUtil().setHeight(150),buttonName: ""
                          ,textSize: SystemFontSize.operationTextFontSize,imageUrl: "resource/images/avatar.png",callback: (){
                            Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                              'height': ScreenUtil().setHeight(1660),
                              'width': ScreenUtil().setWidth(1020),
                              'childName':'userInfoDetail',
                              "title":"个人信息"
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
                ,flex: 2,)
              ],
            ),
          ),
          ///功能栏
          new Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(230)),
            height: ScreenUtil().setHeight(180),
            child: new Row(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                  child: new Row(
                    children: <Widget>[
                      new UserImageButton(size:ScreenUtil().setHeight(150),buttonName: "排行榜"
                        ,imageUrl: "resource/images/rank.png",textSize: SystemFontSize.operationTextFontSize,callback: (){
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                            'height': ScreenUtil().setHeight(1660),
                            'width': ScreenUtil().setWidth(1020),
                            'childName':'rankDetail',
                            "title":"排行榜",
                          });
                        },),
                      new UserImageButton(size:ScreenUtil().setHeight(150),buttonName: "团队"
                        ,textSize: SystemFontSize.operationTextFontSize,imageUrl: "resource/images/team.png",callback: (){
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                            'height': ScreenUtil().setHeight(1660),
                            'width': ScreenUtil().setWidth(1020),
                            'childName':'teamDetail',
                            "title":"团 队"
                          });
                        },),
                      new UserImageButton(size:ScreenUtil().setHeight(150),buttonName: "商城"
                        ,textSize: SystemFontSize.operationTextFontSize,imageUrl: "resource/images/marketStores.png",callback: (){
                        },),

                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                  width: ScreenUtil().setWidth(380),
                  child: new DividendPart(imageTitle: "分红",imageUrl:"resource/images/dividend.png",
                  imageHeight: ScreenUtil().setHeight(140),imageWidth: ScreenUtil().setWidth(150),
                  title: "今日分红",amount: "¥100000",),
                ),
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new UserImageButton(size:ScreenUtil().setHeight(130),buttonName: "设置"
                        ,textSize: SystemFontSize.operationTextFontSize,imageUrl: "resource/images/setting.png",callback: (){
                          Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                            'height': ScreenUtil().setHeight(1660),
                            'width': ScreenUtil().setWidth(1020),
                            'childName':'settingDetail',
                            "title":"设 置"
                          });
                        },
                      ),
                      new UserImageButton(size:ScreenUtil().setHeight(130),buttonName: "公告"
                        ,textSize: SystemFontSize.operationTextFontSize,imageUrl: "resource/images/announcement.png",callback: (){
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                    'childName':'mainBuildingDetail',
                    "title":"主 城"
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
                ImageButton(height:ScreenUtil().setHeight(630),width: ScreenUtil().setWidth(600),imageUrl: "resource/images/herosBuilding.png",callback: (){
                  print('英雄祭坛');
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
                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                    'height': ScreenUtil().setHeight(1660),
                    'width': ScreenUtil().setWidth(1020),
                    'childName':'stoneDetail',
                    "title":"采石场",
                  });
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
                ImageButton(height:ScreenUtil().setHeight(630),width: ScreenUtil().setWidth(600),imageUrl: "resource/images/fellingBuilding.png",callback: (){
                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                    'height': ScreenUtil().setHeight(1660),
                    'width': ScreenUtil().setWidth(1020),
                    'childName':'sawmillDetail',
                    "title":"伐木场",
                  });
                },),
//                ImageButton(height:ScreenUtil().setHeight(340),width: ScreenUtil().setWidth(380),imageUrl: "resource/images/fellingBuilding.png",callback: (){
////            name = "";
//                  print(this.widget.name);
//                },),
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
                  Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage,params:{
                    'height': ScreenUtil().setHeight(1660),
                    'width': ScreenUtil().setWidth(1020),
                    'childName':'farmDetail',
                    "title":"农 场"
                  });
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