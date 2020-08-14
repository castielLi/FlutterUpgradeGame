import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class ExchangeCoinItem extends StatefulWidget {
  int contributionAmount;
  int coinAmount;
  bool isBuy;
  VoidCallback callback;

  ExchangeCoinItem({Key key, this.contributionAmount, this.coinAmount, this.callback, this.isBuy}) : super(key: key);

  _ExchangeCoinItemState createState() => new _ExchangeCoinItemState();
}

class _ExchangeCoinItemState extends State<ExchangeCoinItem> {
  @override
  Widget build(BuildContext context) {
    return new Visibility(
      visible: !this.widget.isBuy,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage('resource/images/marketItemBackground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child:   Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(0),ScreenUtil().setHeight(10),ScreenUtil().setWidth(40),ScreenUtil().setHeight(50)),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(50)),
                      width: ScreenUtil().setWidth(160),
                      child: new Text(this.widget.contributionAmount.toString(),
                          textAlign: TextAlign.center, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.storeCashGoldTextFontSize))),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                      child: Image(
                        image: new AssetImage("resource/images/contributionIcon.png"),
                        width: ScreenUtil().setWidth(120),
                        height: ScreenUtil().setHeight(120),
                        fit: BoxFit.fill,
                      ),
                    ),
                    new Container(
                      width: ScreenUtil().setWidth(130),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                      child: new Text(this.widget.coinAmount.toString(),
                          textAlign: TextAlign.center, style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.storeCashGoldTextFontSize))),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                      child: Image(
                        image: new AssetImage("resource/images/coin.png"),
                        width: ScreenUtil().setHeight(120),
                        height: ScreenUtil().setHeight(120),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                new ImageTextButton(
                  imageUrl: "resource/images/upgradeButton.png",
                  imageWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                  imageHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                  buttonName: "兑 换",
                  callback: () {
                    this.widget.callback();
                  },
                  textSize: ScreenUtil().setSp(SystemFontSize.storeCashGoldTextFontSize),
                ),
              ],
            )),
      ),
    );
  }
}
