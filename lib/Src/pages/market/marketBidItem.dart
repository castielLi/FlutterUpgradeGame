import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class MarketBidItem extends StatefulWidget {
  // 头像
//  String avatarUrl;

  // 名称
  String name;

  // 商品类型
  String bidType;

  // 商品数量
  int amount;

  // T币数量
  int needCoin;

  // 按钮名称
  String buttonName;

  //是否是自己发布的订单
  bool myTrade;

  // 按钮方法
  VoidCallback buttonCallback;

  MarketBidItem({Key key, this.name, this.myTrade = false, this.bidType, this.amount, this.needCoin, this.buttonName, this.buttonCallback}) : super(key: key);

  @override
  _MarketBidItem createState() => _MarketBidItem();
}

class _MarketBidItem extends State<MarketBidItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/marketItemBackground.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(35), ScreenUtil().setHeight(35), ScreenUtil().setWidth(40), ScreenUtil().setHeight(60)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: ScreenUtil().setWidth(250),
                  child: Text(
                    this.widget.name,
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '出售:',
                  style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Image(
                      image: new AssetImage('resource/images/' + this.widget.bidType + '.png'),
                      height: ScreenUtil().setHeight(100),
                    ),
                    Text(
                      '数量:' + this.widget.amount.toString(),
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Image(
                      image: new AssetImage('resource/images/coin.png'),
                      height: ScreenUtil().setHeight(100),
                    ),
                    Text(
                      '数量:' + this.widget.needCoin.toString(),
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ],
                ),
                Visibility(
                  visible: !this.widget.myTrade,
                  child: ImageTextButton(
                    imageUrl: "resource/images/upgradeButton.png",
                    imageWidth: ScreenUtil().setWidth(SystemButtonSize.mediumButtonWidth),
                    imageHeight: ScreenUtil().setHeight(SystemButtonSize.mediumButtonHeight),
                    buttonName: this.widget.buttonName,
                    callback: () {
                      this.widget.buttonCallback();
                    },
                    textSize: ScreenUtil().setSp(SystemFontSize.settingTextFontSize),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
