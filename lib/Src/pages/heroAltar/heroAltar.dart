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
import 'model/heroBaseInfoListModel.dart';

class HeroAltar extends StatefulWidget {
  @override
  VoidCallback HUD;

  HeroAltar({Key key, this.HUD}) : super(key: key);

  _HeroAltarState createState() => new _HeroAltarState();
}

class _HeroAltarState extends State<HeroAltar> {
  int warriorPrice = 0;
  int shamanPrice = 0;
  bool hidePermanentHero = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void getHeroBaseInfoList() {
    this.widget.HUD();
    HeroService.getHeroList((HeroBaseInfoListModel model) {
      this.widget.HUD();
      if (model != null) {
        //获取英雄价格
        List<Datalist> heroes = model.datalist;
        if (null != heroes) {
          heroes.forEach((hero) {
            switch (hero.type) {
              case Heroes.WARRIOR:
                this.warriorPrice = hero.price;
                break;
              case Heroes.SHAMAN:
                this.shamanPrice = hero.price;
                break;
            }
          });
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
        List<Heroes> heroes = baseUserInfo.hero;
        List<int> warriors = [];
        List<int> shamans = [];
        if (null != baseUserInfo) {
          heroes.forEach((hero) {
            switch (hero.type) {
              case Heroes.WARRIOR:
                warriors.add(hero.days);
                break;
              case Heroes.SHAMAN:
                shamans.add(hero.days);
                break;
            }
          });
        }
        // for(int i=0;i<9;i++){
        //   warriors.add(30);
        // }
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
                        description: '战士:守卫家园',
                        remainDays: warriors,
                        heroType: Heroes.WARRIOR,
                        HUD: this.widget.HUD,
                        price: this.warriorPrice,
                        period: '30天（可叠加）',
                      ),
                    ),
                    Offstage(
                      offstage: this.hidePermanentHero,
                      child: HeroAltarItem(
                        heroImageUrl: 'resource/images/shaman.png',
                        description: '萨满:保佑你的灵魂',
                        remainDays: shamans,
                        heroType: Heroes.SHAMAN,
                        HUD: this.widget.HUD,
                        price: this.shamanPrice,
                        period: '永久',
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
