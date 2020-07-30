

//混入
class RequestGetCoinModel{

  bool ifNeedGetCoin;

  factory RequestGetCoinModel() =>_getInstance();
  static RequestGetCoinModel get instance => _getInstance();
  static RequestGetCoinModel _instance;
  RequestGetCoinModel._internal() {
    // 初始化
    this.ifNeedGetCoin = false;
  }

  static RequestGetCoinModel _getInstance() {
    if (_instance == null) {
      _instance = new RequestGetCoinModel._internal();
    }
    return _instance;
  }

  static setIfNeedCoin(bool value){
    _instance.ifNeedGetCoin = value;
  }

}
