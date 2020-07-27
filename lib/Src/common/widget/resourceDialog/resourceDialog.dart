import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageButton/imageButton.dart';
import 'package:upgradegame/Src/common/widget/resourceDialog/enum/resourceDialogEnum.dart';
import 'package:upgradegame/Src/common/widget/resourceDialog/model/resourceDialogModel.dart';
import 'package:upgradegame/Src/route/application.dart';


class ResourceDialog extends StatefulWidget {
  double height;
  double width;
  List<ResourceDialogModel> source;

  ResourceDialog({Key key, this.height, this.width,this.source}) : super(key: key);

  @override
  _ResourceDialogState createState() => new _ResourceDialogState();
}

class _ResourceDialogState extends State<ResourceDialog> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    new Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      //直接进入首页
      Application.router
          .pop(context);
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> sourceList = [];

    Widget content;
    for (int i = 0; i < this.widget.source.length; i++) {
      String imageUrl = "";
      switch(this.widget.source[0].type){
        case ResourceDialogEnum.wood:
          imageUrl = "resource/images/resourceDialogBackground.png";
          break;
        case ResourceDialogEnum.stone:
          imageUrl = "resource/images/resourceDialogBackground.png";
          break;
        case ResourceDialogEnum.coin:
          imageUrl = "resource/images/resourceDialogBackground.png";
          break;
        case ResourceDialogEnum.contribution:
          imageUrl = "resource/images/resourceDialogBackground.png";
          break;
      }

      sourceList.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Expanded(
              child: new Image(
                image: new AssetImage(imageUrl),
                fit: BoxFit.fill,
                height: 200,
                width: 200,
              ),
            ),
            new Expanded(
              child: new Text(this.widget.source[0].amount,textAlign: TextAlign.right
                ,style:  TextStyle(color: Colors.white,decoration: TextDecoration.none,
                    fontSize: ScreenUtil().setSp(12)),),
            )
          ],
        )
      );
    }

    content = new Column(
      children: <Widget>[
        new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: sourceList
        ),
      ],
    );

    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil().setWidth(1080),
          height: ScreenUtil().setHeight(1920),
          child: new Container(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB((ScreenUtil().setWidth(1080) - this.widget.width) / 2, (ScreenUtil().setHeight(1920) - this.widget.height) / 2,
                  (ScreenUtil().setWidth(1080) - this.widget.width) / 2, (ScreenUtil().setHeight(1920) - this.widget.height) / 2),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: new Image(
                      image: new AssetImage('resource/images/resourceDialogBackground.png'),
                      fit: BoxFit.fill,
                      height: widget.height,
                      width: widget.width,
                    ),
                  ),
                  content,
                ],
              )),
        ),
      ),
    );
  }
}
