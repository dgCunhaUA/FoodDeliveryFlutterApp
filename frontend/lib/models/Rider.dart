class Rider {
  late final int id;
  late final String name;
  late final String address;
  late final String email;
  late final String password;
  late final String vehicle;
  late final String updatedAt;
  late final String createdAt;
  late final String token;
  late final String? photo;

  Rider(
      {required this.id,
      required this.name,
      required this.address,
      required this.email,
      required this.password,
      required this.vehicle,
      required this.token,
      this.photo,
      required this.createdAt,
      required this.updatedAt});

  Rider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    vehicle = json['vehicle'];
    token = json['token'];
    photo = json['photo'];
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
    data['vehicle'] = vehicle;
    data['token'] = token;
    if (photo != null) {
      data['photo'] = photo;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
