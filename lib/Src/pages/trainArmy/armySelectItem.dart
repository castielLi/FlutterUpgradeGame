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
  bool reWatch;
  bool attack;

  ArmySelectItem({Key key, this.size, this.callback, this.armyCode = 0, this.position,this.reWatch,this.attack}) : super(key: key);

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
            // print(this.widget.position[0].toString() + this.widget.position[1].toString());

            if(this.widget.reWatch){
              return;
            }

            if(this.widget.attack) {
              if (this.widget.armyCode > 0) {
                setState(() {
                  baseFightLineUpProvider.changeAttackLineUp(
                      this.widget.position[0], this.widget.position[1], 0);
                  this.widget.armyCode = 0;
                });
                return;
              }
            }else {
              if (this.widget.armyCode > 0) {
                setState(() {
                  baseFightLineUpProvider.changeProtectLineUp(
                      this.widget.position[0], this.widget.position[1], 0);
                  this.widget.armyCode = 0;
                });
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



          },
        );
      },
      requestedValues: [BaseFightLineupProvider],
    );
  }
}
// showDialog(
//     context: context,
//     barrierDismissible: true,
//     builder: (army) {
//       return SimpleDialog(
//         title: Text(
//           '选择兵种',
//           textAlign: TextAlign.center,
//         ),
//         titlePadding: EdgeInsets.all(10),
//         elevation: 5,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
//         children: [
//           Container(
//             height: ScreenUtil().setHeight(500),
//             child: buildContent(this.armySelection),
//           ),
//         ],
//       );
//     });

// Widget buildContent(List armySelection) {
//   armySelection = ['rangeAttack', 'fighter', 'rider'];
//   List<Widget> content = [];
//   for (int i = 0; i < armySelection.length; i++) {
//     content.add(
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Stack(
//             children: [
//               Image(
//                 image: AssetImage("resource/images/armyBlueBackground.png"),
//                 height: ScreenUtil().setHeight(100),
//                 width: ScreenUtil().setWidth(100),
//               ),
//               Image(
//                 image: AssetImage(
//                   "resource/images/" + armySelection[i].toString() + "Icon.png",
//                 ),
//                 height: ScreenUtil().setHeight(100),
//                 width: ScreenUtil().setWidth(100),
//               ),
//             ],
//           ),
//           ImageButton(
//             buttonName: armySelection[i] == this.widget.armyIconImageUrl ? '取消' : '选择',
//             imageUrl: 'resource/images/upgradeButton.png',
//             textSize: SystemFontSize.bigTextSize,
//             width: ScreenUtil().setWidth(150),
//             height: ScreenUtil().setHeight(100),
//             callback: () {
//               if (armySelection[i] == this.widget.armyIconImageUrl) {
//                 setState(() {
//                   this.widget.armyIconImageUrl = '';
//                 });
//               } else {
//                 setState(() {
//                   this.widget.armyIconImageUrl = armySelection[i];
//                 });
//               }
//               // Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: content,
//   );
// }
