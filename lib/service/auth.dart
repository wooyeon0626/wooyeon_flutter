import 'dart:convert';

import 'package:wooyeon_flutter/service/login_service.dart';

import '../models/token_storage.dart';

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

class Auth {
  final LoginService _apiClient = LoginService();
  final TokenStorage _tokenStorage = TokenStorage();

  Future<void> register(String username, String password) async {
    var response = await _apiClient.register(username, password);
    await _tokenStorage.saveToken('dummy_token');
  }

  Future<void> login(String username, String password) async {
    var response = await _apiClient.login(username, password);
    await _tokenStorage.saveToken('dummy_token');
  }

  Future<bool> isUserLoggedIn() async {
    String? token = await _tokenStorage.getToken();
    if (token != null && !(await _tokenStorage.isTokenExpired())) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
  }
}