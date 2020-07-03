import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class MarketBidItem extends StatefulWidget {
  // 头像
  String avatarUrl;

  // 名称
  String name;

  // 商品类型
  String bidType;

  // 商品数量
  int amount;

  // T币数量
  int needCoin;

  MarketBidItem(
      {Key key,
      this.avatarUrl,
      this.name,
      this.bidType,
      this.amount,
      this.needCoin})
      : super(key: key);

  @override
  _MarketBidItem createState() => _MarketBidItem();
}

class _MarketBidItem extends State<MarketBidItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/woodButton.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image(
                    image: new AssetImage(this.widget.avatarUrl),
                    height: ScreenUtil().setHeight(90),
                  ),
                  Text(
                    this.widget.name,
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('出售:', style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize)),
                  Image(
                    image: new AssetImage(
                        'resource/images/' + this.widget.bidType + '.png'),
                    height: ScreenUtil().setHeight(90),
                  ),
                  Text(
                    '数量:' + this.widget.amount.toString(),
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(right:ScreenUtil().setSp(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
          ),
          ImageTextButton(
            imageUrl: "resource/images/upgradeButton.png",
            imageWidth: ScreenUtil().setWidth(270),
            imageHeight: ScreenUtil().setHeight(120),
            buttonName: "购 买",
            callback: () {
              print(this.widget.bidType);
            },
            textSize: SystemFontSize.settingTextFontSize,
          )
        ],
      ),
    );
  }
}
