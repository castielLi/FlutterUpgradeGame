import 'package:flutter/material.dart';
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
  bool sonTabHide = false;
  bool grandsonTabHide = true;

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
          ScreenUtil().setWidth(120), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(120), // 右
          ScreenUtil().setHeight(80)), // 下
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
                    imageWidth: ScreenUtil().setWidth(400),
                    imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "徒 弟",
                    textSize: SystemFontSize.settingTextFontSize,
                    callback: () {
                      setState(() {
                        sonTabHide = false;
                        grandsonTabHide = true;
                      });
                    },
                  ),
                ),
                new Expanded(
                  child: new ImageTextButton(
                    imageUrl: "resource/images/teamSwitchBackground.png",
                    imageWidth: ScreenUtil().setWidth(400),
                    imageHeight: ScreenUtil().setHeight(190),
                    buttonName: "徒 孙",
                    textSize: SystemFontSize.settingTextFontSize,
                    callback: () {
                      setState(() {
                        sonTabHide = true;
                        grandsonTabHide = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(120)),
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
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(730),
            child: Stack(
              children: [
                Offstage(
                  offstage: sonTabHide,
                  child: ListView.builder(
                    itemCount: first.length,
                    padding: EdgeInsets.all(1.0),
                    itemBuilder: (BuildContext context, int index) {
                      return TeamItem(
                        invite: first[index],
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage: grandsonTabHide,
                  child: ListView.builder(
                    itemCount: second.length,
                    padding: EdgeInsets.all(1.0),
                    itemBuilder: (BuildContext context, int index) {
                      return TeamItem(
                        invite: second[index],
                      );
                    },
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
