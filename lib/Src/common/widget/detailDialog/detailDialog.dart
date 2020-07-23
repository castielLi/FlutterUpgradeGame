import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/pages/adDividend/adDividendDetail.dart';
import 'package:upgradegame/Src/pages/announcement/announcement.dart';
import 'package:upgradegame/Src/pages/contribution/contribution.dart';
import 'package:upgradegame/Src/pages/farm/farm.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/heroAltar/heroAltar.dart';
import 'package:upgradegame/Src/pages/mainBuilding/mainBuilding.dart';
import 'package:upgradegame/Src/pages/rank/rank.dart';
import 'package:upgradegame/Src/pages/sawmill/sawmill.dart';
import 'package:upgradegame/Src/pages/stone/stone.dart';
import 'package:upgradegame/Src/pages/setting/setting.dart';
import 'package:upgradegame/Src/pages/team/team.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/pages/userInfo/userInfo.dart';
import 'package:upgradegame/Src/pages/store/store.dart';
import 'package:upgradegame/Src/pages/market/market.dart';
import 'package:progress_hud/progress_hud.dart';

class DetailDialog extends StatefulWidget {
  double height;
  double width;
  String childWidgetName;
  String title;

  DetailDialog({Key key, this.height, this.width, this.childWidgetName, this.title = ""}) : super(key: key);

  @override
  _DetailDialogState createState() => new _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {
  ProgressHUD _progressHUD;
  bool _loading = false;
  String currentDisplayTitle = "";

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

    void changeCurrentDialogTitle(String title) {
      setState(() {
        currentDisplayTitle = title;
      });
    }

    void displayOriginalTitle() {
      setState(() {
        currentDisplayTitle = this.widget.title;
      });
    }

    Widget currentWidget;
    switch (this.widget.childWidgetName) {
      // 主城
      case 'mainBuildingDetail':
        {
          currentWidget = new MainBuildingDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 伐木场
      case 'sawmillDetail':
        {
          currentWidget = new SawmillDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 采石场
      case 'stoneDetail':
        {
          currentWidget = new StoneDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 英雄祭坛
      case 'heroAltar':
        {
          currentWidget = new HeroAltar(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 农场
      case 'farmDetail':
        {
          currentWidget = new FarmDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 排行榜
      case 'rankDetail':
        {
          currentWidget = new RankDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      case 'settingDetail':
        {
          currentWidget = new SettingDetail(
            HUD: showOrDismissProgressHUD,
            changeTitleCallback: changeCurrentDialogTitle,
            displayOriginalTitleCallback: displayOriginalTitle,
          );
          break;
        }
      // 团队
      case 'teamDetail':
        {
          currentWidget = new TeamDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      case 'userInfoDetail':
        {
          currentWidget = new UserInfoDetail(
            HUD: showOrDismissProgressHUD,
            changeTitleCallback: changeCurrentDialogTitle,
            displayOriginalTitleCallback: displayOriginalTitle,
          );
          break;
        }
      case 'storeDetail':
        {
          currentWidget = new StoreDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 分红
      case 'adDividendDetail':
        {
          currentWidget = new AdDividendDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      case 'marketDetail':
        {
          currentWidget = new MarketDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 公告
      case 'announcementDetail':
        {
          currentWidget = new AnnouncementDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
      // 贡献值
      case 'contributionDetail':
        {
          currentWidget = new ContributionDetail(
            HUD: showOrDismissProgressHUD,
          );
          break;
        }
    }

    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().setWidth(1080),
          height: ScreenUtil().setHeight(1920),
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage('resource/images/dialogBackgroundImage.png'), fit: BoxFit.cover),
          ),
          child: new Container(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB((ScreenUtil().setWidth(1080) - this.widget.width) / 2, (ScreenUtil().setHeight(1920) - this.widget.height) / 2,
                  (ScreenUtil().setWidth(1080) - this.widget.width) / 2, (ScreenUtil().setHeight(1920) - this.widget.height) / 2),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: new Image(
                      image: new AssetImage('resource/images/detailDialogbackgroundImage.png'),
                      fit: BoxFit.fill,
                      height: widget.height,
                      width: widget.width,
                    ),
                  ),
                  Container(
                      height: ScreenUtil().setHeight(380),
                      child: Center(
                        child: Text(
                          this.currentDisplayTitle == "" ? this.widget.title : this.currentDisplayTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.detailDialogTitleTextFontSize)),
                        ),
                      )),
                  Container(
                    height: ScreenUtil().setHeight(200),
                    width: this.widget.height,
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(820)),
                    child: ImageButton(
                        height: ScreenUtil().setHeight(140),
                        width: ScreenUtil().setWidth(140),
                        imageUrl: "resource/images/cancelDialog.png",
                        callback: () {
                          Application.router.pop(context);
                        }),
                  ),
                  currentWidget,
                  _progressHUD,
                ],
              )),
        ),
      ),
    );
  }
}
