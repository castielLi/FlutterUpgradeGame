import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/buyHeroModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/service/heroService.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'heroAltarClock.dart';

class HeroAltarItem extends StatefulWidget {
  // 描述
  String description;

  // 收益提高
  double revenueUp;

  // 剩余天数
  List<int> remainDays;

  //英雄图片
  String heroImageUrl;

  int heroType;

  VoidCallback HUD;

  HeroAltarItem({Key key, this.description, this.revenueUp, this.remainDays, this.heroImageUrl, this.heroType, this.HUD}) : super(key: key);

  @override
  _HeroAltarItem createState() => _HeroAltarItem();
}

class _HeroAltarItem extends State<HeroAltarItem> {
  buyHero(int type) {
    this.widget.HUD();
    HeroService.buyHero(type, (BuyHeroModel model) {
      this.widget.HUD();
      if (model != null) {
        setState(() {
          Provide.value<BaseUserInfoProvider>(context).buyHero(model.tcoinamount, model.datalist);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(900),
          height: ScreenUtil().setHeight(320),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('resource/images/woodButton.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(
                image: new AssetImage(this.widget.heroImageUrl),
                height: ScreenUtil().setHeight(SystemIconSize.mediumIconSize),
                width: ScreenUtil().setWidth(SystemIconSize.mediumIconSize),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.widget.description,
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                  ),
                  Text(
                    '效率:收益提高' + this.widget.revenueUp.toInt().toString() + '%',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                  ),
                  Text(
                    '期限:30天（可叠加）',
                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          ///TODO 钟太多的情况
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              HeroAltarClock(
                imageUrl: 'resource/images/clock.png',
                adIconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                remainDays: this.widget.remainDays,
              ),
              GestureDetector(
                child: Container(
                  width: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                  height: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('resource/images/upgradeButton.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '购 买',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                    ),
                  ),
                ),
                onTap: () {
                  this.buyHero(this.widget.heroType);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
