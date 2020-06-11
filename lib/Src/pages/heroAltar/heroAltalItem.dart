import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

import 'heroAltarClock.dart';

class HeroAltalItem extends StatefulWidget {
  // 描述
  String description;

  // 收益提高
  double revenueUp;

  // 剩余天数
  List<int> remainDays;

  //英雄图片
  String heroImageUrl;

  HeroAltalItem(
      {Key key,
      this.description,
      this.revenueUp,
      this.remainDays,
      this.heroImageUrl})
      : super(key: key);

  @override
  _HeroAltalItem createState() => _HeroAltalItem();
}

class _HeroAltalItem extends State<HeroAltalItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(900),
          height: ScreenUtil().setHeight(360),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('resource/images/woodButton.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(
                image: new AssetImage(this.widget.heroImageUrl),
                height: ScreenUtil().setHeight(250),
                width: ScreenUtil().setWidth(250),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.widget.description,
                    style: CustomFontSize.defaultTextStyle(50),
                  ),
                  Text(
                    '效率:收益提高' + this.widget.revenueUp.toInt().toString() + '%',
                    style: CustomFontSize.defaultTextStyle(50),
                  ),
                  Text(
                    '期限:30天（可叠加）',
                    style: CustomFontSize.defaultTextStyle(50),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              HeroAltarClock(
                imageUrl: 'resource/images/clock.png',
                adIconHeight: ScreenUtil().setHeight(150),
                remainDays: this.widget.remainDays,
              ),
              GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(100),
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          new AssetImage('resource/images/upgradeButton.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '购 买',
                      style: CustomFontSize.defaultTextStyle(45),
                    ),
                  ),
                ),
                onTap: () {
                  print('点击购买');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
