import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/adDividend/model/heroProfitModel.dart';

class AdPool extends StatefulWidget {
  // 英雄图片
  String heroImageUrl;

  HeroProfitModel adDividend;

  AdPool({Key key, this.adDividend, this.heroImageUrl}) : super(key: key);

  @override
  _AdPool createState() => _AdPool();
}

class _AdPool extends State<AdPool> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(SystemScreenSize.displayItemHeight),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/woodButton.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        children: <Widget>[
          Image(
            image: new AssetImage(this.widget.heroImageUrl),
            height: ScreenUtil().setHeight(SystemIconSize.mediumIconSize),
            width: ScreenUtil().setWidth(SystemIconSize.mediumIconSize),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(550),
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '昨日分红(元/位)',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                    Text(
                      this.widget.adDividend.price,
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(550),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '全网总数',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                    Text(
                      this.widget.adDividend.total.toString(),
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                    Text(
                      '今日产出',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                    Text(
                      this.widget.adDividend.product.toString(),
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
