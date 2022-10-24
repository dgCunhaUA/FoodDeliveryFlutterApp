class User {
  late int id;
  late String name;
  late String address;
  late String email;
  late String password;
  late String token;
  late String createdAt;
  late String updatedAt;

  User(
      {required this.id,
      required this.name,
      required this.address,
      required this.email,
      required this.password,
      required this.token,
      required this.createdAt,
      required this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['password'] = password;
    data['token'] = token;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
