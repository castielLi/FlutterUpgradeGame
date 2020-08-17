class UserSearch {
  // 名称
  String displayname;

  // id
  String userid;

  // phone
  String phone;

  UserSearch({
    this.displayname,
    this.userid,
    this.phone,
  });

  UserSearch.fromJson(Map<String, dynamic> json) {
    displayname = json['displayname'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayname'] = this.displayname;
    data['userid'] = this.userid;
    data['phone'] = this.phone;
    return data;
  }
}
