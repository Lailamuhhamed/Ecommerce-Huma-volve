class UserModel {
  UserModel({
      this.id, 
      this.email, 
      this.password, 
      this.name, 
      this.role, 
      this.avatar,});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    role = json['role'];
    avatar = json['avatar'];
  }
  int? id;
  String? email;
  String? password;
  String? name;
  String? role;
  String? avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['role'] = role;
    map['avatar'] = avatar;
    return map;
  }

}