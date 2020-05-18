import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Application{
  static Router router;

  static showDetailDialog(BuildContext context, String path){
    router.navigateTo(context,path,transitionDuration:const Duration(milliseconds:500),transition: TransitionType.material);
  }
}