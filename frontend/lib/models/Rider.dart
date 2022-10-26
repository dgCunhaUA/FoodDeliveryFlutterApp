import 'package:flutter/foundation.dart';

class Rider {
  late int id;
  late String name;
  late String address;
  late String email;
  late String password;
  late String vehicle;
  late String token;
  Uint8List? photo;
  late String createdAt;
  late String updatedAt;

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
    //photo = json['photo'] != null ? Photo.fromJson(json['photo']) : null;\
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
      //data['photo'] = photo!.toJson();
      data['photo'] = photo;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
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
