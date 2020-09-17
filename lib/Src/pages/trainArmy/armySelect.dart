import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/armyCamp/armyIconButton.dart';

// ignore: must_be_immutable
class ArmySelectDetail extends StatefulWidget {
  VoidCallback HUD;

  ArmySelectDetail({Key key, this.HUD}) : super(key: key);

  _ArmySelectDetailState createState() => new _ArmySelectDetailState();
}

class _ArmySelectDetailState extends State<ArmySelectDetail> {
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
                                // switchBetweenPages('rangeAttack');
                              },
                            ),
                            ArmyIconButton(
                              isChosen: 'fighter' == this.chosenArmy,
                              size: SystemIconSize.armyCampIconSize,
                              armyIconImageUrl: "resource/images/fighterIcon.png",
                              callback: () {
                                // switchBetweenPages('fighter');
                              },
                            ),
                            ArmyIconButton(
                              isChosen: 'rider' == this.chosenArmy,
                              size: SystemIconSize.armyCampIconSize,
                              armyIconImageUrl: "resource/images/riderIcon.png",
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
