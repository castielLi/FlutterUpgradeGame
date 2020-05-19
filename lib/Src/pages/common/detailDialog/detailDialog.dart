import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

class DetailDialog extends StatefulWidget {

  double height;
  double width;
  DetailDialog({Key key,this.height,this.width}):super(key:key);


  @override
  _DetailDialogState createState() => new _DetailDialogState();
}

class _DetailDialogState extends State<DetailDialog> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new Container(
          margin: EdgeInsets.fromLTRB((ScreenUtil().setWidth(1080) - this.widget.width)/2,
              (ScreenUtil().setHeight(1920) - this.widget.height)/2,
              (ScreenUtil().setWidth(1080) - this.widget.width)/2,
              (ScreenUtil().setHeight(1920) - this.widget.height)/2),
              child:Center(
                child:
                new Image(image: new AssetImage('resource/images/detailDialogbackgroundImage.png'),
                  fit: BoxFit.fill,
                  height: widget.height ,
                  width: widget.width,
                ),
              ),
        ),
    );
  }
}