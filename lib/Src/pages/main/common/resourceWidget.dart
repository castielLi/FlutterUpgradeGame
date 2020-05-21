import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';

class ResourceWidget extends StatefulWidget {
  @override
  String amount;
  String imageUrl;
  double size;
  ResourceWidget({Key key,this.amount,this.imageUrl,this.size}):super(key:key);
  _ResourceWidgetState createState() => new _ResourceWidgetState();
}

class _ResourceWidgetState extends State<ResourceWidget> {


  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          child: Image(image: new AssetImage(this.widget.imageUrl),
            width: this.widget.size,
            height: this.widget.size,
            fit: BoxFit.fill,
          ),
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(10), ScreenUtil().setHeight(20), ScreenUtil().setWidth(10), ScreenUtil().setHeight(20)),
        ),
        new Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(this.widget.amount,textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: SystemFontSize.resourceTextFontSize)),
            ],
          ),
          padding: EdgeInsets.only(left: (this.widget.size + ScreenUtil().setWidth(15))),
        )
      ],
    );
  }
}