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
  String description = '';

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
                    new Column(
                      children: [
                        new Text(
                          '兵种介绍',
                          style: CustomFontSize.defaultTextStyle(SystemFontSize.moreMoreLargerTextSize + 10),
                        ),
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
                            ArmyIconButton(
                              isChosen: false,
                              size: SystemIconSize.armyCampIconSize,
                              armyIconImageUrl: "resource/images/mysteriousArmy.png",
                              callback: () {
                                // switchBetweenPages('rider');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          ),

          /// 详情界面
          new Offstage(
            offstage: this.hideDetailPage,
            child: Container(
              height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
              child: ArmyCampDetailItem(
                armyImageUrl: "resource/images/" + this.chosenArmy + ".png",
                armyDescription: this.description,
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
      switch (chosenArmy) {
        case 'rider':
          {
            this.description = '骑士：拥有较快的行动力，在战场上可以快速靠近攻击敌方前排士兵，容易被远程兵种优先打击。\n血量：2\n攻击力：1\n攻击距离：1\n行动力：2';
            break;
          }
        case 'fighter':
          {
            this.description = '战士：部落最常见的兵种，拥有较强的身体素质，对远程攻击有一定抵抗力，容易被骑兵兵种克制。\n血量：3\n攻击力：1\n攻击距离：1\n行动力：1';
            break;
          }
        case 'rangeAttack':
          {
            this.description = '猎手：在野外拥有极强生存能力的远程兵种，可以远距离有效打击敌人，近战能力弱，要小心被敌人近身。\n血量：2\n攻击力：1\n攻击距离：2\n行动力：1';
            break;
          }
          break;
      }
    });
  }
}
