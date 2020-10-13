import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/heroAltar/service/heroService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'heroAltarItem.dart';
import 'model/PermanentDisplayModel.dart';
import 'model/heroListModel.dart';
import 'model/holdHeroDisplayModel.dart';

class HeroAltar extends StatefulWidget {
  @override
  VoidCallback HUD;

  HeroAltar({Key key, this.HUD}) : super(key: key);

  _HeroAltarState createState() => new _HeroAltarState();
}

class _HeroAltarState extends State<HeroAltar> {
  int warriorPrice = 0;
  List<HoldHeroDisplayModel> warriors = [];
  List<HoldHeroDisplayModel> oneyuan = [];
  List<HoldHeroDisplayModel> fiveyuan = [];
  List<HoldHeroDisplayModel> fifteenyuan = [];
  bool hidePermanentHero = true;

  // Permanent hunter =new Permanent(price: 0,consumecoin: 0,amount: 0);
  // Permanent rangeAttack=new Permanent(price: 0,consumecoin: 0,amount: 0);
  // Permanent shaman=new Permanent(price: 0,consumecoin: 0,amount: 0);
  PermanentDisplayModel hunter;
  PermanentDisplayModel rangeAttack;
  PermanentDisplayModel shaman;
  PermanentDisplayModel witch;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getHeroBaseInfoList() {
    this.widget.HUD();

    /// type1 限时30天  type2 永久1元  type3 永久5元 type3 永久15元
    HeroService.getHeroList((HeroListModel model) {
      this.widget.HUD();
      if (model != null) {
        if (null != model.hold && model.hold.length > 0) {
          model.hold.forEach((hero) {
            switch (hero.type) {
              case Heroes.WARRIOR:
                warriors.add(HoldHeroDisplayModel(days: hero.days,id: hero.id,collected: hero.collected));
                break;
              case Heroes.ONEYUAN:
                oneyuan.add(HoldHeroDisplayModel(days: hero.days,id: hero.id,collected: hero.collected));
                break;
              case Heroes.FIVEYUAN:
                fiveyuan.add(HoldHeroDisplayModel(days: hero.days,id: hero.id,collected: hero.collected));
                break;
              case Heroes.FIFTEENYUAN:
                fifteenyuan.add(HoldHeroDisplayModel(days: hero.days,id: hero.id,collected: hero.collected));
                break;
            }
          });

          warriorPrice = model.limittime[0].price;
          hunter = new PermanentDisplayModel(price: model.permanent[0].price.toString(), type: model.permanent[0].type, consumecoin: model.permanent[0].consumecoin.toString(), amount: model.permanent[0].amount.toString(),buy: model.permanent[0].buy);
          rangeAttack = new PermanentDisplayModel(price: model.permanent[1].price.toString(), type: model.permanent[1].type, consumecoin: model.permanent[1].consumecoin.toString(), amount: model.permanent[1].amount.toString(),buy: model.permanent[1].buy);
          shaman = new PermanentDisplayModel(price: model.permanent[2].price.toString(), type: model.permanent[2].type, consumecoin: model.permanent[2].consumecoin.toString(), amount: model.permanent[2].amount.toString(),buy: model.permanent[2].buy);
          witch = new PermanentDisplayModel(price: "????", type: Heroes.UNKNOW, consumecoin: "????", amount: "????",buy: false);

        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.getHeroBaseInfoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
        return new Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(80), // 左
              ScreenUtil().setHeight(350), // 上
              ScreenUtil().setWidth(80), // 右
              ScreenUtil().setHeight(200)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonsList(
                buttonWidth: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
                buttonHeight: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
                buttonBackgroundImageUrl: 'resource/images/teamSwitchBackground.png',
                textSize: ScreenUtil().setSp(SystemButtonSize.largeButtonFontSize),
                buttons: [
                  ImageTextButton(
                    buttonName: '限 时',
                    callback: () {
                      setState(() {
                        this.hidePermanentHero = true;
                      });
                    },
                  ),
                  ImageTextButton(
                    buttonName: '永 久',
                    callback: () {
                      setState(() {
                        this.hidePermanentHero = false;
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: ScreenUtil().setHeight(700),
                child: Stack(
                  children: [
                    Offstage(
                      offstage: !this.hidePermanentHero,
                      child: HeroAltarItem(
                        heroImageUrl: 'resource/images/warrior.png',
                        heroType: Heroes.WARRIOR,
                        HUD: this.widget.HUD,
                        hero: new PermanentDisplayModel(price: this.warriorPrice.toString(), consumecoin: "0"),
                        // price: this.warriorPrice,
                        period: '30天(可叠加)',
                        remainDays: warriors,
                      ),
                    ),
                    Offstage(
                      offstage: this.hidePermanentHero,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/hunter.png',
                              heroType: Heroes.ONEYUAN,
                              HUD: this.widget.HUD,
                              // price: this.hunter.price,
                              period: '永久',
                              hero: hunter,
                              remainDays: oneyuan,
                            ),
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/rangeAttack.png',
                              heroType: Heroes.FIVEYUAN,
                              HUD: this.widget.HUD,
                              hero: rangeAttack,
                              // price: this.rangeAttack.price,
                              period: '永久',
                              remainDays: fiveyuan,
                            ),
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/shaman.png',
                              heroType: Heroes.FIFTEENYUAN,
                              HUD: this.widget.HUD,
                              hero: shaman,
                              // price: this.shaman.price,
                              period: '永久',
                              remainDays: fifteenyuan,
                            ),
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/witch.png',
                              heroType: Heroes.UNKNOW,
                              HUD: this.widget.HUD,
                              hero: witch,
                              // price: this.shaman.price,
                              period: '永久',
                              remainDays: [],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
