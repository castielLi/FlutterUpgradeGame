import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/smallDetailDialog.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class ArmySelectItem extends StatefulWidget {
  double size;
  int armyCode;
  List position; // 在矩阵中的位置
  bool reWatch;
  bool attack;

  ArmySelectItem({Key key, this.size, this.armyCode = 0, this.position, this.reWatch, this.attack}) : super(key: key);

  @override
  _ArmySelectItem createState() => new _ArmySelectItem();
}

class _ArmySelectItem extends State<ArmySelectItem> {
  int lastClickTime;

  @override
  Widget build(BuildContext context) {
    bool hideArmy = (this.widget.armyCode == 0);
    return ProvideMulti(
      builder: (context, child, model) {
        BaseFightLineupProvider baseFightLineUpProvider = model.get<BaseFightLineupProvider>();
        return GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: AssetImage("resource/images/armyBaseBackground.png"),
                  height: ScreenUtil().setHeight(this.widget.size),
                  width: ScreenUtil().setWidth(this.widget.size),
                ),
                Offstage(
                  offstage: hideArmy,
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage("resource/images/armyBlueBackground.png"),
                        height: ScreenUtil().setHeight(this.widget.size - 30),
                        width: ScreenUtil().setWidth(this.widget.size - 30),
                      ),
                      Image(
                        image: AssetImage(
                          "resource/images/" + (hideArmy ? "rangeAttack" : ArmyType.getName(this.widget.armyCode)) + "Icon.png",
                        ),
                        height: ScreenUtil().setHeight(this.widget.size - 30),
                        width: ScreenUtil().setWidth(this.widget.size - 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              if (null == this.lastClickTime || (DateTime.now().millisecondsSinceEpoch - this.lastClickTime > 1000)) {
                if (this.widget.reWatch) {
                  return;
                }
                if (this.widget.attack) {
                  if (this.widget.armyCode > 0) {
                    setState(() {
                      baseFightLineUpProvider.changeAttackLineUp(this.widget.position[0], this.widget.position[1], 0);
                      this.widget.armyCode = 0;
                    });
                    return;
                  }

                  if (baseFightLineUpProvider.attackHeroCount >= 5) {
                    CommonUtils.showWarningMessage(msg: "最多只能排列5名士兵");
                    return;
                  }
                } else {
                  if (this.widget.armyCode > 0) {
                    setState(() {
                      baseFightLineUpProvider.changeProtectLineUp(this.widget.position[0], this.widget.position[1], 0);
                      this.widget.armyCode = 0;
                    });
                    return;
                  }
                  if (baseFightLineUpProvider.protectHeroCount >= 5) {
                    CommonUtils.showWarningMessage(msg: '最多只能添加5名士兵');
                    return;
                  }
                }

                Navigator.push(context, PopWindow(pageBuilder: (context) {
                  return SmallDetailDialog(
                    height: ScreenUtil().setHeight(650),
                    width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                    childWidgetName: 'armySelectDetail',
                    title: "选择兵种",
                    column: this.widget.position[0],
                    row: this.widget.position[1],
                    attack: this.widget.attack,
                  );
                }));
              }

              this.lastClickTime = DateTime.now().millisecondsSinceEpoch;
              // this.widget.contentName = null;
            });
      },
      requestedValues: [BaseFightLineupProvider],
    );
  }
}
