import 'package:provide/provide.dart';
import 'package:upgradegame/Src/provider/baseAdTimerProvider.dart';
import 'package:upgradegame/Src/provider/baseFightLineupProvider.dart';
import 'package:upgradegame/Src/provider/baseUserCashProvider.dart';
import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';
import 'package:upgradegame/Src/provider/heroProvider.dart';

class AppProvider{
  static Providers initAppProvider(){

    var providers = Providers();
    var baseUserInfoProvider = BaseUserInfoProvider();
    var baseAdTimerInfoProvider = BaseAdTimerProvider();
    var baseUserCashProvider = BaseUserCashProvider();
    var baseFightLineupProvider = BaseFightLineupProvider();
    var heroProvider = HeroProvider();
    providers
    ..provide(Provider<BaseUserInfoProvider>.value(baseUserInfoProvider))
      ..provide(Provider<BaseUserCashProvider>.value(baseUserCashProvider))
      ..provide(Provider<BaseFightLineupProvider>.value(baseFightLineupProvider))
      ..provide(Provider<HeroProvider>.value(heroProvider))
    ..provide(Provider<BaseAdTimerProvider>.value(baseAdTimerInfoProvider));

    return providers;
  }
}