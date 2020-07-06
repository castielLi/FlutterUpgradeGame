import 'package:flutter/material.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/common/widget/adDialog/adDialog.dart';

class AdIconRow extends StatefulWidget {
  double adIconHeight;
  int countInOneRow;
  int alreadyWatched;
  String imageUrlUnwatch;
  String imageUrlWatched;
  VoidCallback watchSuccessCallBack;

  AdIconRow({Key key, this.adIconHeight, this.countInOneRow, this.imageUrlUnwatch, this.alreadyWatched, this.imageUrlWatched, this.watchSuccessCallBack}) : super(key: key);

  @override
  _AdIconRow createState() => _AdIconRow();
}

class _AdIconRow extends State<AdIconRow> {
  void adFinishedCallback() {
    print("广告已经看完了要执行代码了");
  }

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
            ///type选择平台  1：adview 2：baidu 3：腾讯
            ///showType 选择展示 方式 1：开屏广告 2：视频广告
            ///posid 为可选则参数如果有第三个posid参数则用传过来的 否则为andorid模块内默认参数， posid为广告位id

            AdDialog().showAd(1, 2);
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
