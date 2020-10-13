import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/buttonsList/buttonsList.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/heroAltar/service/heroService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'heroAltarClock.dart';
import 'heroAltarItem.dart';
import 'model/heroListModel.dart';

class HeroAltar extends StatefulWidget {
  @override
  VoidCallback HUD;

  HeroAltar({Key key, this.HUD}) : super(key: key);

  _HeroAltarState createState() => new _HeroAltarState();
}

class _HeroAltarState extends State<HeroAltar> {
  int warriorPrice = 0;
  int hunterPrice = 0;
  int rangeAttackPrice = 0;
  int shamanPrice = 0;
  List<int> warriors = [];
  List<int> oneyuan = [];
  List<int> fiveyuan = [];
  List<int> fifteenyuan = [];
  bool hidePermanentHero = true;

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
                warriors.add(hero.days);
                break;
              case Heroes.ONEYUAN:
                oneyuan.add(hero.days);
                break;
              case Heroes.FIVEYUAN:
                fiveyuan.add(hero.days);
                break;
              case Heroes.FIFTEENYUAN:
                fifteenyuan.add(hero.days);
                break;
            }
          });
          warriorPrice = model.limittime[0].price;
          hunterPrice = model.permanent[0].price;
          rangeAttackPrice = model.permanent[1].price;
          shamanPrice = model.permanent[2].price;
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
                        price: this.warriorPrice,
                        period: '30天(可叠加)',
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
                              price: this.hunterPrice,
                              period: '永久',
                            ),
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/rangeAttack.png',
                              heroType: Heroes.FIVEYUAN,
                              HUD: this.widget.HUD,
                              price: this.rangeAttackPrice,
                              period: '永久',
                            ),
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/shaman.png',
                              heroType: Heroes.FIFTEENYUAN,
                              HUD: this.widget.HUD,
                              price: this.shamanPrice,
                              period: '永久',
                            ),
                            HeroAltarItem(
                              heroImageUrl: 'resource/images/witch.png',
                              heroType: Heroes.FIFTEENYUAN,
                              HUD: this.widget.HUD,
                              price: this.shamanPrice,
                              period: '永久',
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
