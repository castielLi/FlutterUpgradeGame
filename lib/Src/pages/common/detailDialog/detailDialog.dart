import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

class DetailDialog extends StatefulWidget {
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
          width: 100,
          height: 100,
          color: Colors.red,
          margin: EdgeInsets.fromLTRB(0,200,0,200),
              child:Center(
                child:
                new Image(image: new AssetImage('resource/images/welcome.png'),
                 fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                ),
              ),
        ),
    );
  }
}