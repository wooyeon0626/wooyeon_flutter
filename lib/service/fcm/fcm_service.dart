import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:wooyeon_flutter/utils/jwt_utils.dart';
import '../../config/config.dart';

class FcmService {
  static const String baseUrl = Config.domain;

  // POST 요청 : FCM Token
  static Future<void> postFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM Token: $fcmToken');

    if (fcmToken != null) {
      final url = Uri.parse('$baseUrl/api/fcm/save');
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
    } else {
      debugPrint('FCM Token is null error');
    }
  }
}
