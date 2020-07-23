import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/pages/userInfo/event/userInfoEventBus.dart';
import 'package:upgradegame/Src/pages/userInfo/model/cashDetailModel.dart';
import 'package:upgradegame/Src/pages/userInfo/service/userInfoService.dart';
import 'package:upgradegame/Src/pages/userInfo/withdraw/withdrawItem.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';

class WithDrawDetail extends StatefulWidget {
  @override
  VoidCallback HUD;
  VoidCallback viewCallback;

  WithDrawDetail({Key key, this.HUD, this.viewCallback}) : super(key: key);

  _WithDrawDetailState createState() => new _WithDrawDetailState();
}

class _WithDrawDetailState extends State<WithDrawDetail> {

  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfoHttpRequestEvent().on("withdrawDetail",this.getWithdrawDetail);
  }

  void getWithdrawDetail(){
    print("开始请求withdrawdetail");
    this.widget.HUD();
    UserInfoService.getUserWithdrawDetail(this.page, (CashDetailModel model){
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
                '种类',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
              Text(
                '数量',
                style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
              ),
            ],
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(SystemButtonSize.settingsTextHeight),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (content, index) {
                return WithdrawItem(
                  tDate: '2020-06-04',
                  tTypeImageUrl: 'resource/images/coin.png',
                  tAmount: 2314,
                );
              }),
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
