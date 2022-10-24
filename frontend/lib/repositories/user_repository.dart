import 'package:dio/dio.dart';
import 'package:flutter_project/utils/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final Dio _dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final String url = urlAPI;
  final String endpoint = '$urlAPI/client/login';

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(
      {required String email, required String password}) async {
    try {
      Response response = await _dio.post(
        endpoint,
        data: {'email': email, 'password': password},
      );

      return response.data["token"];
    } on DioError {
      throw Exception("Erro ao fazer login");
    }
  }
}
