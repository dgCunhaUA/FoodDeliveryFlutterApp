import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/User.dart';

class UserRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String endpoint = '$urlAPI/client/login';

  Future<String?> getToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return value;
    }
    return null;
  }

  Future<User?> getUser() async {
    String? data = await storage.read(key: 'user');
    if (data != null) {
      return User.fromJson(jsonDecode(data));
    }
    throw Exception();
  }

  Future<void> _persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> _persistUser(User user) async {
    await storage.write(key: 'user', value: jsonEncode(user));
  }

  Future<void> _deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<User> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        User user = User.fromJson(response.data);

        await _persistToken(user.token);

        await _persistUser(user);

        return user;
      } else {
        throw Exception("Login Error");
      }
    } on DioError {
      throw Exception("Erro ao fazer login");
    }
  }

  Future<void> signOut() async {
    await _deleteToken();
    await Future.delayed(const Duration(seconds: 2));
  }
}
