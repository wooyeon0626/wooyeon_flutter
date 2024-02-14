import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wooyeon_flutter/config/config.dart';

import 'package:wooyeon_flutter/models/pref.dart';
import 'package:http/http.dart' as http;

import '../../../models/token_storage.dart';

class ProfileRegister {
  Future<bool> sendProfileRequest(List<MultipartFile> profilePhotos) async {
    const url = '${Config.domain}/users/register/profile';

    try {
      Dio dio = Dio();
      TokenStorage tokenStorage = TokenStorage();
      dio.options.headers['Content-Type'] = 'application/json; charset=UTF-8';
      dio.options.headers['Authorization'] =
          'Bearer ${await tokenStorage.getToken()}';
      log("${await tokenStorage.getToken()}");

      log("[JSON]\n${jsonEncode(Pref.instance.profileData?.toJson())}");

      final profileInfoData = MultipartFile.fromString(
        jsonEncode(Pref.instance.profileData?.toJson()),
        contentType: MediaType('application', 'json'),
      );

      FormData formData = FormData.fromMap(
          {'profileInfo': profileInfoData, 'profilePhoto': profilePhotos});

      Response response = await dio.post(url, data: formData);

      if (response.statusCode! >= 200 && response.statusCode! <= 206) {
        log("Upload successful");
        return true;
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

          final reResponse = await dio.post(url, data: formData);

          if (reResponse.statusCode! >= 200 && reResponse.statusCode! <= 206) {
            log("re-Upload successful");
            return true;
          } else {
            log('JWT 토큰 재발급 이후 API 재호출 하였으나 실패');
            return false;
          }
        }
        return false;
      } else {
        log("Error during upload: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("Exception occured: $e");
      return false;
    }
  }
}
