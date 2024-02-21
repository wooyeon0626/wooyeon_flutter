import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken({required String token, bool refresh = false}) async {
    if(!refresh){
      await _storage.write(key: 'access_token', value: token);
    } else {
      await _storage.write(key: 'refresh_token', value: token);
    }
  }

  Future<String?> getToken({bool refresh = false}) async {
    if(!refresh) {
      return await _storage.read(key: 'access_token');
    } else {
      return await _storage.read(key: 'refresh_token');
    }
  }

  Future<void> deleteToken({bool refresh = false}) async {
    if(!refresh) {
      await _storage.delete(key: 'access_token');
    } else {
      await _storage.delete(key: 'refresh_token');
    }
  }
}
