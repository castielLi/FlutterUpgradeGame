import 'package:flutter/material.dart';
import 'package:upgradegame/Src/pages/trainArmy/armySelectItem.dart';

class ArmySelectMatrix extends StatefulWidget {
  VoidCallback HUD;
  List armyBaseMatrix;
  double itemSize;
  bool attack;
  bool reWatch;

  ArmySelectMatrix(
      {Key key,
      this.HUD,
      this.itemSize,
      this.armyBaseMatrix,this.attack,this.reWatch})
      : super(key: key);

  _ArmySelectMatrixState createState() => new _ArmySelectMatrixState();
}

class _ArmySelectMatrixState extends State<ArmySelectMatrix> {
  @override
  Widget build(BuildContext context) {
    if(null==this.widget.armyBaseMatrix){
      this.widget.armyBaseMatrix = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ];
    }
    return buildContent();
  }

  Widget buildContent() {
    List<Widget> content = [];
    for (int i = 0; i < this.widget.armyBaseMatrix.length; i++) {
      content.add(
        buildRow(i, this.widget.armyBaseMatrix[i]),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: content,
    );
  }

  Widget buildRow(int column, List rowArmy) {
    List<Widget> content = [];
    for (int i = 0; i < rowArmy.length; i++) {
      content.add(
        ArmySelectItem(
          size: this.widget.itemSize,
          armyCode: rowArmy[i],
          position: [column, i], //[行，列]
          callback: () {},
          attack: this.widget.attack,
          reWatch: this.widget.reWatch,
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: content,
    );
  }
}
