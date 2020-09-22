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
    wood = json['woodproportion'];
    if(wood == null){
      wood = 0;
    }
    stone = json['stoneproportion'];
    if(stone == null){
      stone = 0;
    }
    suppliesprice = json['suppliesprice'];
    limitsuppliesrecycle = json['limitsuppliesrecycle'];
    protectlineup = json['protectlineup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplies'] = this.supplies;
    data['hasbuy'] = this.hasbuy;
    data['woodproportion'] = this.wood;
    data['stoneproportion'] = this.stone;
    data['suppliesprice'] = this.suppliesprice;
    data['limitsuppliesrecycle'] = this.limitsuppliesrecycle;
    data['protectlineup'] = this.protectlineup;
    return data;
  }
}