import 'package:provide/provide.dart';
import 'package:upgradegame/Src/provider/basePageLogicProvider.dart';

import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class AppProvider{
  static Providers initAppProvider(){

    var providers = Providers();
    var baseUserInfoProvider = BaseUserInfoProvider();
    var basePageLogicProvider = BasePageLogicProvider();
    providers
    ..provide(Provider<BaseUserInfoProvider>.value(baseUserInfoProvider))
    ..provide(Provider<BasePageLogicProvider>.value(basePageLogicProvider));

    return providers;
  }
}