import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FarmDetail extends StatefulWidget {

  @override
  _FarmDetailState createState() => new _FarmDetailState();
}

class _FarmDetailState extends State<FarmDetail> {



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(300), ScreenUtil().setWidth(100), ScreenUtil().setHeight(120)),
        color: Colors.black,
        child:Center(
          child:
          new Image(image: new AssetImage('resource/images/welcome.png'),
            fit: BoxFit.fill,
            height: 100 ,
            width: 100,
          ),
        ),
      ),
    );
  }
}