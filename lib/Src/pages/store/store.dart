import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/store/model/storeModel.dart';
import 'package:upgradegame/Src/pages/store/productItem.dart';
import 'package:upgradegame/Src/pages/store/storeService/storeService.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';

import 'model/buySuppliesModel.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.widget.HUD();
      StoreService.getSuppliesStoreList((data) {
        if (null != data) {
          setState(() {
            storeList = StoreListModel.fromJson(data).datalist;
          });
        }
        this.widget.HUD();
      });
    });
  }

  void buySupplies(String productId, BaseUserInfoProvider baseUserInfo) {
    this.widget.HUD();
    StoreService.buySupplies(productId, (BuySuppliesModel model) {
      this.widget.HUD();
      if (model != null) {
        CommonUtils.showSuccessMessage(msg: "购买物资成功");
        Provide.value<BaseUserInfoProvider>(context).buySupplies(model.tcoinamount);
        Provide.value<BaseFightLineupProvider>(context).buySupplies(model.suppliesamount);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogTop),
          ScreenUtil().setWidth(SystemScreenSize.detailDialogLeft), ScreenUtil().setHeight(SystemScreenSize.detailDialogBottom + 120)),
      child: Provide<BaseUserInfoProvider>(
        builder: (context, child, baseUserInfo) {
          return new Center(
            child: ListView.builder(
                itemCount: storeList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ProductItem(
                    volumeAmount: storeList == null ? "" : storeList[index].amount.toString(),
                    callback: () {
                      if(storeList[index].price > baseUserInfo.tcoinamount){
                        CommonUtils.showErrorMessage(msg: "您当前的金币数量不足");
                        return;
                      }

                      this.buySupplies(storeList[index].productid, baseUserInfo);
                    },
                    cashAmount: storeList == null ? "" : storeList[index].price.toString(),
                  );
                }),
          );
        },
      ),
    );
  }
}
