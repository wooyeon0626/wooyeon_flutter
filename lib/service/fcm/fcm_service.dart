import 'dart:convert';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:wooyeon_flutter/utils/jwt_utils.dart';
import '../../config/config.dart';

class FcmService {
  static const String baseUrl = Config.domain;

  // POST 요청 : FCM Token
  static Future<void> postFcmToken({required String fcmToken}) async {
    final url = Uri.parse('$baseUrl/fcm/token');
    final response = await jwtPostRequest(
      url: url,
      body: <String, String>{
        'fcm_token': fcmToken,
      },
    );

    if (response == null) {
      log('postFcmToken() : response == null 에러 발생');
      throw Error();
    }

    debugPrint(
        'postFcmToken() response : ${jsonDecode(utf8.decode(response.bodyBytes)).toString()}');
  }
}