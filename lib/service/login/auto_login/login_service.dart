import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../config/config.dart';

class LoginService {
  Dio dio = Dio();

  Future<Response?> login(String email, String password) async {
    const url = '${Config.domain}/auth/login';

    try {
      final response = await dio.post(
        url,
        data: {
          'email': email,
          'password': password,
        },
      );

      return response;
    } catch (e) {
      // Dio 에러 처리
      log('Dio 에러 발생: $e');
      return null;
    }
  }

  Future<http.Response> logout(String phone, String code) {
    const url = '${Config.domain}/auth/logout';

    return Future.value(http.Response('{"token": "dummy_token"}', 200));
  }

  void reissue() {
    const url = '${Config.domain}/auth/reissue-token';

    return;
  }
}
