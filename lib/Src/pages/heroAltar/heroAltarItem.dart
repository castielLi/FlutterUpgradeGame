import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/globalDataModel.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/heroAltar/event/heroEventBus.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/PermanentDisplayModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/buyHeroModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/holdHeroDisplayModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/service/heroService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'model/dividendHeroModel.dart';

class HeroAltarItem extends StatefulWidget {
  //英雄图片
  String heroImageUrl;

  List<HoldHeroDisplayModel> remainDays;

  int heroType;

  String period;

  VoidCallback HUD;

  PermanentDisplayModel hero;

  HeroAltarItem({Key key, this.hero, this.period, this.remainDays, this.heroImageUrl, this.heroType, this.HUD}) : super(key: key);

  @override
  _HeroAltarItem createState() => _HeroAltarItem();
}

class _HeroAltarItem extends State<HeroAltarItem> {
  String cashAmount = '';

  dividendHero(int type, String id) {
    this.widget.HUD();
    HeroService.dividendHero(type, id, (DividendHeroModel model) {
      this.widget.HUD();
      if (model != null) {
        Provide.value<BaseUserInfoProvider>(context).dividendHero(model.tcoinamount);
        HeroEventBus().emit("getHeroBaseInfoList");
      }
    });
  }

  buyHero(int type) {
    this.widget.HUD();
    HeroService.buyHero(type, (BuyHeroModel model) {
      this.widget.HUD();
      if (model != null) {
        CommonUtils.showSuccessMessage(msg: '英雄购买成功');
        setState(() {
          Provide.value<BaseUserInfoProvider>(context).buyHero(model.tcoinamount);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (null == this.widget.hero) {
      this.widget.hero = new PermanentDisplayModel(price: '0', consumecoin: '0', amount: '0');
    }
    int clockCount = null == this.widget.remainDays ? 0 : this.widget.remainDays.length;
    int consumeCoin = this.widget.hero.consumecoin != "????" ? int.parse(this.widget.hero.consumecoin) : 0;
    String period = Heroes.WARRIOR == this.widget.hero.type ? '30天(可叠加)' : '永久';
    switch (this.widget.heroType) {
      case Heroes.ONEYUAN:
        this.cashAmount = '固定1元';
        break;
      case Heroes.FIVEYUAN:
        this.cashAmount = '固定5元';
        break;
      case Heroes.FIFTEENYUAN:
        this.cashAmount = '固定15元';
        break;
      case Heroes.UNKNOW:
        this.cashAmount = '固定????元';
        break;
    }
    return Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return Column(
          children: [
            Container(
              width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
              height: ScreenUtil().setHeight(SystemScreenSize.displayItemHeight),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('resource/images/marketItemBackground.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
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
                          '价格:' + this.widget.hero.price.toString() + '金币',
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        ),
                        Text(
                          '期限:' + period,
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                        ),
                        Offstage(
                          offstage: Heroes.WARRIOR == this.widget.heroType,
                          child: Text(
                            '数量:' + this.widget.hero.amount.toString(),
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                        ),
                        Offstage(
                          offstage: Heroes.WARRIOR == this.widget.heroType,
                          child: Text(
                            '分红:' + this.cashAmount,
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(220),
                    child: Offstage(
                      offstage: !(Heroes.WARRIOR != this.widget.heroType && this.widget.hero.buy == true),
                      child: GestureDetector(
                        child: Container(
                          height: ScreenUtil().setHeight(120),
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
                          if (0 != int.parse(this.widget.hero.price) && baseUserInfo.TCoinAmount >= int.parse(this.widget.hero.price)) {
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
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Container(
              //最高只显示3个
              height: ScreenUtil().setHeight(clockCount * SystemButtonSize.smallButtonHeight > 360 ? 360 : clockCount * SystemButtonSize.smallButtonHeight),
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  itemCount: clockCount,
                  itemExtent: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Image(image: new AssetImage('resource/images/clock.png'), height: ScreenUtil().setHeight(SystemIconSize.smallIconSize)),
                            Text(
                              this.widget.remainDays[index].days > 31 ? "永久" : this.widget.remainDays[index].days.toString() + '天',
                              style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                            ),
                          ],
                        ),
                        Offstage(
                          offstage: Heroes.WARRIOR == this.widget.heroType,
                          child: Text(
                            "消耗" + consumeCoin.toString() + '金币',
                            style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(SystemButtonSize.smallButtonWidth),
                          child: Offstage(
                            offstage: this.widget.remainDays[index].collected,
                            child: GestureDetector(
                              child: Container(
                                height: ScreenUtil().setHeight(SystemButtonSize.smallButtonHeight),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: new AssetImage('resource/images/upgradeButton.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '分 红',
                                    style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (this.widget.heroType == Heroes.WARRIOR) {
                                if (baseUserInfo.ad.wood + baseUserInfo.ad.stone + baseUserInfo.ad.farmone + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree >=
                                     Global.extraRule.heroadamount) {
                                  this.dividendHero(this.widget.heroType, this.widget.remainDays[index].id);
                                } else {
                                  if (baseUserInfo.tcoinamount < consumeCoin) {
                                    CommonUtils.showErrorMessage(msg: "您当前的金币不足,请有足够金币的时候再来吧");
                                    return;
                                  }
                                  if (baseUserInfo.ad.wood + baseUserInfo.ad.stone + baseUserInfo.ad.farmone + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree >=
                                      // Global.extraRule.heroadamount) {
                                      ///TODO 测试数据
                                      -1) {
                                    this.dividendHero(this.widget.heroType, this.widget.remainDays[index].id);
                                  } else {
                                    CommonUtils.showErrorMessage(msg: "你当前的广告数量没有达到" + Global.extraRule.heroadamount.toString() + "条不能领取分红");
                                    return;
                                  }
                                }
                              } else {
                                if (baseUserInfo.tcoinamount < consumeCoin) {
                                  CommonUtils.showErrorMessage(msg: "您当前的金币不足,请有足够金币的时候再来吧");
                                  return;
                                }
                                if (baseUserInfo.ad.wood + baseUserInfo.ad.stone + baseUserInfo.ad.farmone + baseUserInfo.ad.farmtwo + baseUserInfo.ad.farmthree >=
                                     Global.extraRule.heroadamount) {
                                  this.dividendHero(this.widget.heroType, this.widget.remainDays[index].id);
                                } else {
                                  CommonUtils.showErrorMessage(msg: "你当前的广告数量没有达到" + Global.extraRule.heroadamount.toString() + "条不能领取分红");
}
