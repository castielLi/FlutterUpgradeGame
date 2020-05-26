import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/pages/AdDividend/adDividendDetail.dart';
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
import 'package:upgradegame/Src/pages/userInfo/userInfo.dart';
import 'package:upgradegame/Src/pages/store/store.dart';
import 'package:upgradegame/Src/pages/adDividend/adDividend.dart';
import 'package:upgradegame/Src/pages/market/market.dart';
import 'package:progress_hud/progress_hud.dart';


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

  ProgressHUD _progressHUD;

  bool _loading = false;

  void initState() {
    super.initState();

    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: '',
      loading: false,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    void showOrDismissProgressHUD() {
      setState(() {
        if (_loading) {
          _progressHUD.state.dismiss();
        } else {
          _progressHUD.state.show();
        }

        _loading = !_loading;
      });
    }


    Widget currentWidget;
    switch(this.widget.childWidgetName){
      // 主城
      case 'mainBuildingDetail':{
        currentWidget = new MainBuildingDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      // 伐木场
      case 'sawmillDetail':{
        currentWidget = new SawmillDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      // 采石场
      case 'stoneDetail':{
        currentWidget = new StoneDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      // 农场
      case 'farmDetail':{
        currentWidget = new FarmDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      // 排行榜
      case 'rankDetail':{
        currentWidget = new RankDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      // 团队
      case 'teamDetail':{
        currentWidget = new TeamDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      case 'settingDetail':{
        currentWidget = new SettingDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      // 团队
      case 'teamDetail':{
        currentWidget = new TeamDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      case 'userInfoDetail':{
        currentWidget = new UserInfoDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      case 'storeDetail':{
        currentWidget = new StoreDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      case 'adDividendDetail':{
        currentWidget = new adDividendDetail(HUD: showOrDismissProgressHUD,);
        break;
      }
      case 'marketDetail':{
        currentWidget = new MarketDetail(HUD: showOrDismissProgressHUD,);
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
                    currentWidget,
                    _progressHUD,
                  ],
                )
            ),
    );
  }
}