import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:upgradegame/Common/app/config.dart';
import 'package:upgradegame/Src/common/model/user.dart';

class UserSearchResult extends StatefulWidget {
  List<User> searchResult = [];

  UserSearchResult({Key key, this.searchResult}) : super(key: key);

  @override
  _UserSearchResult createState() => _UserSearchResult();
}

class _UserSearchResult extends State<UserSearchResult> {
  @override
  Widget build(BuildContext context) {
    return this.widget.searchResult.length == 0
        ? Text(
            '没有搜索到用户',
            textAlign: TextAlign.center,
            style: CustomFontSize.defaultTextStyle(
                SystemFontSize.moreMoreLargerTextSize),
          )
        : ListView.builder(
            itemCount: this.widget.searchResult.length,
            itemExtent: ScreenUtil().setSp(150),
            itemBuilder: (BuildContext context, int index) {
              User user = this.widget.searchResult[index];
              return GestureDetector(
                onTap: () {
                  print('Send coin to ' + user.name);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 3),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage(
                          'resource/images/userSearchItemBackground.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '用户:',
                                style: CustomFontSize.defaultTextStyle(
                                    SystemFontSize.moreLargerTextSize),
                              ),
                              Image(
                                image: new AssetImage(user.avatarUrl),
                                height: ScreenUtil().setHeight(90),
                              ),
                              Text(
                                user.name,
                                style: CustomFontSize.defaultTextStyle(
                                    SystemFontSize.moreLargerTextSize),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'ID:' + user.id,
                            style: CustomFontSize.defaultTextStyle(
                                SystemFontSize.moreLargerTextSize),
                          ),
                        ),
                      ],
                    ),
//                  ),
                ),
              );
            });
  }
}
