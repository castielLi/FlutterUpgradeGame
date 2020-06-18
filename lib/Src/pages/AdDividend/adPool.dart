import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/adDividend/model/AdDividendModel.dart';

class AdPool extends StatefulWidget {
  // 英雄图片
  String heroImageUrl;

  // 奖池名称
  String poolName;

  AdDividendModel adDividend;

  AdPool({Key key, this.adDividend, this.heroImageUrl, this.poolName})
      : super(key: key);

  @override
  _AdPool createState() => _AdPool();
}

class _AdPool extends State<AdPool> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(360),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/woodButton.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Row(
        children: <Widget>[
          Image(
            image: new AssetImage(this.widget.heroImageUrl),
            height: ScreenUtil().setHeight(SystemIconSize.largeIconSize),
            width: ScreenUtil().setWidth(SystemIconSize.largeIconSize),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setSp(270)),
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '昨日收益',
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                    Text(
                      '历史收益',
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '我的' + this.widget.poolName + '奖池',
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                    Text(
                      this.widget.adDividend.yesterdayincome.toString(),
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                    Text(
                      this.widget.adDividend.totalincome.toString(),
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                  ],
                ),
              ),
              Container(
                width: ScreenUtil().setWidth(600),
                height: ScreenUtil().setHeight(80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '全网总数',
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                    Text(
                      this.widget.adDividend.totalheroamount.toString(),
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                    Text(
                      '今日产出',
                      style: CustomFontSize.defaultTextStyle(40),
                    ),
                    Text(
                      this.widget.adDividend.todayheroamount.toString(),
                      style: CustomFontSize.defaultTextStyle(40),
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
