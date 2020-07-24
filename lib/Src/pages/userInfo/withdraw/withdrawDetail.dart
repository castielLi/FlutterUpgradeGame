import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/userInfo/event/userInfoEventBus.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashDetailModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/pages/userInfo/withdraw/withdrawItem.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Common/widget/toast/toast.dart';

class WithDrawDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  WithDrawDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithDrawDetailState createState() => new _WithDrawDetailState();
}

class _WithDrawDetailState extends State<WithDrawDetail> {
  CashDetailModel cashDetailModel = new CashDetailModel(total: 0,page: 0,datalist: []);
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfoHttpRequestEvent().on("withdrawDetail",this.getWithdrawDetail);
  }

  void getWithdrawDetail(){
    this.widget.HUD();
    UserInfoService.getUserWithdrawDetail(this.page, (CashDetailModel model){
      //测试数据
//      model.datalist =[new Datalist(datetime: "2020-07-24",detail: "购买英雄",change:"100")];
//      for (int i = 0; i < 3; i++) {
//        model.datalist += model.datalist;
//      }
      if(null==model){
        return;
      }
      this.cashDetailModel.page = model.page;
      if(this.page==0){
        this.cashDetailModel.datalist = [];
      }
      if(model.datalist.length==0){
        CommonUtils.showErrorMessage(msg: "没有更多了");
      }
      this.cashDetailModel.datalist += model.datalist;
      print("page:"+this.page.toString()+", data length:"+this.cashDetailModel.datalist.length.toString());
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
        Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(150)),
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
          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
          child: EasyRefresh(
            refreshFooter: ClassicsFooter(
              bgColor: Colors.transparent,
              loadText: "上滑加载",
              loadReadyText: "松开加载",
              loadingText: "正在加载",
              loadedText: "加载完成",
              noMoreText: "没有更多了",
              loadHeight: 35,
              key: new GlobalKey<RefreshFooterState>(),
            ),
            refreshHeader: ClassicsHeader(
              bgColor: Colors.transparent,
              refreshText: "下拉刷新",
              refreshReadyText: "松开刷新",
              refreshingText: "正在刷新",
              refreshedText: "刷新完成",
              refreshHeight: 35,
              key: new GlobalKey<RefreshHeaderState>(),
            ),
            // ignore: missing_return
            loadMore: () {
              setState(() {
                this.page++;
                getWithdrawDetail();
              });
            },
            // ignore: missing_return
            onRefresh: () {
              setState(() {
                this.page = 0;
                getWithdrawDetail();
              });
            },
            child: ListView.builder(
                itemCount: this.cashDetailModel==null?0:this.cashDetailModel.datalist.length,
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
