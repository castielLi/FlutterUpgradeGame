import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';

class TradeItem extends StatefulWidget {
  // 交易日期
  String tDate;

  // 备注
  String detail;

  // 花费金币
  String tCoin;

  TradeItem({Key key, this.tDate, this.detail, this.tCoin}) : super(key: key);

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
          style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
        ),
        Expanded(
          child: Text(
            this.widget.detail,
            textAlign: TextAlign.center,
            style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
          ),
        ),
        Text(
          this.widget.tCoin,
          style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
        ),
      ],
    );
  }
}
