import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application{
  static Router router;
  static Future navigationWithParams(BuildContext context, String path ,{Map<String, dynamic> params}){
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
    return router.navigateTo(context,path);
  }

  static Future showResourceDialog(BuildContext context, String path ,{Map<String, dynamic> params}){
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
    return router.navigateTo(context,path,transitionDuration:const Duration(milliseconds:300),transition: TransitionType.materialFullScreenDialog);
  }

  static Future showDetailDialog(BuildContext context, String path ,{Map<String, dynamic> params}){
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
    return router.navigateTo(context,path,transitionDuration:const Duration(milliseconds:500),transition: TransitionType.materialFullScreenDialog);
  }
}
class PopWindow extends PopupRoute{
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  final WidgetBuilder pageBuilder;


  PopWindow({@required this.pageBuilder, this.child});
  @override
  // TODO: implement barrierColor
  Color get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;


  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) => pageBuilder(context);



  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: pageBuilder(context),
    );
  }


  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => _duration;
  
}