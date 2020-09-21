class AttackModel {
  bool win;
  int woodamount;
  int stoneamount;
  int supplies;
  String lineup;
  bool displayad;

  AttackModel(
      {this.win,
        this.woodamount,
        this.stoneamount,
        this.supplies,
        this.lineup,
      this.displayad});

  AttackModel.fromJson(Map<String, dynamic> json) {
    win = json['win'];
    woodamount = json['woodamount'];
    stoneamount = json['stoneamount'];
    supplies = json['supplies'];
    lineup = json['lineup'];
    displayad = json['displayad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['win'] = this.win;
    data['woodamount'] = this.woodamount;
    data['stoneamount'] = this.stoneamount;
    data['supplies'] = this.supplies;
    data['lineup'] = this.lineup;
    data['displayad'] = this.displayad;
    return data;
  }
}