class UserSearch {
  // 名称
  String displayname;

  // id
  String userid;

  // phone
  String phone;

  String registertime;

  UserSearch({
    this.displayname,
    this.userid,
    this.phone,
    this.registertime,
  });

  UserSearch.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    userid = json['userid'];
    if(json['registertime']!=null) {
      registertime = json['registertime'];
    }else{
      registertime = "2020/07/20";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayname'] = this.displayname;
    data['userid'] = this.userid;
    data['phone'] = this.phone;
    data['registertime'] = this.registertime;
    return data;
  }
}
