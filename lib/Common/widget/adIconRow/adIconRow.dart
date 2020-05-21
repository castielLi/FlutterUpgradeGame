import 'package:flutter/material.dart';

class AdIconRow extends StatefulWidget{

  double adIconHeight = 50.0;
  int countInOneRow = 5;
  String imageUrl = 'resource/images/adIcon.png';
  @override
  _AdIconRow createState() => _AdIconRow();

}

class _AdIconRow extends State <AdIconRow>{

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        new Image(image: new AssetImage(this.widget.imageUrl), height:this.widget.adIconHeight),
        new Image(image: new AssetImage(this.widget.imageUrl), height:this.widget.adIconHeight),
        new Image(image: new AssetImage(this.widget.imageUrl), height:this.widget.adIconHeight),
        new Image(image: new AssetImage(this.widget.imageUrl), height:this.widget.adIconHeight),
        new Image(image: new AssetImage(this.widget.imageUrl), height:this.widget.adIconHeight)
      ],
    );
  }


}