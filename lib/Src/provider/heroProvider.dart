import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/PermanentDisplayModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/heroListModel.dart';
import 'package:upgradegame/Src/pages/heroAltar/model/holdHeroDisplayModel.dart';

//混入
class HeroProvider with ChangeNotifier {

  List<HoldHeroDisplayModel> warriors = [];
  List<HoldHeroDisplayModel> oneyuan = [];
  List<HoldHeroDisplayModel> fiveyuan = [];
  List<HoldHeroDisplayModel> fifteenyuan = [];

  int warriorPrice = 0;
  PermanentDisplayModel hunter;
  PermanentDisplayModel rangeAttack;
  PermanentDisplayModel shaman;
  PermanentDisplayModel witch;


  initHeroProvider(HeroListModel model) {

    warriors = [];
    oneyuan = [];
    fiveyuan = [];
    fifteenyuan = [];
    warriorPrice = 0;
    hunter = null;
    rangeAttack = null;
    shaman = null;
    witch = null;

    if (model != null) {
      if (null != model.hold && model.hold.length > 0) {
        model.hold.forEach((hero) {
          switch (hero.type) {
            case Heroes.WARRIOR:
              warriors.add(HoldHeroDisplayModel(days: hero.days, id: hero.id, collected: hero.collected));
              break;
            case Heroes.ONEYUAN:
              oneyuan.add(HoldHeroDisplayModel(days: hero.days, id: hero.id, collected: hero.collected));
              break;
            case Heroes.FIVEYUAN:
              fiveyuan.add(HoldHeroDisplayModel(days: hero.days, id: hero.id, collected: hero.collected));
              break;
            case Heroes.FIFTEENYUAN:
              fifteenyuan.add(HoldHeroDisplayModel(days: hero.days, id: hero.id, collected: hero.collected));
              break;
          }
        });

        warriorPrice = model.limittime[0].price;
        hunter = new PermanentDisplayModel(
            price: model.permanent[0].price.toString(),
            type: model.permanent[0].type,
            consumecoin: model.permanent[0].consumecoin.toString(),
            amount: model.permanent[0].amount.toString(),
            buy: model.permanent[0].buy);
        rangeAttack = new PermanentDisplayModel(
            price: model.permanent[1].price.toString(),
            type: model.permanent[1].type,
            consumecoin: model.permanent[1].consumecoin.toString(),
            amount: model.permanent[1].amount.toString(),
            buy: model.permanent[1].buy);
        shaman = new PermanentDisplayModel(
            price: model.permanent[2].price.toString(),
            type: model.permanent[2].type,
            consumecoin: model.permanent[2].consumecoin.toString(),
            amount: model.permanent[2].amount.toString(),
            buy: model.permanent[2].buy);
        witch = new PermanentDisplayModel(price: "????", type: Heroes.UNKNOW, consumecoin: "????", amount: "????", buy: false);
      }
    }
    notifyListeners();
  }

}
