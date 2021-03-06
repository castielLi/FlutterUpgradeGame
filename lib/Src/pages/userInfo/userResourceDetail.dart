import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageText/imageText.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class UserResourceDetail extends StatefulWidget {
  String imageUrl;
  String amountCash;
  VoidCallback withdrawCallback;

  UserResourceDetail({Key key, this.amountCash, this.imageUrl, this.withdrawCallback}) : super(key: key);

  _UserResourceDetailState createState() => new _UserResourceDetailState();
}

class _UserResourceDetailState extends State<UserResourceDetail> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setHeight(160),
                height: ScreenUtil().setHeight(160),
                child: CircleAvatar(
                  radius: ScreenUtil().setHeight(80),
                  backgroundImage: NetworkImage(this.widget.imageUrl),
                ),
              ),
              ImageText(
                imageUrl: "resource/images/verified.png",
                imageHeight: ScreenUtil().setHeight(80),
                imageWidth: ScreenUtil().setHeight(280),
                textSize: SystemFontSize.userInfoResourceTextFontSize,
                text: "实名认证",
              )
            ],
          ),
          new Container(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Image(
                      image: new AssetImage("resource/images/cash.png"),
                      width: ScreenUtil().setHeight(120),
                      height: ScreenUtil().setHeight(120),
                      fit: BoxFit.fill,
                    ),
                    new Container(
                        height: ScreenUtil().setHeight(120),
                        width: ScreenUtil().setHeight(250),
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(182, 145, 98, 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: new Center(
                          child: Text("¥" + this.widget.amountCash,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(SystemFontSize.userInfoResourceWithdrawTextFontSize))),
                        ))
                  ],
                ),
                new ImageTextButton(
                  imageUrl: "resource/images/withdrawCash.png",
                  imageHeight: ScreenUtil().setHeight(100),
                  imageWidth: ScreenUtil().setHeight(300),
                  textSize: ScreenUtil().setSp(SystemFontSize.userInfoResourceWithdrawTextFontSize),
                  buttonName: "提 现",
                  callback: () {
                    this.widget.withdrawCallback();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
