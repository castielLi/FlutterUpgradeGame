import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/armyCamp/armyIconButton.dart';

import 'armyCampItem.dart';

// ignore: must_be_immutable
class ArmyCampDetail extends StatefulWidget {
  VoidCallback HUD;

  ArmyCampDetail({Key key, this.HUD}) : super(key: key);

  _ArmyCampDetailState createState() => new _ArmyCampDetailState();
}

class _ArmyCampDetailState extends State<ArmyCampDetail> {
  bool isArmyPage = true;
  String currentArmy = "rangeAttack";

  @override
  Widget build(BuildContext context) {
    return new Container(
      // color: Colors.yellow,
      height: ScreenUtil().setHeight(1000),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom)),
      child: Stack(
        children: [
          // new Offstage(),
          new Offstage(
            offstage: !this.isArmyPage,
            child: new Container(
              width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ArmyIconButton(
                    isChosen: 'rangeAttack' == this.currentArmy,
                    size: SystemIconSize.armyCampIconSize,
                    armyIconImageUrl: "resource/images/rangeAttackIcon.png",
                    callback: () {
                      showArmyDetail('rangeAttack');
                    },
                  ),
                  ArmyIconButton(
                    isChosen: 'fighter' == this.currentArmy,
                    size: SystemIconSize.armyCampIconSize,
                    armyIconImageUrl: "resource/images/fighterIcon.png",
                    callback: () {
                      showArmyDetail('fighter');
                    },
                  ),
                  ArmyIconButton(
                    isChosen: 'rider' == this.currentArmy,
                    size: SystemIconSize.armyCampIconSize,
                    armyIconImageUrl: "resource/images/riderIcon.png",
                    callback: () {
                      showArmyDetail('rider');
                    },
                  ),
                ],
              ),
            ),
          ),
          new Offstage(
            offstage: this.isArmyPage,
            child: Container(
              height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
              child: ArmyCampItem(
                armyImageUrl: "resource/images/" + this.currentArmy + ".png",
                armyDescription: '远程攻击',
                armyPrice: Random().nextInt(100).toString(),
                callback: (){
                  showArmyDetail(this.currentArmy);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showArmyDetail(String name) {
    setState(() {
      this.isArmyPage = !this.isArmyPage;
      this.currentArmy = name;
    });
  }
}
