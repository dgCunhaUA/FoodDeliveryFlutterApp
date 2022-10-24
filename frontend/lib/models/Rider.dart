// ignore: file_names
class Rider {
  Rider({
    required this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.password,
    required this.updatedAt,
    required this.createdAt,
    required this.token,
  });
  late final int id;
  late final String name;
  late final String address;
  late final String email;
  late final String password;
  late final String updatedAt;
  late final String createdAt;
  late final String token;

  Rider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['password'] = password;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['token'] = token;
    return data;
  }
}
