import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application{
  static Router router;

  static showDetailDialog(BuildContext context, String path ,{Map<String, dynamic> params}){
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key].toString());
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');
    path = path + query;
    router.navigateTo(context,path,transitionDuration:const Duration(milliseconds:500),transition: TransitionType.native);
  }
}