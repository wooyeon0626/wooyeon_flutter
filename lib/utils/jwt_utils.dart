import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../models/token_storage.dart';
import '../screens/login/login.dart';

/*
  [INPUT]
  1. get, post, put, delete
  2. header 추가
  3. body 넣어야하고
  4. 만약에 get이면 parameter 설정 해줘야하고

  [PROCESS]
  1. statusCode 4000, 4001 ... => 내부에서 로직 처리

  [OUTPUT]
  1. response
 */

Future<http.Response?> jwtGetRequest(
    {Map<String, String>? header, required Uri url}) async {
  TokenStorage tokenStorage = TokenStorage();

  header ??= <String, String>{};

  header['Content-Type'] = 'application/json; charset=UTF-8';
  header['Authorization'] = 'Bearer ${await tokenStorage.getToken()}';

  try {
    final response = await http.get(url, headers: header);

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      return response;
    } else if (response.statusCode == 4004) {
      // access token 만료
      final reissueUrl = Uri.parse('${Config.domain}/auth/reissue-token');

      final reissueTokenResponse = await http.post(reissueUrl, body: {
        'accessToken': tokenStorage.getToken(),
        'refreshToken': tokenStorage.getToken(refresh: true),
      });

      if (reissueTokenResponse.statusCode >= 200 &&
          reissueTokenResponse.statusCode <= 206) {
        final Map<String, dynamic> reissueTokenResponseMap =
            jsonDecode(utf8.decode(reissueTokenResponse.bodyBytes));
        tokenStorage.saveToken(token: reissueTokenResponseMap['accessToken']);

        final reResponse = await http.get(url, headers: header);

        if(reResponse.statusCode >= 200 && reResponse.statusCode <= 206) {
          return reResponse;
        } else {
         log('JWT 토큰 재발급 이후 API 재호출 하였으나 실패');
        }
      } else {
        log('JWT 토큰 재발급 실패');
        await tokenStorage.deleteToken();
        await tokenStorage.deleteToken(refresh: true);
        Get.offAll(const Login());
      }
    } else {
      log('만료 이외의 JWT 인증 실패 : ${response.statusCode}');
      await tokenStorage.deleteToken();
      await tokenStorage.deleteToken(refresh: true);
      Get.offAll(const Login());
    }
  } catch (e) {
    log('[JWT UTIL FUNC] 에러 발생: $e');
  }
  return null;
}

Future<http.Response?> jwtPostRequest(
    {Map<String, String>? header, required Uri url, required Map<String, String> body}) async {
  TokenStorage tokenStorage = TokenStorage();

  header ??= <String, String>{};

  header['Content-Type'] = 'application/json; charset=UTF-8';
  header['Authorization'] = 'Bearer ${await tokenStorage.getToken()}';

  try {
    final response = await http.post(url, headers: header, body: jsonEncode(body));

    if (response.statusCode >= 200 && response.statusCode <= 206) {
      return response;
    } else if (response.statusCode == 4004) {
      // access token 만료
      final reissueUrl = Uri.parse('${Config.domain}/auth/reissue-token');

      final reissueTokenResponse = await http.post(reissueUrl, body: {
        'accessToken': tokenStorage.getToken(),
        'refreshToken': tokenStorage.getToken(refresh: true),
      });

      if (reissueTokenResponse.statusCode >= 200 &&
          reissueTokenResponse.statusCode <= 206) {
        final Map<String, dynamic> reissueTokenResponseMap =
        jsonDecode(utf8.decode(reissueTokenResponse.bodyBytes));
        tokenStorage.saveToken(token: reissueTokenResponseMap['accessToken']);

        final reResponse = await http.post(url, headers: header, body: body);

        if(reResponse.statusCode >= 200 && reResponse.statusCode <= 206) {
          return reResponse;
        } else {
          log('JWT 토큰 재발급 이후 API 재호출 하였으나 실패');
        }
      } else {
        log('JWT 토큰 재발급 실패');
        await tokenStorage.deleteToken();
        await tokenStorage.deleteToken(refresh: true);
        Get.offAll(const Login());
      }
    } else {
      log('만료 이외의 JWT 인증 실패 : ${response.statusCode}');
      await tokenStorage.deleteToken();
      await tokenStorage.deleteToken(refresh: true);
      Get.offAll(const Login());
    }
  } catch (e) {
    log('[JWT UTIL FUNC] 에러 발생: $e');
  }
  return null;
}