class Client {
  late final int id;
  late final String name;
  late final String address;
  late final String email;
  late final String password;
  late final String updatedAt;
  late final String createdAt;
  late final String token;
  late final String? photo;

  Client(
      {required this.id,
      required this.name,
      required this.address,
      required this.email,
      required this.password,
      required this.updatedAt,
      required this.createdAt,
      required this.token,
      this.photo});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    photo = json['photo'];
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
    if (photo != null) {
      data['photo'] = photo;
    }
    return data;
  }
}
