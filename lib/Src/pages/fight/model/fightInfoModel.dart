class FightInfoModel {
  int supplies;
  bool hasbuy;
  int wood;
  int stone;
  String suppliesprice;
  int limitsuppliesrecycle;
  String protectlineup;

  FightInfoModel(
      {this.supplies,
        this.hasbuy,
        this.wood,
        this.stone,
        this.suppliesprice,
        this.limitsuppliesrecycle,
        this.protectlineup});

  FightInfoModel.fromJson(Map<String, dynamic> json) {
    supplies = json['supplies'];
    hasbuy = json['hasbuy'];
    wood = json['wood'];
    stone = json['stone'];
    suppliesprice = json['suppliesprice'];
    limitsuppliesrecycle = json['limitsuppliesrecycle'];
    protectlineup = json['protectlineup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplies'] = this.supplies;
    data['hasbuy'] = this.hasbuy;
    data['wood'] = this.wood;
    data['stone'] = this.stone;
    data['suppliesprice'] = this.suppliesprice;
    data['limitsuppliesrecycle'] = this.limitsuppliesrecycle;
    data['protectlineup'] = this.protectlineup;
    return data;
  }
}