class InvitationListModel {
  List<InvitationModel> first;
  List<InvitationModel> second;

  InvitationListModel({this.first, this.second});

  InvitationListModel.fromJson(Map<String, dynamic> json) {
    if (json['firstinvitations'] != null) {
      first = new List<InvitationModel>();
      json['firstinvitations'].forEach((v) {
        first.add(new InvitationModel.fromJson(v));
      });
    }
    if (json['secondinvitations'] != null) {
      second = new List<InvitationModel>();
      json['secondinvitations'].forEach((v) {
        second.add(new InvitationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.first != null) {
      data['firstinvitations'] = this.first.map((v) => v.toJson()).toList();
    }
    if (this.second != null) {
      data['secondinvitations'] = this.second.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvitationModel {
  String avatar;
  String displayname;
  String registertime;
  int level;
  String contribution;
  String voucherincome;

  InvitationModel(
      {this.avatar,
      this.displayname,
      this.registertime,
      this.level,
      this.contribution,
      this.voucherincome});

  InvitationModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    displayname = json['displayname'];
    registertime = json['registertime'];
    level = json['level'];
    contribution = json['contribution'];
    voucherincome = json['voucherincome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['displayname'] = this.displayname;
    data['registertime'] = this.registertime;
    data['level'] = this.level;
    data['contribution'] = this.contribution;
    data['voucherincome'] = this.voucherincome;
    return data;
  }
}
