class AttackModel {
  bool win;
  int woodamount;
  int stoneamount;
  int supplies;
  String lineup;
  bool displayad;
  int winwood;
  int winstone;
  int winsupplies;

  AttackModel(
      {this.win,
        this.woodamount,
        this.stoneamount,
        this.supplies,
        this.lineup,
      this.displayad,this.winstone,this.winsupplies,this.winwood});

  AttackModel.fromJson(Map<String, dynamic> json) {
    win = json['win'];
    woodamount = json['woodamount'];
    stoneamount = json['stoneamount'];
    supplies = json['supplies'];
    lineup = json['lineup'];
    displayad = json['displayad'];
    winwood = json['winwood'];
    winstone = json['winstone'];
    winsupplies = json['winsupplies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['win'] = this.win;
    data['woodamount'] = this.woodamount;
    data['stoneamount'] = this.stoneamount;
    data['supplies'] = this.supplies;
    data['lineup'] = this.lineup;
    data['displayad'] = this.displayad;
    data['winsupplies'] = this.winsupplies;
    data['winstone'] = this.winstone;
    data['winwood'] = this.winwood;
    return data;
  }
}