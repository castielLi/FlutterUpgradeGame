import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/trainArmy/armySelectItem.dart';

class ArmySelectMatrix extends StatefulWidget {
  VoidCallback HUD;
  List armyBaseMatrix;

  ArmySelectMatrix({Key key, this.HUD}) : super(key: key);

  _ArmySelectMatrixState createState() => new _ArmySelectMatrixState();
}

class _ArmySelectMatrixState extends State<ArmySelectMatrix> {
  @override
  Widget build(BuildContext context) {
    this.widget.armyBaseMatrix = [
      ["", "rider", "rangeAttack"],
      ["", "fighter", ""],
      ["", "", "fighter"],
      ["", "", ""],
      ["rider", "", ""]
    ];
    return buildContent();
  }

  Widget buildContent() {
    List<Widget> content = [];
    for (int i = 0; i < this.widget.armyBaseMatrix.length; i++) {
      content.add(
        buildRow(this.widget.armyBaseMatrix[i]),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: content,
    );
  }

  Widget buildRow(List<String> rowArmy) {
    List<Widget> content = [];
    for (int i = 0; i < rowArmy.length; i++) {
      content.add(
        ArmySelectItem(
          size: 225,
          armyIconImageUrl:rowArmy[i],
          callback: () {
            print(rowArmy[i].toString());
          },
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: content,
    );
  }
}
