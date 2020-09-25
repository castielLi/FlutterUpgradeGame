import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/MyEasyRefresh/myEasyRefresh.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';
import 'package:upgradegame/Src/pages/userInfo/event/userInfoEventBus.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashDetailModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/pages/userInfo/withdraw/withdrawItem.dart';

class WithDrawDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  WithDrawDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithDrawDetailState createState() => new _WithDrawDetailState();
}

class _WithDrawDetailState extends State<WithDrawDetail> {
  CashDetailModel cashDetailModel = new CashDetailModel(total: 0, page: 0, datalist: []);
  int page = 0;
  String noTxText = '';

  @override
  void initState() {
    super.initState();
    UserInfoHttpRequestEvent().on("withdrawDetail", this.getWithdrawDetail);
  }

  void getWithdrawDetail() {
    this.widget.HUD();
    UserInfoService.getUserWithdrawDetail(this.page, (CashDetailModel model) {
      if (null == model) {
        return;
      }
      this.cashDetailModel.page = model.page;
      if (this.page == 0) {
        this.cashDetailModel.datalist = [];
      }
      if (model.datalist.length == 0) {
        this.noTxText = "目前没有记录";
        if (this.page != 0) {
          CommonUtils.showErrorMessage(msg: "没有更多了");
        }
      }
      this.cashDetailModel.datalist += model.datalist;
      this.widget.HUD();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        this.cashDetailModel.datalist.length == 0
            ? Text(
                this.noTxText,
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              )
            : Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(100)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '日期',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                    ),
                    Text(
                      '事项',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                    ),
                    Text(
                      '金额',
                      style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
                    ),
                  ],
                ),
              ),
        Container(
          height: ScreenUtil().setHeight(SystemScreenSize.displayContentHeight),
          child: MyEasyRefresh(
            // ignore: missing_return
            loadMoreCallback: () {
              setState(() {
                this.page++;
                getWithdrawDetail();
              });
            },
            // ignore: missing_return
            onRefreshCallback: () {
              setState(() {
                this.page = 0;
                getWithdrawDetail();
              });
            },
            child: ListView.builder(
                itemCount: this.cashDetailModel == null ? 0 : this.cashDetailModel.datalist.length,
                itemBuilder: (content, index) {
                  Datalist cashTx = this.cashDetailModel.datalist[index];
                  return WithdrawItem(
                    date: cashTx.datetime,
                    detail: cashTx.detail,
                    change: cashTx.change,
                  );
                }),
          ),
        ),
        new ImageButton(
          height: ScreenUtil().setHeight(SystemButtonSize.largeButtonHeight),
          width: ScreenUtil().setWidth(SystemButtonSize.largeButtonWidth),
          buttonName: "返回",
          imageUrl: "resource/images/upgradeButton.png",
          callback: () {
//                this.widget.HUD();
            this.widget.viewCallback();
          },
        ),
      ],
    );
  }
}
