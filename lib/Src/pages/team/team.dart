import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/team/model/invitation.dart';
import 'package:upgradegame/Src/pages/team/service/teamService.dart';
import 'package:upgradegame/Src/pages/team/teamItem.dart';

class TeamDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  TeamDetail({Key key, this.HUD}) : super(key: key);

  _TeamDetailState createState() => new _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  List<InvitationModel> first = [];
  List<InvitationModel> second = [];
  bool hideFirstTab = false;
  bool hideSecondTab = true;
  bool hideTeamResult = true;
  int initFirstLength = 20;
  int initSecondLength = 20;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      TeamService.getTeamList().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            first = InvitationListModel.fromJson(data.data).first;
            second = InvitationListModel.fromJson(data.data).second;
            hideTeamResult = false;
          });
        } else {
          CommonUtils.showErrorMessage(msg: "网络请求失败，请重试");
        }
        this.widget.HUD();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(100),
          ScreenUtil().setHeight(400),
          ScreenUtil().setWidth(100),
          ScreenUtil().setHeight(200)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Expanded(
                  child: new ImageTextButton(
                    imageUrl: "resource/images/teamSwitchBackground.png",
                    imageWidth: ScreenUtil()
                        .setWidth(SystemIconSize.mediumButtonWithIconWidth),
                    imageHeight: ScreenUtil().setHeight(
                        SystemIconSize.mediumButtonWithIconWidth / 2),
                    buttonName: "徒 弟",
                    textSize: SystemFontSize.settingTextFontSize,
                    callback: () {
                      setState(() {
                        hideFirstTab = false;
                        hideSecondTab = true;
                      });
                    },
                  ),
                ),
                new Expanded(
                  child: new ImageTextButton(
                    imageUrl: "resource/images/teamSwitchBackground.png",
                    imageWidth: ScreenUtil()
                        .setWidth(SystemIconSize.mediumButtonWithIconWidth),
                    imageHeight: ScreenUtil().setHeight(
                        SystemIconSize.mediumButtonWithIconWidth / 2),
                    buttonName: "徒 孙",
                    textSize: SystemFontSize.settingTextFontSize,
                    callback: () {
                      setState(() {
                        hideFirstTab = true;
                        hideSecondTab = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          (hideFirstTab && second.length == 0) ||
                  (hideSecondTab && first.length == 0)
              ? Container(
                  height: ScreenUtil().setHeight(730),
                  child: Offstage(
                    offstage: hideTeamResult,
                    child: Text(
                      '团队成员还为0',
                      textAlign: TextAlign.center,
                      style: CustomFontSize.defaultTextStyle(
                          SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ),
                )
              : Container(
                  height: ScreenUtil().setHeight(730),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(120)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '日期',
                              style: CustomFontSize.defaultTextStyle(55),
                            ),
                            Text(
                              '现金 T币',
                              style: CustomFontSize.defaultTextStyle(55),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(640),
                        child: Stack(
                          children: [
                            Offstage(
                              offstage: hideFirstTab,
                              child: EasyRefresh(
                                refreshFooter: ClassicsFooter(
                                  bgColor: Colors.transparent,
                                  key: new GlobalKey<RefreshFooterState>(),
                                ),
                                // ignore: missing_return
                                loadMore: () {
                                  setState(() {
                                    initFirstLength += 20;
                                  });
                                },
                                child: first.length == 0
                                    ? Text(
                                        '团队成员还为0',
                                        textAlign: TextAlign.center,
                                        style: CustomFontSize.defaultTextStyle(
                                            SystemFontSize
                                                .moreMoreLargerTextSize),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            first.length > initFirstLength
                                                ? initFirstLength
                                                : first.length,
                                        padding: EdgeInsets.all(1.0),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return TeamItem(
                                            invite: first[index],
                                          );
                                        },
                                      ),
                              ),
                            ),
                            Offstage(
                                offstage: hideSecondTab,
                                child: EasyRefresh(
                                  refreshFooter: ClassicsFooter(
                                    bgColor: Colors.transparent,
                                    key: new GlobalKey<RefreshFooterState>(),
                                  ),
                                  // ignore: missing_return
                                  loadMore: () {
                                    setState(() {
                                      initSecondLength += 20;
                                    });
                                  },
                                  child: ListView.builder(
                                    itemCount: second.length > initSecondLength
                                        ? initSecondLength
                                        : second.length,
                                    padding: EdgeInsets.all(1.0),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TeamItem(
                                        invite: second[index],
                                      );
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          new ImageButton(
            height: ScreenUtil().setHeight(150),
            width: ScreenUtil().setWidth(400),
            buttonName: "邀 请",
            imageUrl: "resource/images/upgradeButton.png",
            callback: () {
              print('点击邀请');
            },
          ),
        ],
      ),
    );
  }
}
