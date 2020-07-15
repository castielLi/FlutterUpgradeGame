class User {
  // 头像
  String avatarUrl;

  // 名称
  String name;

  // id
  String id;

  // phone
  String phone;

  String password;

  User({this.avatarUrl, this.name, this.id, this.phone, this.password});

  User.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    name = json['name'];
    id = json['id'];
  }

  User.fromSearchJson(Map<String, dynamic> json) {
    name = json['displayname'];
    id = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarUrl'] = this.avatarUrl;
    data['name'] = this.name;
    data['id'] = this.id;
    data['phone'] = this.phone;
    return data;
  }
}
