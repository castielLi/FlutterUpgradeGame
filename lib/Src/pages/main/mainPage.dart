import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/route/application.dart';
import 'package:upgradegame/Src/route/upgradegame_route.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return new Container(
      color: Colors.white,
      child: Stack(

        children: <Widget>[
          new Image(image: new AssetImage('resource/images/mainBackgroud.png'),
            width: 1920,
            height: 1080,
            fit: BoxFit.fill,
          ),
          new RaisedButton(onPressed: (){
            Application.showDetailDialog(context, UpgradeGameRoute.detailDialogPage);
          }),
        ],
      ),
    );
  }
}