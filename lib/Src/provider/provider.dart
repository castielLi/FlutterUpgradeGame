import 'package:provide/provide.dart';
import 'package:upgradegame/Src/provider/baseAdTimerProvider.dart';

import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class AppProvider{
  static Providers initAppProvider(){

    var providers = Providers();
    var baseUserInfoProvider = BaseUserInfoProvider();
    var baseAdTimerInfoProvider = BaseAdTimerProvider();
    providers
    ..provide(Provider<BaseUserInfoProvider>.value(baseUserInfoProvider))
    ..provide(Provider<BaseAdTimerProvider>.value(baseAdTimerInfoProvider));

    return providers;
  }
}