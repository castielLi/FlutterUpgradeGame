import 'package:provide/provide.dart';

import 'package:upgradegame/Src/provider/baseUserInfoProvider.dart';

class AppProvider{
  static Providers initAppProvider(){

    var providers = Providers();
    var baseUserInfoProvider = BaseUserInfoProvider();
    providers
    ..provide(Provider<BaseUserInfoProvider>.value(baseUserInfoProvider));

    return providers;
  }
}