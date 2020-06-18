class User {
  //头像
  String avatarUrl;
  // 名称
  String name;
  // id
  String id;

  User({this.avatarUrl, this.name, this.id});

  User.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatarUrl'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarUrl'] = this.avatarUrl;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}