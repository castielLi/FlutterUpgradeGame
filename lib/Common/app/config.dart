import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

///系统配置
class Config {
  static const INT_MAX = 10000;
  static const PAGE_SIZE = 10;
  static const DEBUG = true;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static const TOKEN_KEY = "token";
  static const USER_INFO = "user-info";
  static const USER_NAME_KEY = "user-name";
  static const PW_KEY = "user-pw";
  static const USER_BASIC_CODE = "user-basic-code"; //加密使用
}

///系统常用颜色
class SystemColor {
//  static const Color primaryBlue=Color(0xFF3CB0F6);

  static const Color primaryDartBlue = Color(0xFF1F6AE7); //深蓝色
  static const Color primaryBlue = Color(0xFF3CB0F6); //蓝色
  static const Color primaryDisableBlue = Color(0xFFB1DFFB); //无效蓝色
  static const Color primaryLightBlue = Color(0xFF3CB0F6); //淡蓝色
  static const Color primaryBlack = Color(0xFF2B2E33); //黑色字体
  static const Color primaryGray = Color(0xFF8593AC); // 灰色字体
  static const Color primaryHintGray = Color(0xFFB4BDCC); // 灰色hint字体

// static const Color primary = Color(0xffED8311); // 红色字体
  static const Color primaryRed = Color(0xFFE61029); // 红色字体
  static const Color primaryLightGray = Color(0xFFF5F7FA); // 背景淡灰色
  static const Color primaryWhite = Colors.white; // 背景白色
  static const Color primaryBorderGray = Color(0xFFEBEBEB); // 灰色字体
  static const Color primaryPriceRed = Color(0xFFE61029); // 价格红色
  static const Color primaryUnClick = Color(0xFFB3C2D1); // 灰色减少按钮
  static const Color primaryAddClick = Color(0xFF1ECCAD); // 绿色增加按钮
  static const Color primaryYellowText = Color(0xFFFFEB40); // 黄色字体
  static const Color primaryOrangeText = Color(0xFFFF945F); // 橘黄色按钮
  static const Color primaryTextBg = Color(0xFFf5f7fa); //淡色字体背景
  static const Color primaryGradientBlue = Color(0xFF56ccf2); //渐变浅蓝色
  static const Color primaryGradientDartBlue = Color(0xFF3184ed); //渐变深蓝色
  static const Color primaryGradientOrange = Color(0xFFf89560); //渐变橘色
  static const Color primaryGradientDartOrange = Color(0xFFf44264); //渐变深橘色
  static const Color primaryStartYellow = Color(0xFFffc54a); //渐变深橘色

}

class SystemIconSize {
  static const smallIconSize = 80.0;
  static const mediumIconSize = 250.0;

  static const mainPageResourceBarIconSize = 125.0;
  static const mainPageFunctionBarIconSize = 150.0;
  static const mainPageStatusBarSmallIconSize = 90.0;
  static const mainPageIconSize = 350.0;

  static const adIconSize = 135.0;
  static const armyCampIconSize = 175.0;
  static const trainArmyIconSize = 225.0;
}

class SystemScreenSize {
  static var mainPageSignalBarHeight = ScreenUtil.pixelRatio * ScreenUtil.statusBarHeight;

  static const detailDialogHeight = 1660;
  static const detailDialogWidth = 1020;
  static const detailDialogLeft = 100;
  static const detailDialogTop = 400;
  static const detailDialogBottom = 100;

  static const displayItemHeight = 320.0; //团队贡献，分红，英雄祭坛
  static const displayContentHeight = 850.0; //内容展示高度，不包括按钮
  static const inputDecorationHeight = 150.0;
}

class SystemButtonSize {
  static const smallButtonWidth = 240.0;
  static const smallButtonHeight = 120.0;
  static const smallButtonFontSize = 60.0;

  static const exchangeContributionButtonFontSize = 38.0;

  static const mediumButtonWidth = 300.0;
  static const mediumButtonHeight = 120.0;

  static const largeButtonWidth = 360.0;
  static const largeButtonHeight = 144.0;
  static const largeButtonIconSize = 120.0;
  static const largeButtonFontSize = 72.0;

  static const settingButtonHeight = 200;
}

///系统字体大小
class SystemFontSize {
  static const buttonTextFontSize = 70.0;
  static const mainBuildingTextFontSize = 75.0;
  static const buildingConditionTextFontSize = 28.0;
  static const otherBuildingTextFontSize = 50.0;
  static const resourceTextFontSize = 13.0;
  static const levelTextFontSize = 15.0;
  static const operationTextFontSize = 31.0;
  static const dividendTitleTextFontSize = 15.0;
  static const dividendContentTextFontSize = 12.0;

  static const userInfoResourceTextFontSize = 30.0;
  static const userInfoResourceWithdrawTextFontSize = 40.0;
  static const storeCashGoldTextFontSize = 55.0;

  static const detailDialogTitleTextFontSize = 75.0;

  static const settingTextFontSize = 55.0;

  static const veryLagerTextSize = 80.0;
  static const moreMoreLargerTextSize = 45.0;
  static const moreLargerTextSize = 35.0;
  static const lagerTextSize = 32.0;

  static const bigTextSize = 30.0;
  static const normalTextSize = 28.0;
  static const smallTextSize = 26.0;
  static const minTextSize = 24.0;
  static const minMinTextSize = 15.0;
}

/// 自定义字体格式
class CustomFontSize {
  static TextStyle defaultTextStyle(double fontSize) {
    return TextStyle(fontSize: ScreenUtil().setSp(fontSize), color: Colors.white, decoration: TextDecoration.none);
  }
}
