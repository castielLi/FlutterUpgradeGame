import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/common/widget/detailDialog/detailDialog.dart';
import 'package:upgradegame/Src/provider/baseDialogClickProvider.dart';
import 'package:upgradegame/Src/route/application.dart';

class ArmySelectItem extends StatefulWidget {
  double size;
  VoidCallback callback;
  int armyCode;

  ArmySelectItem({Key key, this.size, this.callback, this.armyCode=0}) : super(key: key);

  @override
  _ArmySelectItem createState() => new _ArmySelectItem();
}

class _ArmySelectItem extends State<ArmySelectItem> {
  // List armySelection = ['rangeAttack', 'fighter', 'rider'];

  @override
  Widget build(BuildContext context) {

    bool hideArmy = (this.widget.armyCode==0);
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
                    "resource/images/" + (hideArmy ? "rangeAttack" : "") + "Icon.png",
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
            this.widget.armyCode = 0;
          });
          return;
        }
        if (!Provide.value<BaseDialogClickProvider>(context).hasClickDialog) {
          Navigator.push(context, PopWindow(pageBuilder: (context) {
            return DetailDialog(
              height: ScreenUtil().setHeight(SystemScreenSize.detailDialogHeight),
              width: ScreenUtil().setWidth(SystemScreenSize.detailDialogWidth),
              childWidgetName: 'armySelectDetail',
              title: "选择兵种",
            );
          }));
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
      },
    );
  }

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
}
