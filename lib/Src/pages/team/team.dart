import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/team/model/invitation.dart';
import 'package:upgradegame/Src/pages/team/model/qrCodeModel.dart';
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
  String tabName = 'first';
  bool hideTeamResult = true;
  int initFirstLength = 20;
  int initSecondLength = 20;
  bool showQRCode = false;
  bool showTeamDetail = true;
  String qrCodeUrl = "";


  void getShareQRCode(){
    this.widget.HUD();
    TeamService.getQRCode((QRCodeModel model){
      this.widget.HUD();
      if(model != null){
        setState(() {
          qrCodeUrl = model.url;
        });
      }
    });
  }

  void showMyTeamDetail(){
    setState(() {
      showQRCode = false;
      showTeamDetail = true;
    });
  }

  void showQRCodeDetail(){
    setState(() {
      showQRCode = true;
      showTeamDetail = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      TeamService.getTeamList((data) {
        setState(() {
          first = InvitationListModel.fromJson(data).first;
          second = InvitationListModel.fromJson(data).second;
          hideTeamResult = false;
        });
      });
      this.widget.HUD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(400), ScreenUtil().setWidth(100), ScreenUtil().setHeight(200)),
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !this.showTeamDetail,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonsList(
                  buttonWidth: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                  buttonHeight: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                  buttonBackgroundImageUrl: 'resource/images/teamSwitchBackground.png',
                  textSize: SystemFontSize.settingTextFontSize,
                  buttons: [
                    ImageTextButton(
                      buttonName: '徒 弟',
                      callback: () {
                        changeTabs('first');
                      },
                    ),
                    ImageTextButton(
                      buttonName: '徒 孙',
                      callback: () {
                        changeTabs('second');
                      },
                    ),
                  ],
                ),
                second.length == 0 && first.length == 0
                    ? Container(
                  height: ScreenUtil().setHeight(730),
                  child: Offstage(
                    offstage: hideTeamResult,
                    child: Text(
                      '还没有团队成员',
                      textAlign: TextAlign.center,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ),
                )
                    : Container(
                  height: ScreenUtil().setHeight(730),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: ScreenUtil().setWidth(70)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '用户',
                              style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                            ),
                            Text(
                              '现金 T币',
                              style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: ScreenUtil().setHeight(640),
                        child: Stack(
                          children: [
                            Offstage(
                              offstage: tabName != 'first',
                              child: EasyRefresh(
                                refreshFooter: ClassicsFooter(
                                  bgColor: Colors.transparent,
                                  loadText: "上滑加载",
                                  loadReadyText: "松开加载",
                                  loadingText: "正在加载",
                                  loadedText: "加载完成",
                                  noMoreText: "没有更多了",
                                  loadHeight: 35,
                                  key: new GlobalKey<RefreshFooterState>(),
                                ),
                                refreshHeader: ClassicsHeader(
                                  bgColor: Colors.transparent,
                                  refreshText: "下拉刷新",
                                  refreshReadyText: "松开刷新",
                                  refreshingText: "正在刷新",
                                  refreshedText: "刷新完成",
                                  refreshHeight: 35,
                                  key: new GlobalKey<RefreshHeaderState>(),
                                ),
                                // ignore: missing_return
                                loadMore: () {
                                  setState(() {
                                    initFirstLength += 20;
                                  });
                                },
                                child: first.length == 0
                                    ? Text(
                                  '还没有团队成员',
                                  textAlign: TextAlign.center,
                                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                )
                                    : ListView.builder(
                                  itemCount: first.length > initFirstLength ? initFirstLength : first.length,
                                  padding: EdgeInsets.all(1.0),
                                  itemBuilder: (BuildContext context, int index) {
                                    return TeamItem(
                                      invite: first[index],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Offstage(
                                offstage: tabName != 'second',
                                child: EasyRefresh(
                                  refreshFooter: ClassicsFooter(
                                    bgColor: Colors.transparent,
                                    loadText: "上滑加载",
                                    loadReadyText: "松开加载",
                                    loadingText: "正在加载",
                                    loadedText: "加载完成",
                                    noMoreText: "没有更多了",
                                    loadHeight: 35,
                                    key: new GlobalKey<RefreshFooterState>(),
                                  ),
                                  refreshHeader: ClassicsHeader(
                                    bgColor: Colors.transparent,
                                    refreshText: "下拉刷新",
                                    refreshReadyText: "松开刷新",
                                    refreshingText: "正在刷新",
                                    refreshedText: "刷新完成",
                                    refreshHeight: 35,
                                    key: new GlobalKey<RefreshHeaderState>(),
                                  ),
                                  // ignore: missing_return
                                  loadMore: () {
                                    setState(() {
                                      initSecondLength += 20;
                                    });
                                  },
                                  child: ListView.builder(
                                    itemCount: second.length > initSecondLength ? initSecondLength : second.length,
                                    padding: EdgeInsets.all(1.0),
                                    itemBuilder: (BuildContext context, int index) {
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
                  height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                  width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                  buttonName: "邀 请",
                  imageUrl: "resource/images/upgradeButton.png",
                  callback: () {
                    print('点击邀请');
                    this.showQRCodeDetail();
                  },
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !this.showQRCode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FadeInImage.assetNetwork(
                    placeholder: "resource/images/defaultAvatar.png",
                    image: this.qrCodeUrl),
                new Row(
                  children: <Widget>[
                    ImageButton(
                      height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                      width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                      buttonName: "返 回",
                      imageUrl: "resource/images/upgradeButton.png",
                      callback: () {
                        print('点击邀请');
                        this.showMyTeamDetail();
                      },
                    ),
                    ImageButton(
                      height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                      width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                      buttonName: "分享微信",
                      imageUrl: "resource/images/upgradeButton.png",
                      callback: () {
                        print('点击邀请');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changeTabs(String tab) {
    setState(() {
      tabName = tab;
    });
  }
}
