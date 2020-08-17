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
  // 描述
  String description;

  // 剩余天数
  List<int> remainDays;

  //英雄图片
  String heroImageUrl;

  int heroType;

  int price;

  String period;

  VoidCallback HUD;

  HeroAltarItem({Key key, this.description, this.period, this.remainDays, this.heroImageUrl, this.heroType, this.price, this.HUD}) : super(key: key);

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
        return Column(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
              height: ScreenUtil().setHeight(SystemScreenSize.displayItemHeight),
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
                        '价格:' + this.widget.price.toString() + 'T币',
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                      ),
                      Text(
                        '期限:' + this.widget.period,
                        style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(600),
                    child: HeroAltarClock(
                      imageUrl: 'resource/images/clock.png',
                      adIconHeight: ScreenUtil().setHeight(SystemIconSize.smallIconSize),
                      remainDays: this.widget.remainDays,
                    ),
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
                      if(baseUserInfo.TCoinAmount >= this.widget.price){
                        showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text('您确认通过T币兑换贡献值么?'),
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
                      }else{
                        CommonUtils.showErrorMessage(msg: "您当前的T币不足以购买英雄");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
