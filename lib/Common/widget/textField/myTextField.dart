import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class MyTextField extends StatefulWidget {
  double height;
  TextEditingController controller;
  String hintText;
  Icon icon;
  bool obscureText;
  TextInputType inputType = TextInputType.text;
  VoidCallback onSubmittedCallback;
  VoidCallback onChanged;
  String warningText;
  double warningTextFontSize;

  MyTextField({this.warningTextFontSize,this.warningText = "", this.height, this.controller, this.hintText, this.icon, this.inputType, this.obscureText, this.onChanged, this.onSubmittedCallback});

  _MyTextFieldState createState() => new _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    if (null == this.widget.obscureText) {
      this.widget.obscureText = false;
    }
    if (null == this.widget.inputType) {
      this.widget.inputType = TextInputType.text;
    }
    if(null == this.widget.warningTextFontSize){
      this.widget.warningTextFontSize = SystemFontSize.normalTextSize;
    }
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: this.widget.height,
          child: new Card(
              child: new Container(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: TextField(
                      controller: this.widget.controller,
                      keyboardType: this.widget.inputType,
                      obscureText: this.widget.obscureText,
                      decoration: new InputDecoration(hintText: this.widget.hintText, border: InputBorder.none, prefixIcon: this.widget.icon),
                      onSubmitted: (input) {
                        this.widget.onSubmittedCallback();
                      },
                      // onChanged: onSearchTextChanged,
                      onChanged: (input) {
                        this.widget.onChanged();
                      },
                    ),
                  ),
                ),
                new IconButton(
                  icon: new Icon(Icons.cancel),
                  color: Colors.grey,
                  iconSize: 18.0,
                  onPressed: () {
                    this.widget.controller.clear();
                  },
                ),
              ],
            ),
          )),
        ),
        new Container(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: new Text(
            this.widget.warningText,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: ScreenUtil().setSp(this.widget.warningTextFontSize), color: Colors.white, decoration: TextDecoration.none),
          ),
        ),
      ],
    );
  }
}
