import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/team/event/teamEventBus.dart';
import 'package:upgradegame/Src/pages/team/model/invitation.dart';
import 'package:upgradegame/Src/pages/team/model/qrCodeModel.dart';
import 'package:upgradegame/Src/pages/team/service/teamService.dart';
import 'package:upgradegame/Src/pages/team/teamContribution.dart';
import 'package:upgradegame/Src/pages/team/teamItem.dart';

import 'model/teamContributionModel.dart';

class TeamDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  TeamDetail({Key key, this.HUD}) : super(key: key);

  _TeamDetailState createState() => new _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  bool showContribution = true;
  bool showTeamMembers = false;
  List<InvitationModel> first = [];
  List<InvitationModel> second = [];
  String tabName = 'first';
  String noMembersHintText = '';
  int initFirstLength = 20;
  int initSecondLength = 20;
  bool showQRCode = false;
  bool showTeamDetail = true;
  String qrCodeUrl = "";
  GlobalKey repaintWidgetKey = GlobalKey();
  TeamContributionModel currentContribution;

  void getShareQRCode() {
    this.widget.HUD();
    TeamService.getQRCode((QRCodeModel model) {
      this.widget.HUD();
      if (model != null) {
        setState(() {
          qrCodeUrl = model.url;
        });
      }
    });
  }

  void showMyTeamDetail() {
    setState(() {
      showQRCode = false;
      showTeamDetail = true;
    });
  }

  void showQRCodeDetail() {
    this.widget.HUD();
    TeamService.getQRCode((QRCodeModel model) {
      this.widget.HUD();
      if (model != null) {
        setState(() {
          showQRCode = true;
          showTeamDetail = false;
          qrCodeUrl = model.url;
        });
      }
    });
  }

  void getMyContribution() {
    this.widget.HUD();
    TeamService.getMyContribution((TeamContributionModel model) {
      this.widget.HUD();
      if (model != null) {
        setState(() {
          this.currentContribution = model;
        });
      }
    });
  }

  void getTeamList() {
    this.widget.HUD();

    TeamService.getTeamList((data) {
      setState(() {
        first = InvitationListModel.fromJson(data).first;
        second = InvitationListModel.fromJson(data).second;
        this.noMembersHintText = '还没有团队成员';
      });
    });
    this.widget.HUD();
  }

  @override
  void initState() {
    super.initState();
    TeamHttpRequestEvent().on("getTeamList", this.getTeamList);
    TeamHttpRequestEvent().on("getMyContribution", this.getMyContribution);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.getMyContribution();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    TeamHttpRequestEvent().off();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(0)),
      child: Column(
        children: [
          ButtonsList(
            buttonWidth: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
            buttonHeight: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
            buttonBackgroundImageUrl: 'resource/images/teamSwitchBackground.png',
            textSize: ScreenUtil().setSp(SystemButtonSize.largeButtonFontSize),
            buttons: [
              ImageTextButton(
                buttonName: '贡 献',
                callback: () {
                  setState(() {
                    this.showContribution = true;
                    this.showTeamMembers = false;
                  });
                  TeamHttpRequestEvent().emit("getMyContribution");
                },
              ),
              ImageTextButton(
                buttonName: '成 员',
                callback: () {
                  setState(() {
                    this.showContribution = false;
                    this.showTeamMembers = true;
                  });
                  TeamHttpRequestEvent().emit("getTeamList");
                },
              ),
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(1020),
            child: Stack(
              children: [
                ///贡献
                Offstage(
                  offstage: !showContribution,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TeamContribution(
                          title: '今日',
                          total: this.currentContribution == null ? 0 : this.currentContribution.today.total,
                          my: this.currentContribution == null ? 0 : this.currentContribution.today.my,
                          exchange: this.currentContribution == null ? 0 : this.currentContribution.today.exchange,
                          secondGrade: this.currentContribution == null ? 0 : this.currentContribution.today.first,
                          thirdGrade: this.currentContribution == null ? 0 : this.currentContribution.today.second,
                        ),
                        TeamContribution(
                          title: '昨日',
                          total: this.currentContribution == null ? 0 : this.currentContribution.yesterday.total,
                          my: this.currentContribution == null ? 0 : this.currentContribution.yesterday.my,
                          exchange: this.currentContribution == null ? 0 : this.currentContribution.yesterday.exchange,
                          secondGrade: this.currentContribution == null ? 0 : this.currentContribution.yesterday.first,
                          thirdGrade: this.currentContribution == null ? 0 : this.currentContribution.yesterday.second,
                        ),
                      ],
                    ),
                  ),
                ),

                /// 成员
                Offstage(
                  offstage: !showTeamMembers,
                  child: Stack(
                    children: <Widget>[
                      Offstage(
                        offstage: !this.showTeamDetail,
                        child: Column(
                          children: <Widget>[
                            ButtonsList(
                              buttonWidth: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                              buttonHeight: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                              buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
                              textSize: ScreenUtil().setSp(SystemButtonSize.smallButtonFontSize),
                              buttons: [
                                ImageTextButton(
                                  buttonName: '徒弟',
                                  callback: () {
                                    changeTabs('first');
                                  },
                                ),
                                ImageTextButton(
                                  buttonName: '徒孙',
                                  callback: () {
                                    changeTabs('second');
                                  },
                                ),
                              ],
                            ),
                            second.length == 0 && first.length == 0
                                ? Container(
                                    //内容高度减去两列按钮高度
                                    height: ScreenUtil().setHeight(1020 - SystemButtonSize.smallButtonHeight - SystemButtonSize.largeButtonHeight),
                                    child: Text(
                                      noMembersHintText,
                                      textAlign: TextAlign.center,
                                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                    ),
                                  )
                                : Container(
                                    height: ScreenUtil().setHeight(1020 - SystemButtonSize.smallButtonHeight - SystemButtonSize.largeButtonHeight),
                                    child: Column(
                                      children: [
                                        Text(
                                          'first' == this.tabName ? '当前徒弟团队成员共有' + first.length.toString() + '名' : '当前徒孙团队成员共有' + second.length.toString() + '名',
                                          textAlign: TextAlign.center,
                                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                        ),
                                        Container(
                                          // height: ScreenUtil().setHeight(100),
                                          margin: EdgeInsets.only(left: ScreenUtil().setWidth(70)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                '用户',
                                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                              ),
                                              Text(
                                                '现金 贡献值',
                                                style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //内容高度减去两列按钮加标题栏高度
                                          height: ScreenUtil().setHeight(1020 - SystemButtonSize.smallButtonHeight - SystemButtonSize.largeButtonHeight - 150),
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
                                                  child: ListView.builder(
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
                                                    child: second.length == 0
                                                        ? Text(
                                                            '还没有团队成员',
                                                            textAlign: TextAlign.center,
                                                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                                          )
                                                        : ListView.builder(
                                                            itemCount: second.length > initSecondLength ? initSecondLength : second.length,
                                                            padding: EdgeInsets.all(1.0),
                                                            itemBuilder: (BuildContext context, int index) {
                                                              // if(2==index){
                                                              //   print(second[index].displayname);
                                                              // }
                                                              print(second.length);
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
                          children: <Widget>[
                            RepaintBoundary(
                              key: repaintWidgetKey,
                              child: FadeInImage.assetNetwork(placeholder: "", image: this.qrCodeUrl),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ImageButton(
                                  height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                                  width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                                  buttonName: "返 回",
                                  imageUrl: "resource/images/upgradeButton.png",
                                  callback: () {
                                    this.showMyTeamDetail();
                                  },
                                ),
                                ImageButton(
                                  height: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                                  width: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                                  buttonName: "分享微信",
                                  imageUrl: "resource/images/upgradeButton.png",
                                  callback: () {
                                    this.widget.HUD();
                                    TeamService.shareImageToWeChat(this.repaintWidgetKey, (File file, String desc) {
                                      this.widget.HUD();
                                      fluwx.WeChatImage image = fluwx.WeChatImage.file(file);
                                      fluwx.shareToWeChat(fluwx.WeChatShareImageModel(image, description: desc, scene: fluwx.WeChatScene.SESSION));
                                    });
                                    print('点击分享微信');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
