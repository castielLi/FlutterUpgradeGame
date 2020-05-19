import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Src/pages/farm/farm.dart';

class DetailDialog extends StatefulWidget {

  double height;
  double width;
  String childWidgetName;
  DetailDialog({Key key,this.height,this.width,this.childWidgetName}):super(key:key);


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

    Widget currentWidget;
    if(this.widget.childWidgetName == 'farmDetail'){
        currentWidget = new FarmDetail();
    }

    return new Container(
      child: new Container(
          margin: EdgeInsets.fromLTRB((ScreenUtil().setWidth(1080) - this.widget.width)/2,
              (ScreenUtil().setHeight(1920) - this.widget.height)/2,
              (ScreenUtil().setWidth(1080) - this.widget.width)/2,
              (ScreenUtil().setHeight(1920) - this.widget.height)/2),
              child:Stack(
                children: <Widget>[
                  Center(
                    child:
                    new Image(image: new AssetImage('resource/images/detailDialogbackgroundImage.png'),
                      fit: BoxFit.fill,
                      height: widget.height ,
                      width: widget.width,
                    ),
                  ),
                   currentWidget
                ],
              )
        ),
    );
  }
}