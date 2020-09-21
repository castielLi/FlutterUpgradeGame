class ServiceUrl {
  static const String host =
  ///fastmock
//      "https://www.fastmock.site/mock/095e3520b3833640934d29559631cc16/";
  ///server
//  "https://test.buluo888.com/";
    "https://gufeng.buluo888.com/";
//  "http://192.168.31.46:8080/";
  static const String downloadUrl = '';

  /// rule
  static getRule() {
    return "${host}api/v2/rule";
  }

  static getRule2() {
    return "${host}api/v2/rule2";
  }

  /// login
  static login() {
    return "${host}api/v2/login";
  }

  ///getuser
  static getuser() {
    return "${host}api/v2/user";
  }

  ///bindDeviceId
  static bindDeviceId() {
    return "${host}api/v2/binddeviceid";
  }


  ///requestBackendFetchCoin
  static requestBackendProductCoin(){
    return "${host}api/v2/mainbuild/tcoin/product";
  }

  ///loginwithaccount
  static loginwithaccount(){
    return "${host}api/v2/accountlogin";
  }

  ///登出
  static logout(){
    return "${host}api/v2/logout";
  }

  ///setUserInfo
  static setuserinfo() {
    return "${host}api/v2/userinfo";
  }

  ///观看广告
  static watchAd(){
    return "${host}api/v2/ad/watch";
  }

  static getUserInfo(){
    return "${host}api/v2/user";
  }

  ///storeList
  static getStoreList() {
    return "${host}api/v2/voucher/list";
  }

  ///获取购买物资列表
  static getSuppliesStoreList(){
    return "${host}api/v2/fight/getsupplieslist";
  }

  ///回收物资
  static recycleSupplies(){
    return "${host}api/v2/fight/exchangesupplies";
  }


  ///设置防守阵容
  static setProtectLine(){
    return "${host}api/v2/fight/setprotectlineup";
  }

  ///匹配进攻
  static attack(){
    return "${host}api/v2/fight/attack";
  }


  ///获取战场排行榜
  static getFightRankList(){
    return "${host}api/v2/fight/getfightranklist";
  }

  ///获取被攻打的消息
  static getFightMessageList(){
    return "${host}api/v2/fight/getprotectfaillist";
  }

  ///购买英雄
  static buyHero() {
    return "${host}api/v2/hero/buy";
  }

  ///获取战斗界面基础信息
  static getFightInfo(){
    return "${host}api/v2/fight/info";
  }

  ///获取英雄列表
  static getHeroList() {
    return "${host}api/v2/hero/list";
  }

  ///购买赠送券
  static buyVocher() {
    return "${host}api/v2/voucher/buy";
  }

  ///购买物资
  static buySupplies(){
    return "${host}api/v2/fight/buysupplies";
  }

  ///微信确认订单情况
  static confirmOrder(){
    return "${host}api/v2/voucher/confirmorder";
  }

  /// 广告分红
  static getAdDividendList() {
    return "${host}api/v2/profitsharing";
  }

  /// 排行榜
  static getRankList() {
    return "${host}api/v2/rank";
  }

  /// 团队
  static getTeamList() {
    return "${host}api/v2/team";
  }

  /// 公告
  static getAnnouncementList() {
    return "${host}api/v2/announcement";
  }

  /// 活动
  static getActivityList() {
    return "${host}api/v2/activity";
  }


  /// 攻略
  static getRaidersList(){
    return "${host}api/v2/strategy";
  }

  /// 获取t币
  static takeCoin() {
    return "${host}api/v2/mainbuild/tcoin/fetch";
  }
  /// 获取协议
  static getProtocol(){
    return "${host}api/v2/useragreement";
  }
  /// 关于我们
  static getAboutUs(){
    return "${host}api/v2/aboutus";
  }
  /// 隐私条款
  static getPrivacyPolicy(){
    return "${host}api/v2/privacy";
  }

  /// 升级建筑
  static upgradeBuilding(){
    return "${host}api/v2/upgradebuilding";
  }
  ///  搜索用户
  static searchUser(){
    return "${host}api/v2/searchuser";
  }
  ///  发布订单
  static sellResource(){
    return "${host}api/v2/market/sell";
  }

  ///提现
  static withdraw(){
    return "${host}api/v2/account/withdraw";
  }

  ///  赠送T币
  static sendCoin(){
    return "${host}api/v2/account/sendtcoin";
  }

  ///获取用户现金账户
  static getUserCashInfo(){
    return "${host}api/v2/account/cashinfo";
  }
  ///更改密码
  static changePassword(){
    return "${host}api/v2/account/password";
  }

  ///获取我的市场发布订单
  static getMyMarketTrade(){
    return "${host}api/v2/market/mytrade";
  }

  ///取消我发布的市场订单
  static cancelMyMarketTrade(){
    return "${host}api/v2/market/cancel";
  }

  ///市场发布订单
  static publishMyMarkedTrade(){
    return "${host}api/v2/market/sell";
  }

  ///获取市场订单
  static getTradeList(){
    return "${host}api/v2/market/list";
  }

  ///获取用户二维码
  static getQRCode(){
    return "${host}api/v2/account/qrcode";
  }

  ///购买市场商品
  static marketBuy(){
    return "${host}api/v2/market/buy";
  }

  ///获取t币明细
  static getTCoinDetail(){
    return "${host}api/v2/bill/tcoin";
  }

  ///获取提现明细
  static getWithdrawDetail(){
    return "${host}api/v2/bill/cash";
  }

  ///获取客服中心
  static serverCenter(){
    return "${host}api/v2/servercenter";
  }

  ///获取团队贡献值
  static getTeamContribution(){
    return "${host}api/v2/team/contribution";
  }

  ///获取我的贡献值
  static getMyContribution(){
    return "${host}api/v2/contribution";
  }

  ///t币购买贡献值
  static buyContribution(){
    return "${host}api/v2/contribution/buy";
  }

  ///贡献值兑换t币列表
  static exchangeContributionList(){
    return "${host}api/v2/contribution/exchange/list";
  }

  ///贡献值兑换t币兑换
  static exchangeContribution(){
    return "${host}api/v2/contribution/exchange";
  }
}

