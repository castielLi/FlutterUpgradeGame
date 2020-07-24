import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/userInfo/event/userInfoEventBus.dart';
import 'package:upgradegame/Src/pages/userInfo/model/tCoinDetailModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeItem.dart';

class TradeDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  TradeDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _TradeDetailState createState() => new _TradeDetailState();
}

class _TradeDetailState extends State<TradeDetail> {
  TCoinDetailModel tCoinDetail;
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfoHttpRequestEvent().on("tcoinDetail", this.getTCoinDetail);
  }

  void getTCoinDetail() {
    this.widget.HUD();
    UserInfoService.getUserTCoinDetail(this.page, (TCoinDetailModel model) {
      /// TODO 加载更多跟市场一样叠加
      this.tCoinDetail = model;
//      //测试
//      model.datalist =[new Datalist(datetime: "2020-07-24",detail: "购买英雄",change:"100")];
//      for (int i = 0; i < 4; i++) {
//        this.tCoinDetail.datalist = this.tCoinDetail.datalist+this.tCoinDetail.datalist;
//      }
      this.widget.HUD();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '日期',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
              Text(
                '事项',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
              Text(
                '金额',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
            ],
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
          child: ListView.builder(
              itemCount: this.tCoinDetail == null ? 0 : this.tCoinDetail.datalist.length,
              itemBuilder: (content, index) {
                Datalist tCoinTx = this.tCoinDetail.datalist[index];
                return TradeItem(
                  tDate: tCoinTx.datetime,
                  detail: tCoinTx.detail,
                  tCoin: tCoinTx.change,
                );
              }),
        ),
        new ImageButton(
          height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
          width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
          buttonName: "返回",
          imageUrl: "resource/images/upgradeButton.png",
          callback: () {
//                this.widget.HUD();
            this.widget.viewCallback();
          },
        ),
      ],
    );
  }
}
