import 'dart:async';
import 'package:dio/dio.dart';

import '../../../models/token_storage.dart';
import 'login_service.dart';

// class Auth {
//   final LoginService _apiClient = LoginService();
//   final TokenStorage _tokenStorage = TokenStorage();
//
//   Future<void> register(String username, String password) async {
//     var response = await _apiClient.register(username, password);
//     var responseBody = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       String token = responseBody['token'];
//       await _tokenStorage.saveToken(token);
//     } else {
//       throw Exception(responseBody['message']);
//     }
//   }
//
//   Future<void> login(String username, String password) async {
//     var response = await _apiClient.login(username, password);
//     var responseBody = jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       String token = responseBody['token'];
//       await _tokenStorage.saveToken(token);
//     } else {
//       throw Exception(responseBody['message']);
//     }
//   }
//
//   Future<bool> isUserLoggedIn() async {
//     String? token = await _tokenStorage.getToken();
//     if (token != null && !(await _tokenStorage.isTokenExpired())) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   Future<void> logout() async {
//     await _tokenStorage.deleteToken();
//   }
// }

class Auth{
  final LoginService _apiClient = LoginService();
  final TokenStorage _tokenStorage = TokenStorage();

  /// 자동 로그인 구현 필요
  Future<bool> autoLogin() async {
    String? tkn = await _tokenStorage.getToken();
    if(tkn != null && !(await _tokenStorage.isTokenExpired())) {
      // await _tokenStorage.saveToken('dummy_token');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    Response? response = await _apiClient.login(email, password);
    if(response != null) {
      if(response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 204) {
        await _tokenStorage.saveToken(token: response.data['accessToken']);
        await _tokenStorage.saveToken(token: response.data['refreshToken'], refresh: true);
        return true;
      }
    }
    return false;
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
    await _tokenStorage.deleteToken(refresh: true);
  }
}