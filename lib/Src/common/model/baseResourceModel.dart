class BaseResourceModel {
  int tcoinamount;
  int stoneamount;
  int woodamount;
  int mainbuildlevel;
  int farmlevel;
  int stonelevel;
  int woodlevel;
  int tobecollectedcoin;

  BaseResourceModel(
      {this.tcoinamount,
        this.stoneamount,
        this.woodamount,
        this.mainbuildlevel,
        this.farmlevel,
        this.stonelevel,
        this.woodlevel,this.tobecollectedcoin});

  BaseResourceModel.fromJson(Map<String, dynamic> json) {
    tcoinamount = json['tcoinamount'];
    stoneamount = json['stoneamount'];
    woodamount = json['woodamount'];
    mainbuildlevel = json['mainbuildlevel'];
    tobecollectedcoin = json['tobecollectedcoin'];
    farmlevel = json['farmlevel'];
    stonelevel = json['stonelevel'];
    woodlevel = json['woodlevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tcoinamount'] = this.tcoinamount;
    data['stoneamount'] = this.stoneamount;
    data['woodamount'] = this.woodamount;
    data['mainbuildlevel'] = this.mainbuildlevel;
    data['farmlevel'] = this.farmlevel;
    data['stonelevel'] = this.stonelevel;
    data['woodlevel'] = this.woodlevel;
    data['tobecollectedcoin'] = this.tobecollectedcoin;
    return data;
  }
}