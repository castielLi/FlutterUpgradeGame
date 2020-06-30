import 'package:flutter/material.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/service/adService.dart';

class AdIconRow extends StatefulWidget {
  double adIconHeight;
  int countInOneRow;
  int alreadyWatched;
  String imageUrlUnwatch;
  String imageUrlWatched;
  VoidCallback watchSuccessCallBack;
  static int testAdType = 2;

  AdIconRow({Key key, this.adIconHeight, this.countInOneRow, this.imageUrlUnwatch, this.alreadyWatched, this.imageUrlWatched, this.watchSuccessCallBack}) : super(key: key);

  @override
  _AdIconRow createState() => _AdIconRow();
}

class _AdIconRow extends State<AdIconRow> {
  Widget buildList() {
    List<Widget> adIconList = [];
    Widget content;
    for (int i = 0; i < this.widget.alreadyWatched; i++) {
      adIconList.add(
        GestureDetector(
          child: new Image(image: new AssetImage(this.widget.imageUrlWatched), height: this.widget.adIconHeight),
          onTap: () {
            CommonUtils.showErrorMessage(msg: '您已经看过该广告了');
          },
        ),
      );
    }
    for (int i = 0; i < (this.widget.countInOneRow - this.widget.alreadyWatched); i++) {
      adIconList.add(
        GestureDetector(
          child: new Image(image: new AssetImage(this.widget.imageUrlUnwatch), height: this.widget.adIconHeight),
          onTap: () {
            AdService as = new AdService();
            as.adWatchSuccessCallback = this.widget.watchSuccessCallBack;
            AdIconRow.testAdType = AdIconRow.testAdType == 1 ? 2 : 1;
            as.showAd(1, AdIconRow.testAdType);
          },
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
