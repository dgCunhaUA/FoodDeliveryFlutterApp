import 'package:flutter/foundation.dart';

class Client {
  late final int id;
  late final String name;
  late final String address;
  late final String email;
  late final String password;
  late final String updatedAt;
  late final String createdAt;
  late final String? token;
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
    //photo = json['photo'] != null ? Photo.fromJson(json['photo']) : null;
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
      //data['photo'] = photo!.toJson();
      data['photo'] = photo;
    }
    return data;
  }
}

class Photo {
  String? type;
  List<int>? data;

  Photo({this.type, this.data});

  Photo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['data'] = this.data;
    return data;
  }
}
