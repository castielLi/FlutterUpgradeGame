import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
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
  List<AdDividendModel> adDividendDataList;
  AdDividendModel warrior = AdDividendModel(type: Heroes.WARRIOR);
  AdDividendModel hunter = AdDividendModel(type: Heroes.HUNTER);
  AdDividendModel shaman = AdDividendModel(type: Heroes.SHAMAN);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      AdDividendService.getAdDividendList().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            adDividendDataList =
                AdDividendListModel.fromJson(data.data).datalist;
            if (null != adDividendDataList) {
              adDividendDataList.forEach((adDividend) {
                switch (adDividend.type) {
                  case Heroes.WARRIOR:
                    warrior = adDividend;
                    break;
                  case Heroes.HUNTER:
                    hunter = adDividend;
                    break;
                  case Heroes.SHAMAN:
                    shaman = adDividend;
                }
              });
            }
          });
        } else {
          CommonUtils.showErrorMessage(msg: "网络请求失败，请重试");
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
        children: <Widget>[
          AdPool(
              heroImageUrl: 'resource/images/warrior.png',
              poolName: '勇士',
              adDividend: warrior),
          AdPool(
              heroImageUrl: 'resource/images/hunter.png',
              poolName: '猎人',
              adDividend: hunter),
          AdPool(
              heroImageUrl: 'resource/images/shaman.png',
              poolName: '萨满',
              adDividend: shaman),
        ],
      ),
    );
  }
}
