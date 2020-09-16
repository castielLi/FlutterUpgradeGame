import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/armyCamp/armyIconButton.dart';

import 'armyCampDetailItem.dart';

// ignore: must_be_immutable
class ArmyCampDetail extends StatefulWidget {
  VoidCallback HUD;

  ArmyCampDetail({Key key, this.HUD}) : super(key: key);

  _ArmyCampDetailState createState() => new _ArmyCampDetailState();
}

class _ArmyCampDetailState extends State<ArmyCampDetail> {
  bool hideDetailPage = true;
  String chosenArmy = "shaman";

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: ScreenUtil().setHeight(1000),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom)),
      child: Stack(
        children: [
          /// 兵种界面
          new Offstage(
            offstage: !this.hideDetailPage,
            child: Container(
              width: ScreenUtil().setWidth(SystemScreenSize.displayContentHeight),
              child: Stack(
                children: <Widget>[
                  new Text('兵种介绍'),
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
                          switchBetweenPages('rangeAttack');
                        },
                      ),
                      ArmyIconButton(
                        isChosen: 'fighter' == this.chosenArmy,
                        size: SystemIconSize.armyCampIconSize,
                        armyIconImageUrl: "resource/images/fighterIcon.png",
                        callback: () {
                          switchBetweenPages('fighter');
                        },
                      ),
                      ArmyIconButton(
                        isChosen: 'rider' == this.chosenArmy,
                        size: SystemIconSize.armyCampIconSize,
                        armyIconImageUrl: "resource/images/riderIcon.png",
                        callback: () {
                          switchBetweenPages('rider');
                        },
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),

          /// 详情界面
          new Offstage(
            offstage: this.hideDetailPage,
            child: Container(
              height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
              child: ArmyCampDetailItem(
                armyImageUrl: "resource/images/" + this.chosenArmy + ".png",
                armyDescription: '远程攻击' + Random().nextInt(10).toString(),
                callback: () {
                  switchBetweenPages(this.chosenArmy);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void switchBetweenPages(String name) {
    setState(() {
      this.hideDetailPage = !this.hideDetailPage;
      this.chosenArmy = name;
    });
  }
}
