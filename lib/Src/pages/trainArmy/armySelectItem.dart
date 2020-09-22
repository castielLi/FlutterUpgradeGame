import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/model/const/resource.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/smallDetailDialog.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class ArmySelectItem extends StatefulWidget {
  double size;
  VoidCallback callback;
  int armyCode;
  List position; // 在矩阵中的位置
  ArmySelectItem({
    Key key,
    this.size,
    this.callback,
    this.armyCode = 0,
    this.position,
  }) : super(key: key);

  @override
  _ArmySelectItem createState() => new _ArmySelectItem();
}

class _ArmySelectItem extends State<ArmySelectItem> {
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
            if (this.widget.armyCode > 0) {
              setState(() {
                baseFightLineUpProvider.changeProtectLineUp(this.widget.position[0], this.widget.position[1], 0);
                this.widget.armyCode = 0;
              });
              return;
            }

            Navigator.push(context, PopWindow(pageBuilder: (context) {
              return SmallDetailDialog(
                height: ScreenUtil().setHeight(650),
                width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
                childWidgetName: 'armySelectDetail',
                title: "选择兵种",
                column: this.widget.position[0],
                row: this.widget.position[1],
              );
            }));
          },
        );
      },
      requestedValues: [BaseFightLineupProvider],
    );
  }
}
