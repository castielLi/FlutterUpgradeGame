import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class UserImageButton extends StatefulWidget {
  String buttonName;
  String imageUrl;
  VoidCallback callback;
  double size;
  double textSize;
  bool netWorkImage;
  String netWorkImageUrl;
  Color textColor;

  UserImageButton({Key key, this.textColor = Colors.white, this.buttonName = "", this.imageUrl, this.callback, this.size, this.textSize = 0, this.netWorkImage = false, this.netWorkImageUrl = ""})
      : super(key: key);

  _UserImageButtonState createState() => new _UserImageButtonState();
}

class _UserImageButtonState extends State<UserImageButton> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.textSize == 0) {
      this.widget.textSize = SystemFontSize.buttonTextFontSize;
    }
    return new Container(
      height: this.widget.size,
      width: this.widget.size,
      child: new GestureDetector(
        child: new Stack(
          children: <Widget>[
            new Offstage(
                offstage: !this.widget.netWorkImage,
                child: CircleAvatar(
                  radius: ScreenUtil().setHeight(60),
                  backgroundImage: NetworkImage(this.widget.netWorkImageUrl),
                )),
            new Offstage(
              offstage: this.widget.netWorkImage,
              child: Container(
                margin: EdgeInsets.all(ScreenUtil().setWidth(2)),
                decoration: BoxDecoration(
                  image: DecorationImage(image: new AssetImage(this.widget.imageUrl), fit: BoxFit.fill),
                ),
                child: Center(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      this.widget.buttonName,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: this.widget.textColor, decoration: TextDecoration.none, fontSize: ScreenUtil().setSp(this.widget.textSize)),
                    ),
                  ],
                )),
              ),
            )
          ],
        ),
        onTap: () {
          this.widget.callback();
        },
      ),
    );
  }
}
