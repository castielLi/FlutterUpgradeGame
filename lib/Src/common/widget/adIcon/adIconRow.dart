import 'package:flutter/material.dart';

class AdIconRow extends StatefulWidget{

  double adIconHeight;
  int countInOneRow;
  int alreadyWatched;
  String imageUrlUnwatch;
  String imageUrlWatched;

  AdIconRow({Key key,this.adIconHeight,this.countInOneRow,this.imageUrlUnwatch,this.alreadyWatched,this.imageUrlWatched}):super(key:key);

  @override
  _AdIconRow createState() => _AdIconRow();

}

class _AdIconRow extends State <AdIconRow>{


  Widget buildList(){
    List <Widget> adIconList = [];
    Widget content;
    for(int i=0;i<this.widget.alreadyWatched;i++){
      adIconList.add(
        GestureDetector(
          child: new Image(image: new AssetImage(this.widget.imageUrlWatched), height:this.widget.adIconHeight),
          onTap: (){print('点击广告');},
        ),

      );
    }
    for(int i=0;i<(this.widget.countInOneRow - this.widget.alreadyWatched);i++){
      adIconList.add(
        GestureDetector(
          child: new Image(image: new AssetImage(this.widget.imageUrlUnwatch), height:this.widget.adIconHeight),
          onTap: (){print('点击广告');},
        ),

      );
    }
    content = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: adIconList,
    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
      return buildList();
  }


}