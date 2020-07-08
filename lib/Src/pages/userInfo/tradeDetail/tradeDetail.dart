import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/pages/userInfo/tradeDetail/tradeItem.dart';

class TradeDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  TradeDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _TradeDetailState createState() => new _TradeDetailState();
}

class _TradeDetailState extends State<TradeDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(150)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '日期',
                style: CustomFontSize.defaultTextStyle(55),
              ),
              Text(
                '种类',
                style: CustomFontSize.defaultTextStyle(55),
              ),
              Text(
                '数量',
                style: CustomFontSize.defaultTextStyle(55),
              ),
              Text(
                '金额',
                style: CustomFontSize.defaultTextStyle(55),
              ),
            ],
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (content, index) {
                return TradeItem(
                  tDate: '2020-06-04',
                  tTypeImageUrl: 'resource/images/wood.png',
                  tAmount: 2314,
                  tCoin: 123,
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
