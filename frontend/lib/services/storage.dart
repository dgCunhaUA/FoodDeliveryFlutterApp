import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final _secureStorage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    String? token = await _secureStorage.read(key: "jwt");
    return token;
  }

  setToken(token) async {
    _secureStorage.write(key: 'jwt', value: token);
  }

  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }
}
