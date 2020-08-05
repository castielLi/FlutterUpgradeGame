import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/store/model/storeModel.dart';
import 'package:upgradegame/Src/pages/store/model/voucherModel.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';
import 'package:upgradegame/Src/pages/store/storeService/storeService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

import 'model/buyVoucherWeChatResponseModel.dart';

class StoreDetail extends StatefulWidget {
  @override
  VoidCallback HUD;

  StoreDetail({Key key, this.HUD}) : super(key: key);

  _StoreDetailState createState() => new _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  List<StoreModel> storeList = [];

  String orderId = "";

  @override
  void initState() {
    super.initState();
    fluwx.weChatResponseEventHandler.listen((response) async {
      print("WeChatPaymentResponse" + response.errCode.toString());
      if (response.errCode == 0 && response is WeChatPaymentResponse) {
        StoreService.ConfirmOrder(this.orderId, (VoucherModel model) {
          this.widget.HUD();
          if (model != null) {
            Provide.value<BaseUserInfoProvider>(context).buyVoucher(model.amount);
          }
//          fluwx.weChatResponseEventHandler.skip(1);
        });
      } else if (response.errCode == -2 && response is WeChatPaymentResponse) {
        this.widget.HUD();
        CommonUtils.showErrorMessage(msg: "已经取消购买");
      }
      // eventBus.fire(new RefreshMineInfo(true));
      // Navigator.of(context).pop();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      StoreService.getStoreList((data) {
        if (null != data) {
          setState(() {
            storeList = StoreListModel.fromJson(data).datalist;
          });
        }
        this.widget.HUD();
      });
    });
  }

  void buyVoucher(String productId, BaseUserInfoProvider baseUserInfo) {
    this.widget.HUD();
    StoreService.buyVoucher(productId, (BuyVoucherWeChatResponseModel model) {
      if (model != null) {
        this.orderId = model.orderid;
        fluwx
            .payWithWeChat(
                appId: model.appid,
                partnerId: model.partnerid,
                prepayId: model.prepayid,
                packageValue: model.package,
                nonceStr: model.noncestr,
                timeStamp: int.parse(model.timestamp),
                sign: model.sign)
            .then((data) {
          print(data);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
//      color:Colors.red,
      margin: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(100), // 左
          ScreenUtil().setHeight(400), // 上
          ScreenUtil().setWidth(100), // 右
          ScreenUtil().setHeight(200)), // 下
      child: Provide<BaseUserInfoProvider>(
        builder: (context, child, baseUserInfo) {
          return new Center(
            child: ListView.builder(
                itemCount: storeList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return new ProductItem(
                    volumeAmount: storeList == null ? "" : storeList[index].amount.toString(),
                    callback: () {
                      this.buyVoucher(storeList[index].productid, baseUserInfo);
                    },
                    cashAmount: storeList == null ? "" : storeList[index].price,
                  );
                }),
          );
        },
      ),
    );
  }
}
