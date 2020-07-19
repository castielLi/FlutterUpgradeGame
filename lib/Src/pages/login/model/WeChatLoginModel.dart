class WeChatLoginModel {
  String accessToken;
  int expiresIn;
  String refreshToken;
  String openid;
  String scope;
  String unionid;

  WeChatLoginModel(
      {this.accessToken,
        this.expiresIn,
        this.refreshToken,
        this.openid,
        this.scope,
        this.unionid});

  WeChatLoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    openid = json['openid'];
    scope = json['scope'];
    unionid = json['unionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    data['openid'] = this.openid;
    data['scope'] = this.scope;
    data['unionid'] = this.unionid;
    return data;
  }
}