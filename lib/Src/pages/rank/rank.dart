import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/imageTextButtonWithIcon/imageTextButtonWithIcon.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
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
  bool coinTabHide = false;
  bool incomeTabHide = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      RankService.getRankList().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            coinList = RankListModel.fromJson(data.data).coinList;
            incomeList = RankListModel.fromJson(data.data).incomeList;
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
          ScreenUtil().setWidth(100), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(100), // 右
          ScreenUtil().setHeight(200)),  // 下
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: SystemIconSize.mediumButtonWithIconWidth/2,
                  imageWidth: SystemIconSize.mediumButtonWithIconWidth,
                  iconUrl: 'resource/images/gold.png',
                  iconHeight: SystemIconSize.mediumIconSize,
                  iconWidth: SystemIconSize.mediumIconSize,
                  buttonName: 'T币',
                  textSize: SystemFontSize.mediumButtonWithIconFontSize,
                  callback: () {
                    setState(() {
                      coinTabHide = false;
                      incomeTabHide = true;
                    });
                  },
                ),
                ImageTextButtonWithIcon(
                  imageUrl: 'resource/images/yellowButton.png',
                  imageHeight: SystemIconSize.mediumButtonWithIconWidth/2,
                  imageWidth: SystemIconSize.mediumButtonWithIconWidth,
                  iconUrl: 'resource/images/withdraw.png',
                  iconHeight: SystemIconSize.mediumIconSize,
                  iconWidth: SystemIconSize.mediumIconSize,
                  buttonName: '提现',
                  textSize: SystemFontSize.mediumButtonWithIconFontSize,
                  callback: () {
                    setState(() {
                      coinTabHide = true;
                      incomeTabHide = false;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(840),
            child: incomeTabHide
                ? ListView.builder(
                    itemCount: coinList.length,
                    itemExtent: ScreenUtil().setHeight(170),
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
                  )
                : ListView.builder(
                    itemCount: incomeList.length,
                    itemExtent: ScreenUtil().setHeight(170),
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
        ],
      ),
    );
  }
}
