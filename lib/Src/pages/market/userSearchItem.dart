import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Common/widget/imageTextButton/imageTextButton.dart';

class UserSearchItem extends StatefulWidget {
  // 头像
  String avatarUrl;

  // 名称
  String name;

  // 用户id
  String id;

  // 字体大小
  double textSize;

  UserSearchItem(
      {Key key,
        this.avatarUrl,
        this.name,
        this.id,})
      : super(key: key);

  @override
  _UserSearchItem createState() => _UserSearchItem();
}

class _UserSearchItem extends State<UserSearchItem> {
  @override
  Widget build(BuildContext context) {
    if(null == this.widget.textSize || 0 == this.widget.textSize){
      this.widget.textSize = SystemFontSize.moreLargerTextSize;
    }
    return Container(
    margin: EdgeInsets.only(bottom:3),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('resource/images/userSearchItemBackground.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('用户:',style:CustomFontSize.defaultTextStyle(this.widget.textSize),),
          Image(
            image: new AssetImage(this.widget.avatarUrl),
            height: ScreenUtil().setHeight(90),
          ),
          Text(this.widget.name,style:CustomFontSize.defaultTextStyle(this.widget.textSize),),
          Text('ID:'+this.widget.id,style:CustomFontSize.defaultTextStyle(this.widget.textSize),),
        ],
      ),
    );
  }
}
