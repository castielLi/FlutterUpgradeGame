import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Src/common/model/hero.dart';
import 'package:upgradegame/Src/pages/AdDividend/adPool.dart';
import 'package:upgradegame/Src/pages/adDividend/model/AdDividendModel.dart';
import 'package:upgradegame/Src/pages/adDividend/service/adDividendService.dart';

class AdDividendDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  AdDividendDetail({Key key, this.HUD}) : super(key: key);

  _AdDividendDetailState createState() => new _AdDividendDetailState();
}

class _AdDividendDetailState extends State<AdDividendDetail> {
  AdDividendModel warrior = AdDividendModel(type: Heroes.WARRIOR);
  AdDividendModel shaman = AdDividendModel(type: Heroes.SHAMAN);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      AdDividendService.getAdDividendList((data) {
        if (null != data) {
          List<AdDividendModel> adDividendDataList = AdDividendListModel.fromJson(data).datalist;
          setState(() {
            if (null != adDividendDataList) {
              adDividendDataList.forEach((adDividend) {
                switch (adDividend.type) {
                  case Heroes.WARRIOR:
                    warrior = adDividend;
                    break;
                  case Heroes.SHAMAN:
                    shaman = adDividend;
                }
              });
            }
          });
        }
        this.widget.HUD();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(80), // 左
          ScreenUtil().setHeight(350), // 上
          ScreenUtil().setWidth(80), // 右
          ScreenUtil().setHeight(200)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AdPool(heroImageUrl: 'resource/images/warrior.png', poolName: '勇士', adDividend: warrior),
          AdPool(heroImageUrl: 'resource/images/shaman.png', poolName: '萨满', adDividend: shaman),
        ],
      ),
    );
  }
}
