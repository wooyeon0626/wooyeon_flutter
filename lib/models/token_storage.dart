import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Future<bool> isTokenExpired() async {
  //   String? token = await getToken();
  //   if (token == null) {
  //     return true;
  //   }
  //   Map<String, dynamic> payload = Jwt.parseJwt(token);
  //   DateTime expiryDate = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
  //   return DateTime.now().isAfter(expiryDate);
  // }

  Future<bool> isTokenExpired() async {
    return false;
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }
}
