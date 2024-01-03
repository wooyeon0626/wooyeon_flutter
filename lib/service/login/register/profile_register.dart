import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:wooyeon_flutter/config/config.dart';

import 'package:wooyeon_flutter/models/pref.dart';

class ProfileRegister {
  Future<bool> sendProfileRequest(List<MultipartFile> profilePhotos) async {
    const url = '${Config.domain}/users/register/profile';

    try {
      Dio dio = Dio();

      log("[JSON]\n${jsonEncode(Pref.instance.profileData?.toJson())}");

      final profileInfoData = MultipartFile.fromString(
        jsonEncode(Pref.instance.profileData?.toJson()),
        contentType: MediaType('application', 'json'),
      );

      FormData formData = FormData.fromMap({
        'profileInfo': profileInfoData,
        'profilePhoto': profilePhotos
      });

      Response response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        log("Upload successful");
        return true;
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
