import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/Rider.dart';
import '../models/Client.dart';

class UserRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return value;
    }
    return null;
  }

  Future<Client?> getClient() async {
    String? data = await storage.read(key: 'client');
    if (data != null) {
      return Client.fromJson(jsonDecode(data));
    }
    throw Exception();
  }

  Future<Rider?> getRider() async {
    String? data = await storage.read(key: 'rider');
    if (data != null) {
      return Rider.fromJson(jsonDecode(data));
    }
    throw Exception();
  }

  Future<void> _persistClient(Client client) async {
    await storage.write(key: 'client', value: jsonEncode(client));
  }

  Future<void> _persistRider(Rider rider) async {
    await storage.write(key: 'rider', value: jsonEncode(rider));
  }

  Future<void> _deleteStorage() async {
    //storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<Client> login(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/client/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        Client client = Client.fromJson(response.data);

        await _persistClient(client);

        return client;
      }
      throw Exception("Login Error");
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        throw Exception("Password Incorreta");
      }

      throw Exception("Erro ao fazer login");
    }
  }

  Future<Client> signUp(
      {required String email,
      required String password,
      required String username,
      required String address}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/client/register',
        data: {
          'name': username,
          'email': email,
          'password': password,
          'address': address,
        },
      );

      if (response.statusCode == 201) {
        Client user = Client.fromJson(response.data);

        await _persistClient(user);

        return user;
      }
      throw Exception("Erro");
    } on DioError catch (e) {
      if (e.response!.statusCode == 409) {
        throw Exception("Email já utilizado");
      }

      throw Exception("Erro no registo");
    }
  }

  Future<Rider> signUpRider(
      {required String email,
      required String password,
      required String username,
      required String address,
      required String vehicle}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/rider/register',
        data: {
          'name': username,
          'email': email,
          'password': password,
          'address': address,
          'vehicle': vehicle,
        },
      );

      if (response.statusCode == 201) {
        Rider rider = Rider.fromJson(response.data);

        await _persistRider(rider);

        return rider;
      }
      throw Exception("Erro");
    } on DioError catch (e) {
      if (e.response!.statusCode == 409) {
        throw Exception("Email já utilizado");
      }

      throw Exception("Erro no registo");
    }
  }

  Future<Rider> loginRider(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
        '$urlAPI/rider/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        Rider rider = Rider.fromJson(response.data);

        await _persistRider(rider);

        return rider;
      }
      throw Exception("Login Error");
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        throw Exception("Password Incorreta");
      }

      throw Exception("Erro ao fazer login");
    }
  }

  Future<void> signOut() async {
    await _deleteStorage();
  }

  Future<File> uploadClientPhoto(File photo) async {
    try {
      Client? client = await getClient();

      String fileName = photo.path.split('/').last;

      FormData formData = FormData.fromMap({
        "id": client!.id,
        "photo": await MultipartFile.fromFile(photo.path, filename: fileName),
        "filename": fileName
      });

      Response response =
          await _dio.post('$urlAPI/client/upload', data: formData);

      if (response.statusCode == 200) {
        Client updatedClient = Client.fromJson(response.data);
        await _persistClient(updatedClient);

        return photo;
      } else {
        throw Exception(response.statusMessage);
      }

      //return response.data['id'];
    } on DioError catch (e) {
      print(e);
      throw Exception("Erro ao fazer upload");
    }
  }

  Future<File> uploadRiderPhoto(File photo) async {
    try {
      Rider? rider = await getRider();

      String fileName = photo.path.split('/').last;

      FormData formData = FormData.fromMap({
        "id": rider!.id,
        "photo": await MultipartFile.fromFile(photo.path, filename: fileName),
        "filename": fileName
      });

      Response response =
          await _dio.post('$urlAPI/rider/upload', data: formData);

      print(response.data);

      if (response.statusCode == 200) {
        Rider updatedRider = Rider.fromJson(response.data);
        await _persistRider(updatedRider);

        return photo;
      } else {
        throw Exception(response.statusMessage);
      }

      //return response.data['id'];
    } on DioError catch (e) {
      print(e);
      throw Exception("Erro ao fazer upload");
    }
  }
}
