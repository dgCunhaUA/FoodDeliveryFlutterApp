import 'package:dio/dio.dart';
import "../utils/api.dart";
import '../services/storage.dart';

class ApiClient {
  final Dio _dio = Dio();
  final url = urlAPI;
  final Storage storage = Storage();

  Future<dynamic> login(String email, String password) async {
    String endpoint = '$urlAPI/client/login';
    try {
      Response response = await _dio.post(
        endpoint,
        data: {'email': email, 'password': password},
      );

      // Store access token in local storage
      await storage.setToken(response.data["token"]);

      //returns the successful user data json object
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
