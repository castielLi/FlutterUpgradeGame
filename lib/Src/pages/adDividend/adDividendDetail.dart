import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/AdDividend/adPool.dart';
import 'package:upgradegame/Src/pages/adDividend/model/AdDividendModel.dart';
import 'package:upgradegame/Src/pages/adDividend/model/heroProfitModel.dart';
import 'package:upgradegame/Src/pages/adDividend/service/adDividendService.dart';

class AdDividendDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  AdDividendDetail({Key key, this.HUD}) : super(key: key);

  _AdDividendDetailState createState() => new _AdDividendDetailState();
}

class _AdDividendDetailState extends State<AdDividendDetail> {
  HeroProfitModel warrior = HeroProfitModel(total: 0, product: 0, price: "0");
  HeroProfitModel shaman = HeroProfitModel(total: 0, product: 0, price: "0");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      AdDividendService.getAdDividendList((AdDividendListModel model) {
        if (null != model) {
          setState(() {
            warrior = HeroProfitModel(total: model.onetotal, price: model.oneyesterdayprice, product: model.oneproduct);
            shaman = HeroProfitModel(total: model.threetotal, price: model.threeyesterdayprice, product: model.threeproduct);
          });
        }
        this.widget.HUD();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AdPool(heroImageUrl: 'resource/images/warrior.png', adDividend: warrior),
          AdPool(heroImageUrl: 'resource/images/shaman.png', adDividend: shaman),
        ],
      ),
    );
  }
}
