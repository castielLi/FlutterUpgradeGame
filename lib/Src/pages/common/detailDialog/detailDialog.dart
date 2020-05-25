import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/pages/farm/farm.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/mainBuilding/mainBuilding.dart';
import 'package:upgradegame/Src/pages/rank/rank.dart';
import 'package:upgradegame/Src/pages/sawmill/sawmill.dart';
import 'package:upgradegame/Src/pages/stone/stone.dart';
import 'package:upgradegame/Src/pages/setting/setting.dart';
import 'package:upgradegame/Src/pages/team/team.dart';
import 'package:upgradegame/Src/route/application.dart';

class DetailDialog extends StatefulWidget {

  double height;
  double width;
  String childWidgetName;
  String title;
  DetailDialog({Key key,this.height,this.width,this.childWidgetName,this.title=""}):super(key:key);


  @override
  _DetailDialogState createState() => new _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    Widget currentWidget;
    switch(this.widget.childWidgetName){
      // 主城
      case 'mainBuildingDetail':{
        currentWidget = new MainBuildingDetail();
        break;
      }
      // 伐木场
      case 'sawmillDetail':{
        currentWidget = new SawmillDetail();
        break;
      }
      // 采石场
      case 'stoneDetail':{
        currentWidget = new StoneDetail();
        break;
      }
      // 农场
      case 'farmDetail':{
        currentWidget = new FarmDetail();
        break;
      }
      // 排行榜
      case 'rankDetail':{
        currentWidget = new RankDetail();
        break;
      }
      // 团队
      case 'teamDetail':{
        currentWidget = new TeamDetail();
        break;
      }
      case 'settingDetail':{
        currentWidget = new SettingDetail();
        break;
      }
    }

    return new Container(
      child: new Container(
          margin: EdgeInsets.fromLTRB((ScreenUtil().setWidth(1080) - this.widget.width)/2,
              (ScreenUtil().setHeight(1920) - this.widget.height)/2,
              (ScreenUtil().setWidth(1080) - this.widget.width)/2,
              (ScreenUtil().setHeight(1920) - this.widget.height)/2),
              child:Stack(
                children: <Widget>[
                  Center(
                    child:
                    new Image(image: new AssetImage('resource/images/detailDialogbackgroundImage.png'),
                      fit: BoxFit.fill,
                      height: widget.height ,
                      width: widget.width,
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(380),
                      child:Center(
                        child: Text(this.widget.title,textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.detailDialogTitleTextFontSize),),
                      )
                  ),
                   Container(
                     height: ScreenUtil().setHeight(200),
                     width: this.widget.height,
                     padding: EdgeInsets.only(left: ScreenUtil().setWidth(820)),
                     child: ImageButton(height:ScreenUtil().setHeight(140),width: ScreenUtil().setWidth(140),imageUrl: "resource/images/cancelDialog.png",callback: () {
                          Application.router.pop(context);
                     }),
                   ),
                   currentWidget
                ],
              )
        ),
    );
  }
}