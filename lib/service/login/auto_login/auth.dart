import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../config/config.dart';
import '../../../models/token_storage.dart';
import 'login_service.dart';

enum LoginState { success, profile, fail }

class Auth {
  final LoginService _apiClient = LoginService();
  final TokenStorage _tokenStorage = Get.find();

  /// 자동 로그인 구현 필요
  Future<LoginState> autoLogin() async {
    String? tkn = await _tokenStorage.getToken();
    if (tkn != null) {
      const url = '${Config.domain}/users/profile-state';

      try {
        Dio dio = Dio();
        dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
        dio.options.headers['Authorization'] = 'Bearer $tkn';

        log(tkn);

        final response = await dio.get(url);

        log("[Auto Login] ${response.statusCode}");

        if (response.statusCode == 200) {
          log("[existsProfile] ${response.data['existsProfile']}");
          if (response.data['existsProfile'] == 3000) {
            return LoginState.profile;
          } else if (response.data['existsProfile'] == 4004) {
            return LoginState.fail;
          } else {
            return LoginState.success;
          }
        } else {
          return LoginState.fail;
        }
      } catch (e) {
        // Dio 에러 처리
        log('[AutoLogin Error] : $e');
        return LoginState.fail;
      }
    } else {
      return LoginState.fail;
    }
  }

  Future<LoginState> login(String email, String password) async {
    Response? response = await _apiClient.login(email, password);
    if (response != null) {
      if (response.statusCode! >= 200 && response.statusCode! <= 206) {
        /// 나중에 수정하기
        if (response.data['statusCode'] == 3000) {
          await _tokenStorage.saveToken(token: response.data['accessToken']);
          await _tokenStorage.saveToken(
              token: response.data['refreshToken'], refresh: true);
          log("[LOGIN STATE] profile : ${response.statusCode}");
          return LoginState.profile;
        } else {
          await _tokenStorage.saveToken(token: response.data['accessToken']);
          await _tokenStorage.saveToken(
              token: response.data['refreshToken'], refresh: true);
          log("[LOGIN STATE] success : ${response.statusCode}");
          return LoginState.success;
        }
      } else if (response.statusCode == 3000) {
        await _tokenStorage.saveToken(token: response.data['accessToken']);
        await _tokenStorage.saveToken(
            token: response.data['refreshToken'], refresh: true);
        log("[LOGIN STATE] profile : ${response.statusCode}");
        return LoginState.profile;
      }
    }
    return LoginState.fail;
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
    await _tokenStorage.deleteToken(refresh: true);
  }
}
