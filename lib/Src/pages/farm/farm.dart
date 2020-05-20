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
//    var textStyle32 = TextStyle(fontSize: 32.0, color: Colors.white,
//        decoration: TextDecoration.none);

    return new Container(
      child: new Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(150),
            ScreenUtil().setHeight(400),
            ScreenUtil().setWidth(150),
            ScreenUtil().setHeight(180)),
        color: Colors.transparent,
        child: ListView(
          itemExtent: 60,// list高度
          children: <Widget>[
            Text('LV 12 > LV 13',textAlign:TextAlign.left,style: TextStyle(fontSize: 32.0, color: Colors.white,
                decoration: TextDecoration.none),),
            Text('升级所需资料',style: TextStyle(fontSize: 32.0, color: Colors.white,
                decoration: TextDecoration.none),),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Image(image: new AssetImage('resource/images/wood.png'),
                    height:30),
                Text('2910 ',style: TextStyle(fontSize: 30.0, color: Colors.white,
                  decoration: TextDecoration.none,),),
                new Image(image: new AssetImage('resource/images/stone.png'),
                    height:30),
                Text('2910',style: TextStyle(fontSize: 30.0, color: Colors.white,
                  decoration: TextDecoration.none,)),
              ],
            ),
            Text('升级后产出:291T币一小时',style:TextStyle(fontSize: 23.0, color: Colors.white,
              decoration: TextDecoration.none,),),
            RaisedButton(onPressed: (){},
              child: Text('升级'),

            ),
          ],
        ),
        /*
        child:Center(
          child:
//          new Image(image: new AssetImage('resource/images/welcome.png'),
//            fit: BoxFit.fill,
//            height: 100 ,
//            width: 100,
//          ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Text('LV 12 > LV 13',textAlign:TextAlign.left,style: TextStyle(fontSize: 32.0, color: Colors.white,
                decoration: TextDecoration.none,backgroundColor: Colors.blue),),
            Text('升级所需资料',style: TextStyle(fontSize: 32.0, color: Colors.white,
              decoration: TextDecoration.none,backgroundColor: Colors.red),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image(image: new AssetImage('resource/images/wood.png'),
                height:30),
                Text('2910',style: TextStyle(fontSize: 30.0, color: Colors.white,
                  decoration: TextDecoration.none,),),
                new Image(image: new AssetImage('resource/images/stone.png'),
                height:30),
                Text('2910',style: TextStyle(fontSize: 30.0, color: Colors.white,
                  decoration: TextDecoration.none,)),
              ],
            ),
            Text('升级后产出:291T币一小时',style:TextStyle(fontSize: 23.0, color: Colors.white,
              decoration: TextDecoration.none,),),
            RaisedButton(onPressed: (){},
              child: Text('升级'),
            ),
          ],
        ),
        ),
        */
      ),
    );
  }
}