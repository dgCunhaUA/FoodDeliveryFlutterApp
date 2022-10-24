class User {
  late int id;
  late String firstName;
  late String lastName;
  late String birthdate;
  late String address;
  late String email;
  late String password;
  late String token;
  late String createdAt;
  late String updatedAt;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.birthdate,
      required this.address,
      required this.email,
      required this.password,
      required this.token,
      required this.createdAt,
      required this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthdate = json['birthdate'];
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
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['birthdate'] = birthdate;
    data['address'] = address;
    data['email'] = email;
    data['password'] = password;
    data['token'] = token;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
