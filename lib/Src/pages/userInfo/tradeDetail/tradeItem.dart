import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class TradeItem extends StatefulWidget {
  // 交易日期
  String tDate;

  // 交易种类
  String tTypeImageUrl;

  // 交易数量
  int tAmount;

  // 花费金币
  int tCoin;

  TradeItem({Key key, this.tDate, this.tTypeImageUrl, this.tAmount, this.tCoin})
      : super(key: key);

  @override
  _TradeItem createState() => _TradeItem();
}

class _TradeItem extends State<TradeItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          this.widget.tDate,
          style: CustomFontSize.defaultTextStyle(55),
        ),
        Image(
          image: new AssetImage(this.widget.tTypeImageUrl),
          height: ScreenUtil().setHeight(100),
        ),
        Text(
          this.widget.tAmount.toString(),
          style: CustomFontSize.defaultTextStyle(55),
        ),
        Text(
          this.widget.tCoin.toString(),
          style: CustomFontSize.defaultTextStyle(55),
        ),
      ],
    );
  }
}
