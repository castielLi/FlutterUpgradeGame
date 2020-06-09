import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
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
                style: CustomFontSize.textStyle22,
              ),
              Text(
                '种类',
                style: CustomFontSize.textStyle22,
              ),
              Text(
                '数量',
                style: CustomFontSize.textStyle22,
              ),
            ],
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(800),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (content, index) {
                return WithdrawItem(
                  tDate: '2020-06-04',
                  tTypeImageUrl: 'resource/images/gold.png',
                  tAmount: 2314,
                );
              }),
        ),
        new ImageButton(
          height: ScreenUtil().setHeight(160),
          width: ScreenUtil().setWidth(320),
          buttonName: "返回",
          imageUrl: "resource/images/upgradeButton.png",
          callback: () {
            print('点击升级');
//                this.widget.HUD();
            this.widget.viewCallback();
          },
        ),
      ],
    );
  }
}
