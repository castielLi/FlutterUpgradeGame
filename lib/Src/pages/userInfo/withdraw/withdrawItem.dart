import 'package:flutter/material.dart';
import 'package:upgradegame/Common/app/config.dart';

class WithdrawItem extends StatefulWidget {
  // 日期
  String date;

  // 备注
  String detail;

  // 数量
  String change;

  WithdrawItem({Key key, this.date, this.detail, this.change}) : super(key: key);

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
          this.widget.date,
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
          this.widget.change.toString(),
          style: CustomFontSize.defaultTextStyle(SystemFontSize.settingTextFontSize),
        ),
      ],
    );
  }
}
