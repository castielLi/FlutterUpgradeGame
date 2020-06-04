import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class WithdrawItem extends StatefulWidget {
  // 提现日期
  String tDate;

  // 提现种类
  String tTypeImageUrl;

  // 提现数量
  int tAmount;

  WithdrawItem({Key key, this.tDate, this.tTypeImageUrl, this.tAmount})
      : super(key: key);

  @override
  _WithdrawItem createState() => _WithdrawItem();
}

class _WithdrawItem extends State<WithdrawItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          this.widget.tDate,
          style: CustomFontSize.textStyle22,
        ),
        Image(
          image: new AssetImage(this.widget.tTypeImageUrl),
          height: ScreenUtil().setHeight(100),
        ),
        Text(
          this.widget.tAmount.toString(),
          style: CustomFontSize.textStyle22,
        ),
      ],
    );
  }
}
