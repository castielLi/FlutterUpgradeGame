import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/http/configSetting.dart';
import 'package:upgradegame/Common/http/resultData.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

import 'package:upgradegame/Src/pages/store/model/storeModel.dart';
import 'package:upgradegame/Src/pages/store/model/voucherModel.dart';
import 'package:upgradegame/Src/pages/store/storeService/storeService.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class StoreDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  StoreDetail({Key key, this.HUD}) : super(key: key);

  _StoreDetailState createState() => new _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  List<StoreModel> storeList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      StoreService.getStoreList().then((data) {
        if (data.code == ConfigSetting.SUCCESS && data.data != null) {
          setState(() {
            storeList = StoreListModel.fromJson(data.data).datalist;
          });
        } else {
          CommonUtils.showErrorMessage(msg: "网络请求失败，请重试");
        }
        this.widget.HUD();
      });
    });
  }

  void buyVoucher(String productId,BaseUserInfoProvider baseUserInfo) {
    this.widget.HUD();
    StoreService.buyVoucher(productId,(VoucherModel model) {
      this.widget.HUD();
      if(model!=null) {
        baseUserInfo.buyVoucher(model.voucher);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(80), // 左
            ScreenUtil().setHeight(280), // 上
            ScreenUtil().setWidth(80), // 右
            ScreenUtil().setHeight(100)), // 下
        child: Provide<BaseUserInfoProvider>(builder: (context, child, baseUserInfo) {
          return new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ProductItem(
                  volumeAmount: storeList == null ? "" : storeList[0].amount.toString(),
                  callback: () {
                    this.buyVoucher(storeList[0].productid,baseUserInfo);
                  },
                  cashAmount: storeList == null ? "" : storeList[0].price.toString(),
                ),
                new ProductItem(
                  volumeAmount: storeList == null ? "" : storeList[1].amount.toString(),
                  callback: () {
                    this.buyVoucher(storeList[1].productid,baseUserInfo);
                  },
                  cashAmount: storeList == null ? "" : storeList[1].price.toString(),
                ),
                new ProductItem(
                  volumeAmount: storeList == null ? "" : storeList[2].amount.toString(),
                  callback: () {
                    this.buyVoucher(storeList[2].productid,baseUserInfo);
                  },
                  cashAmount: storeList == null ? "" : storeList[2].price.toString(),
                ),
                new ProductItem(
                  volumeAmount: storeList == null ? "" : storeList[3].amount.toString(),
                  callback: () {
                    this.buyVoucher(storeList[3].productid,baseUserInfo);
                  },
                  cashAmount: storeList == null ? "" : storeList[3].price.toString(),
                )
              ],
            ),
          );
        }));
  }
}
