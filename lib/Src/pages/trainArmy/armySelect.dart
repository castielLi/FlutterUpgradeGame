import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/pages/armyCamp/armyIconButton.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';

// ignore: must_be_immutable
class ArmySelectDetail extends StatefulWidget {
  VoidCallback HUD;
  int column;
  int row;
  bool attack;

  ArmySelectDetail({Key key, this.HUD, this.column, this.row, this.attack}) : super(key: key);

  _ArmySelectDetailState createState() => new _ArmySelectDetailState();
}

class _ArmySelectDetailState extends State<ArmySelectDetail> {
  bool hideDetailPage = true;
  String chosenArmy = "shaman";
  int lastClickTime;

  @override
  Widget build(BuildContext context) {
    return ProvideMulti(
      builder: (context, child, model) {
        BaseFightLineupProvider baseFightLineUpProvider = model.get<BaseFightLineupProvider>();
        return new Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(200), ScreenUtil().setWidth(0), ScreenUtil().setHeight(0)),
          child: Stack(
            children: [
              /// 兵种界面
              new Offstage(
                offstage: !this.hideDetailPage,
                child: Container(
                    width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
                    child: Stack(
                      children: <Widget>[
                        new Column(
                          children: [
                            new GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              childAspectRatio: 1,
                              children: [
                                ArmyIconButton(
                                  isChosen: 'rangeAttack' == this.chosenArmy,
                                  size: SystemIconSize.armyCampIconSize,
                                  armyIconImageUrl: "resource/images/rangeAttackIcon.png",
                                  callback: () {
                                    if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
                                      setState(() {
                                        if (this.widget.attack) {
                                          baseFightLineUpProvider.changeAttackLineUp(this.widget.column, this.widget.row, ArmyType.RANGE_ATTACK);
                                        } else {
                                          baseFightLineUpProvider.changeProtectLineUp(this.widget.column, this.widget.row, ArmyType.RANGE_ATTACK);
                                        }
                                        Navigator.pop(context);
                                      });
                                      this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                                    }
                                  },
                                ),
                                ArmyIconButton(
                                  isChosen: 'fighter' == this.chosenArmy,
                                  size: SystemIconSize.armyCampIconSize,
                                  armyIconImageUrl: "resource/images/fighterIcon.png",
                                  callback: () {
                                    if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
                                      setState(() {
                                        if (this.widget.attack) {
                                          baseFightLineUpProvider.changeAttackLineUp(this.widget.column, this.widget.row, ArmyType.FIGHTER);
                                        } else {
                                          baseFightLineUpProvider.changeProtectLineUp(this.widget.column, this.widget.row, ArmyType.FIGHTER);
                                        }
                                        Navigator.pop(context);
                                      });
                                      this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                                    }
                                  },
                                ),
                                ArmyIconButton(
                                  isChosen: 'rider' == this.chosenArmy,
                                  size: SystemIconSize.armyCampIconSize,
                                  armyIconImageUrl: "resource/images/riderIcon.png",
                                  callback: () {
                                    if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
                                      setState(() {
                                        if (this.widget.attack) {
                                          baseFightLineUpProvider.changeAttackLineUp(this.widget.column, this.widget.row, ArmyType.RIDER);
                                        } else {
                                          baseFightLineUpProvider.changeProtectLineUp(this.widget.column, this.widget.row, ArmyType.RIDER);
                                        }
                                        Navigator.pop(context);
                                      });
                                    }
                                    this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
      requestedValues: [BaseFightLineupProvider],
    );
  }
}
