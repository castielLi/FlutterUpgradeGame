import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/buyHeroModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/service/heroService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'heroAltarClock.dart';

class HeroAltarItem extends StatefulWidget {
  //英雄图片
  String heroImageUrl;

  List<int> remainDays;
  int heroType;

  int price;

  String period;

  VoidCallback HUD;

  HeroAltarItem({Key key, this.period, this.remainDays, this.heroImageUrl, this.heroType, this.price, this.HUD}) : super(key: key);

  @override
  _HeroAltarItem createState() => _HeroAltarItem();
}

class _HeroAltarItem extends State<HeroAltarItem> {
  buyHero(int type) {
    this.widget.HUD();
    HeroService.buyHero(type, (BuyHeroModel model) {
      this.widget.HUD();
      if (model != null) {
        CommonUtils.showSuccessMessage(msg: '英雄购买成功');
        setState(() {
          Provide.value<BaseUserInfoProvider>(context).buyHero(model.tcoinamount, model.datalist);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Container(
          width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
          height: ScreenUtil().setHeight(SystemScreenSize.displayItemHeight),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('resource/images/marketItemBackground.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image(
                    image: new AssetImage(this.widget.heroImageUrl),
                    height: ScreenUtil().setHeight(SystemIconSize.mediumIconSize),
                    width: ScreenUtil().setWidth(SystemIconSize.mediumIconSize),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(380),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '价格:' + this.widget.price.toString() + '金币',
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        ),
                        Text(
                          '期限:' + this.widget.period,
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: ScreenUtil().setWidth(220),
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
                      if (0 != this.widget.price && baseUserInfo.TCoinAmount >= this.widget.price) {
                        showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text('您确认购买英雄么?'),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('取消'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text('确认'),
                                  onPressed: () {
                                    this.buyHero(this.widget.heroType);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((val) {
                          print(val);
                        });
                      } else {
                        CommonUtils.showErrorMessage(msg: "您当前的金币不足以购买英雄");
                      }
                    },
                  ),
                ],
              ),
              // Container(
              //   width: ScreenUtil().setWidth(800),
              //   child: HeroAltarClock(
              //     imageUrl: 'resource/images/clock.png',
              //     adIconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
              //     remainDays: this.widget.remainDays,
              //     callback: () {
              //       if (baseUserInfo.ad.stone + baseUserInfo.ad.wood + baseUserInfo.ad.farmone + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree > -1) {
              //         ///TODO 领取分红
              //       } else {
              //         CommonUtils.showErrorMessage(msg: "您没有足够的广告条数哦,无法领取分红,快去观看广告吧");
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
