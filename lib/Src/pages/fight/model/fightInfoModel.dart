class FightInfoModel {
  int supplies;
  bool hasbuy;
  int woodproportion;
  int stoneproportion;
  String suppliesprice;
  int limitsuppliesrecycle;
  String protectlineup;

  FightInfoModel(
      {this.supplies,
        this.hasbuy,
        this.woodproportion,
        this.stoneproportion,
        this.suppliesprice,
        this.limitsuppliesrecycle,
        this.protectlineup});

  FightInfoModel.fromJson(Map<String, dynamic> json) {
    supplies = json['supplies'];
    hasbuy = json['hasbuy'];
    woodproportion = json['woodproportion'];
    stoneproportion = json['stoneproportion'];
    suppliesprice = json['suppliesprice'];
    limitsuppliesrecycle = json['limitsuppliesrecycle'];
    protectlineup = json['protectlineup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplies'] = this.supplies;
    data['hasbuy'] = this.hasbuy;
    data['woodproportion'] = this.woodproportion;
    data['stoneproportion'] = this.stoneproportion;
    data['suppliesprice'] = this.suppliesprice;
    data['limitsuppliesrecycle'] = this.limitsuppliesrecycle;
    data['protectlineup'] = this.protectlineup;
    return data;
  }
}