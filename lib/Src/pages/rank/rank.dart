import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/pages/rank/model/rankModel.dart';
import 'package:upgradegame/Src/pages/rank/rankItem.dart';
import 'package:upgradegame/Src/pages/rank/service/rankService.dart';

class RankDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  RankDetail({Key key, this.HUD}) : super(key: key);

  _RankDetailState createState() => new _RankDetailState();
}

class _RankDetailState extends State<RankDetail> {
  List<RankCoinModel> coinList = [];
  List<RankCashModel> incomeList = [];
  List<RankMainBuildModel> mainBuildList = [];
  String tabName = 'coin';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      RankService.getRankList((data) {
        if (null != data) {
          setState(() {
            coinList = RankListModel.fromJson(data).coinList;
            incomeList = RankListModel.fromJson(data).incomeList;
            mainBuildList = RankListModel.fromJson(data).mainbuildList;
          });
        }
      });
      this.widget.HUD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(250)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonsList(
            buttonWidth: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
            buttonHeight: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
            iconWidth: ScreenUtil().setWidth(SystemIconSize.smallIconSize),
            iconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
            buttonBackgroundImageUrl: 'resource/images/yellowButton.png',
            textSize: ScreenUtil().setSp(SystemButtonSize.smallButtonFontSize),
            buttons: [
              ImageTextButton(
                buttonName: '金币',
                iconUrl: 'resource/images/coin.png',
                callback: () {
                  changeTabs('coin');
                },
              ),
              ImageTextButton(
                buttonName: '提现',
                iconUrl: 'resource/images/withdraw.png',
                callback: () {
                  changeTabs('income');
                },
              ),
              ImageTextButton(
                buttonName: '主城',
                iconUrl: 'resource/images/mainBuildingSmallIcon.png',
                callback: () {
                  changeTabs('mainBuild');
                },
              ),
            ],
          ),
          Container(
            height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
            child: Stack(
              children: [
                Offstage(
                  offstage: tabName != 'coin',
                  child: ListView.builder(
                    itemCount: coinList.length,
                    itemExtent: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (BuildContext context, int index) {
                      int count = index + 1;
                      if (count > 5) {
                        count = 5;
                      }
                      String imageUrl = 'resource/images/rank$count.png';
                      return RankItem(
                        imageUrl: imageUrl,
                        avatarUrl: 'resource/images/avatar.png',
                        rankName: coinList[index].displayname,
                        value: coinList[index].amount,
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage: tabName != 'income',
                  child: ListView.builder(
                    itemCount: incomeList.length,
                    itemExtent: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (BuildContext context, int index) {
                      int count = index + 1;
                      if (count > 5) {
                        count = 5;
                      }
                      String imageUrl = 'resource/images/rank$count.png';
                      return RankItem(
                        imageUrl: imageUrl,
                        avatarUrl: 'resource/images/avatar.png',
                        rankName: incomeList[index].displayname,
                        value: incomeList[index].amount,
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage: tabName != 'mainBuild',
                  child: ListView.builder(
                    itemCount: mainBuildList.length,
                    itemExtent: ScreenUtil().setHeight(SystemScreenSize.inputDecorationHeight),
                    padding: EdgeInsets.only(top: 0),
                    itemBuilder: (BuildContext context, int index) {
                      int count = index + 1;
                      if (count > 5) {
                        count = 5;
                      }
                      String imageUrl = 'resource/images/rank$count.png';
                      return RankItem(
                        imageUrl: imageUrl,
                        avatarUrl: 'resource/images/avatar.png',
                        rankName: mainBuildList[index].displayname,
                        value: mainBuildList[index].amount,
                      );
                    },
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
